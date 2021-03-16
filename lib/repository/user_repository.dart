import 'dart:async';
import 'package:ases/api_connection/user_api.dart';
import 'package:ases/dao/user_dao.dart';
import 'package:ases/model/user_model.dart';
import 'package:ases/storage/shared_preferences.dart';

class UserRepository {
  final UserDao userDao = UserDao();
  final UserPreferences userPreferences = UserPreferences();

  Future<bool> signIn(String email, String password) async{
    Map userSignIn = {'email':email, 'password': password}; 

    Map result = await signInApi(userSignIn);
    int status = result['status'];
    Map body = result['body'];
    if(status == 200 && body['error'] == null)
    {
      Map user_bd = body['user'];
      User user = User(username: user_bd['username'], email: user_bd['email'], image: user_bd['image']);
      await userDao.createUser(user);
      print("SUCCESS");
      userPreferences.savePref('auth', true);
      return true;
    }
    else {
      print("FAIL");
      return false;
    }
  }

  Future<bool> signUp(String username, String password, String email) async{
    Map userSignIn = {'email':email, 'password': password, 'username': username}; 

    Map result = await signUpApi(userSignIn);
    int status = result['status'];
    Map body = result['body'];
    if(status == 200 && body['error'] == null)
    {
      Map user_bd = body['user'];
      User user = User(username: user_bd['username'], email: user_bd['email'], image: user_bd['image']);
      await userDao.createUser(user);
      print("SUCCESS");
      userPreferences.savePref('auth', true);
      return true;
    }
    else {
      print("FAIL");
      return false;
    }
  }

   // получаем пользоватя из локальной базы
  Future<User> getUser() async {
    User user = await userDao.getUser();
    return user;
  }

     // получаем пользоватя из локальной базы
  Future logout() async {
    await userDao.logout();
    userPreferences.savePref('auth', false);
  }
}
