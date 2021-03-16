part of 'matches_bloc.dart';

abstract class MatchesEvent extends Equatable {
  const MatchesEvent();

  @override
  List<Object> get props => [];
}

class LiveMatches extends MatchesEvent {}
class UpcomingMatches extends MatchesEvent {}
class PastMatches extends MatchesEvent {}
