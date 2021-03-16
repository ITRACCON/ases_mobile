part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
  
  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}
class RegistrationSuccess extends RegistrationState {}
class RegistrationLoading extends RegistrationState {}
class RegistrationFailure extends RegistrationState {
  final String error;

  RegistrationFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' RegistrationFaliure { error: $error }';
}
