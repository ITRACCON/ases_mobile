import 'dart:async';
import 'package:ases/repository/ases_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'matches_event.dart';
part 'matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  final _asesRepository = AsesRepository();
  MatchesBloc() : super(MatchesLoading());

  @override
  Stream<MatchesState> mapEventToState(
    MatchesEvent event,
  ) async* {
    if (event is LiveMatches) {
      yield* _mapGetLiveMatchesToState();
    }
    if (event is UpcomingMatches) {
      yield* _mapGetUpcomingMatchesToState();
    }
  }

  Stream<MatchesState> _mapGetLiveMatchesToState() async* {
    yield MatchesLoading();
    final matchesResult = await _asesRepository.getLiveMatches();
    List matches = matchesResult['result'];
    if (matches != null) {
      yield MatchesInitial(matches);
    } else {
      yield MatchesFailure();
    }
  }

   Stream<MatchesState> _mapGetUpcomingMatchesToState() async* {
    yield MatchesLoading();
    final matchesResult = await _asesRepository.getUpcomingMatches();
    List matches = matchesResult['result'];
    if (matches != null) {
      yield MatchesInitial(matches);
    } else {
      yield MatchesFailure();
    }
  }
}
