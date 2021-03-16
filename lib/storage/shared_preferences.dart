import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  SharedPreferences sharedPreferences;

  /// Дефолтные значения
  bool resultLoadBool = false;
  String resultLoadString = '';
  int resultLoadInt = 0;
  double resultLoadDouble = 0;
  List<String> resultLoadList = [];

  Future savePref(field, value) async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (value is bool) {
      sharedPreferences.setBool(field, value);
    } else if (value is String) {
      sharedPreferences.setString(field, value);
    } else if (value is int) {
      sharedPreferences.setInt(field, value);
    } else if (value is double) {
      sharedPreferences.setDouble(field, value);
    } else if (value is List<String>) {
      sharedPreferences.setStringList(field, value);
    }
  }

  Future<bool> loadBool(field) async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool result = sharedPreferences.getBool(field);
    return result;
  }

  Future<String> loadString(field) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String result = sharedPreferences.getString(field);
    return result;
  }

  Future<List<String>> loadList(String field) async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<String> result = sharedPreferences.getStringList(field);
    return result;
  }

  setDataBool(field) {
    loadBool(field).then((value) {
      resultLoadBool = value;
    });
    return resultLoadBool;
  }

  Future<void> remove(String field) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(field);
  }

  Future<void> removeAll() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List keys = sharedPreferences.getKeys().toList();
    keys.forEach((element) {
      sharedPreferences.remove(element);
    });
  }

  Future<List> getKeys() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getKeys().toList();
  }
}
