part of 'match_bloc.dart';

abstract class MatchState extends Equatable {
  const MatchState();

  @override
  List<Object> get props => [];
}

class MatchInitial extends MatchState {
  final List match;

  MatchInitial(this.match);
}

class MatchAnalitikInitial extends MatchState {
  final List analitik;

  MatchAnalitikInitial(this.analitik);
}

class MatchLoading extends MatchState {}

class MatchFailure extends MatchState {}
