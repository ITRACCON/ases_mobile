import 'dart:async';
import 'package:ases/api_connection/ases_api.dart';

class AsesRepository {
 
 // получаем пользоватя из локальной базы
  Future<Map> getMatch(url) async {
    print(2222);
    Map match = await getMatchApi(url);
    return match["body"];
  }

// получаем пользоватя из локальной базы
  Future<Map> getMatchAnalitik(url) async {
    Map matchAnalitik = await getMatchAnalitikApi(url);
    return matchAnalitik["body"];
  }

   // получаем пользоватя из локальной базы
  Future<Map> getUpcomingMatches() async {
    Map upcomingMatches = await getUpcomingMatchesApi();
    return upcomingMatches["body"];
  }

   // получаем пользоватя из локальной базы
  Future<Map> getLiveMatches() async {
    Map upcomingMatches = await getLiveMatchesApi();
    return upcomingMatches["body"];
  }
   
}
