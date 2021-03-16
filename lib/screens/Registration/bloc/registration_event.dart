part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegistrationButtonPressed extends RegistrationEvent {
  final String username;
  final String password;
  final String email;

  const RegistrationButtonPressed({@required this.username, @required this.password, @required this.email});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() => 'RegistrationButtonPressed { username: $username, password: $password, email: $email }';
}
