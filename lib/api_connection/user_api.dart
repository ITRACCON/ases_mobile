
import 'package:http/http.dart' as http;
import 'dart:convert';

const url = 'https://asesflutter.000webhostapp.com';

Future<Map> signInApi(userSignIn) async{
 
  // Starting Web API Call.
  var response = await http.post('$url/sign_in.php', body: json.encode(userSignIn));
  
  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}

Future<Map> signUpApi(userSignUp) async{
 
  // Starting Web API Call.
  var response = await http.post('$url/sign_up.php', body: json.encode(userSignUp));
  
  print("RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

  Map result = {'status': response.statusCode, 'body': json.decode(response.body)};

  return result;
}