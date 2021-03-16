part of 'matches_bloc.dart';

abstract class MatchesState extends Equatable {
  const MatchesState();

  @override
  List<Object> get props => [];
}

class MatchesInitial extends MatchesState {
  final List matches;

  MatchesInitial(this.matches);
}

class MatchesLoading extends MatchesState {}

class MatchesFailure extends MatchesState {}
