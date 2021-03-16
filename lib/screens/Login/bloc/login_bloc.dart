import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ases/bloc/authentication_bloc.dart';
import 'package:ases/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(null);

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield* mapLoginToState(event);
    }
  }

  Stream<LoginState> mapLoginToState(event) async* {
    yield LoginLoading();
    print("LoGIN: ${event.email} PASS: ${event.password}" );
    try {
          bool result = await userRepository.signIn(event.email, event.password);
         if(result) {
         authenticationBloc.add(LoggedIn());
         yield LoginSuccess();
        }
        else{
           yield LoginFailure(error: "Ошибка авторизации");
        }
       
    } catch(e) {
      print("ERROR: $e");
      yield LoginFailure(error: "Ошибка авторизации");
    }
  }
}
