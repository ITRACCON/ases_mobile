part of 'match_bloc.dart';

abstract class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

class GetMatch extends MatchEvent {
  final url;
  GetMatch({this.url});
}
class MatchAnalitik extends MatchEvent {
  final url;
  MatchAnalitik({this.url});
}

