import 'package:ases/database/actos_database.dart';
import 'package:ases/model/user_model.dart';

const TABLE_NAME = "user";
const int POINTS = 100;

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<void> createUser(User newUser) async {
    final db = await dbProvider.database;
    await db.delete('user');
    int result = await db.insert('user', newUser.toDatabaseJson());
    print("INSERT USER: $result");
  }

  Future<bool> updateUser(field, value) async {
    final db = await dbProvider.database;
    try {
      String sql = "UPDATE $TABLE_NAME SET '$field' = '$value'";
      await db.rawUpdate(sql);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map> getUserInfo() async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db.rawQuery('SELECT email, username FROM $TABLE_NAME');
      return users.first;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    final db = await dbProvider.database;
    await db.delete(TABLE_NAME);
  }

  Future<bool> checkUser() async {
    final db = await dbProvider.database;
    try {
      List<Map> users = await db.query(TABLE_NAME);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<User> getUser() async {
    try {
      final db = await dbProvider.database;
      List<Map> users = await db.query('user');
      if (users.length > 0) {
        return User.fromDatabaseJson(users.first);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Map> getLevelUser() async {
    try {
      final db = await dbProvider.database;
      List<Map> getUsers = await db.rawQuery(
          "SELECT level_percent, level_id, level_score FROM $TABLE_NAME");
      List getMaxScore = await db.rawQuery('''
        SELECT max_score, min_score, name FROM levels
        WHERE id = '${getUsers.first["level_id"]}'
      ''');
      Map user = getUsers.first;
      int maxScore = getMaxScore.first['max_score'];
      int minScore = getMaxScore.first['min_score'];
      String name = getMaxScore.first['name'];
      Map userLevel = {
        ...user,
        'max_score': maxScore,
        'name': name,
        'min_score': minScore
      };
      return userLevel;
    } catch (e) {
      print('ERROR_GET_LEVEL_USER $e');
      return null;
    }
  }

  Future<bool> getUserAds() async {
    try {
      final db = await dbProvider.database;
      List userAdsDb = await db.rawQuery("SELECT paymentStatus FROM $TABLE_NAME");
      bool userAds = userAdsDb.length > 0
          ? userAdsDb[0]['paymentStatus'] == 1
              ? true
              : false
          : false;
      return userAds;
    } catch (e) {
      return null;
    }
  }

  Future<String> getPhotoUser() async {
    try {
      final db = await dbProvider.database;
      List userPhoto =
          await db.rawQuery("SELECT image_path_link FROM $TABLE_NAME");
      String photo =
          userPhoto.length > 0 ? userPhoto[0]['image_path_link'] : null;
      return photo;
    } catch (e) {
      return null;
    }
  }

  Future<List> getTimeActiveUser() async {
    try {
      final db = await dbProvider.database;
      List userTimeActive =
          await db.rawQuery("SELECT time_active FROM $TABLE_NAME");
      List timeActive = userTimeActive.length > 0
          ? userTimeActive[0]['time_active'].split(",")
          : null;
      return timeActive;
    } catch (e) {
      return null;
    }
  }

  Future<bool> changeUserScore(value) async {
    final db = await dbProvider.database;
    try {
      List user = await db.rawQuery('SELECT level_score from $TABLE_NAME');
      int score = value
          ? user.first['level_score'] + POINTS
          : user.first['level_score'] - POINTS;
      await db.rawUpdate('UPDATE $TABLE_NAME SET level_score = $score');
      return true;
    } catch (e) {
      print('ERROR_CHANGE_USER_SCORE $e');
      return false;
    }
  }
}
