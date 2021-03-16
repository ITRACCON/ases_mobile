import 'package:http/http.dart' as http;
import 'dart:convert';

const url = 'http://195.2.78.135:3002/ases_api';

Future<Map> getMatchApi(urlMatch) async{
    print(urlMatch);
 
  // Starting Web API Call.
  var response = await http.post('$url/get_match', body: {'url': urlMatch});
  
  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}

Future<Map> getMatchAnalitikApi(urlMatch) async{
 
  // Starting Web API Call.
  var response = await http.post('$url/analitik', body: {'url': urlMatch});
  
  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}

Future<Map> getUpcomingMatchesApi() async{
 
  // Starting Web API Call.
  var response = await http.get('$url/upcoming_matches');
  
  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}

Future<Map> getLiveMatchesApi() async{
  // Starting Web API Call.
  var response = await http.get('$url/live_matches');
  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}