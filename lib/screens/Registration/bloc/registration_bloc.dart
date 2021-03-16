import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ases/bloc/authentication_bloc.dart';
import 'package:ases/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegistrationBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(null);

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is RegistrationButtonPressed) {
      yield* mapRegistrationToState(event);
    }
  }

  Stream<RegistrationState> mapRegistrationToState(event) async* {
    yield RegistrationLoading();
    try {
        bool result = await userRepository.signUp(event.username, event.password, event.email);
        if(result) {
          authenticationBloc.add(LoggedIn());
          yield RegistrationSuccess();
        }
        else{
           yield RegistrationFailure(error: "Ошибка регистрации");
        }
    } catch(e) {
      print("ERROR: $e");
      yield RegistrationFailure(error: "Ошибка регистрации");
    }
  }
}
