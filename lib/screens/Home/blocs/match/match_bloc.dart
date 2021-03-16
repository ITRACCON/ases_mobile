import 'dart:async';
import 'package:ases/repository/ases_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final _asesRepository = AsesRepository();
  MatchBloc() : super(MatchLoading());

  @override
  Stream<MatchState> mapEventToState(
    MatchEvent event,
  ) async* {
    if (event is GetMatch) {
      yield* _mapGetMatchToState(event.url);
    }
    if (event is MatchAnalitik) {
      yield* _mapGetMatchAnalitikToState(event.url);
    }
  }

  Stream<MatchState> _mapGetMatchToState(url) async* {
    yield MatchLoading();
    print(1111);
    final matchResult = await _asesRepository.getMatch(url);
    List match = matchResult['result'];
    if (match != null) {
      yield MatchInitial(match);
     print("2222");
    } else {
      yield MatchFailure();
    }
  }

   Stream<MatchState> _mapGetMatchAnalitikToState(url) async* {
    yield MatchLoading();
    final matchAnalitikResult = await _asesRepository.getMatchAnalitik(url);
    List matchAnalitik = matchAnalitikResult['result'];
    final matchResult = await _asesRepository.getMatch(url);
    List match = matchResult['result'];
    List matchAnalitik1 = [matchAnalitik, match];
    if (matchAnalitik1 != null) {
      yield MatchAnalitikInitial(matchAnalitik1);
     print("2222");
    } else {
      yield MatchFailure();
    }
  }
}
