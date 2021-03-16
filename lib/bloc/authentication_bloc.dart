import 'dart:async';

import 'package:ases/model/user_model.dart';
import 'package:ases/storage/shared_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:ases/repository/user_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final UserPreferences userPreferences = UserPreferences();

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(null);
  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }

    if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }

    if (event is Login) {
      yield* _mapLoginToState();
    }

    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    yield AuthenticationUnintialized();
    await Future.delayed(Duration(seconds: 4));
    bool auth = await userPreferences.loadBool('auth') ?? false;
    if (auth) {
       final User user = await _userRepository.getUser();
      if (user != null) {
        yield AuthenticationAuthenticated(user);
      } else {
        yield AuthenticationUnauthenticated();
      }
    } else {
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield AuthenticationSync();
    final User user = await _userRepository.getUser();
    print("USER: ${user.toDatabaseJson()}");
    if (user != null) {
      yield AuthenticationAuthenticated(user);
    } else {
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoginToState() async* {
    yield AuthenticationUnauthenticated();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield AuthenticationLoading();
    await deleteUser();
    yield AuthenticationUnauthenticated();
  }

  Future<void> deleteUser() async {
    //await _userRepository.deleteUser();
  }
}

