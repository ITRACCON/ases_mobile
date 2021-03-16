part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationUnintialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final User user;
  const AuthenticationAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationSync extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

