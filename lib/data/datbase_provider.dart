import 'dart:io';

import 'package:bluestack_assignment/model/user_modal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'app.db');

    return await openDatabase(path, version: 1, onOpen: (db) async {
    }, onCreate: (Database db, int version) async {
      await db.execute('''
                CREATE TABLE user(
                    id INTEGER PRIMARY KEY,
                    user_name TEXT UNIQUE,
                    password TEXT,
                    name TEXT,
                    profile_pic TEXT DEFAULT '',
                    rating INTEGER DEFAULT 0,
                    tournament_played INTEGER DEFAULT 0,        
                    tournament_won INTEGER DEFAULT 0                    
                )
            ''');
    });
  }

  Future<int> createUser(User user) async {
    final db = await database;
    var res = await db!.insert('user', user.toJson());

    return res;
  }

  Future<int> loginUser(String userName, String password,void inner(int login_id)) async {
    final db = await database;
    List<Map> results = await db!.query("user",
        columns: ["id"],
        where: 'user_name = ? AND password = ?',
        whereArgs: [userName,password]);

    if (results.length > 0) {
      inner(results.first['id']);
      return results.first['id'];
    }
    inner(0);
    return 0;
  }

  Future<bool> isExistUser(String user_name,inner(bool isExist)) async {
    final db = await database;
    List<Map> results = await db!.query("user",
        columns: ["id", "user_name", "name", "profile_pic", "rating", "tournament_played", "tournament_won"],
        where: 'user_name = ?',
        whereArgs: [user_name]);

    if (results.length > 0) {
      inner(true);
      return true;
    }
    inner(false);
    return false;
  }

  Future<User> getUser(int? id,inner(User _user)) async {
    final db = await database;
    List<Map> results = await db!.query("user",
        columns: ["id", "user_name", "name", "profile_pic", "rating", "tournament_played", "tournament_won"],
        where: 'id = ?',
        whereArgs: [id]);

    if (results.length > 0) {
      inner(new User.fromJson(results.first));
      return new User.fromJson(results.first);
    }

    inner(new User(id: 0, user_name: " ", password: "", name: "", profile_pic: "", rating: 0, tournament_played: 0, tournament_won: 0));
    return new User(id: 0, user_name: " ", password: "", name: "", profile_pic: "", rating: 0, tournament_played: 0, tournament_won: 0);
  }

  Future<List> getUsers() async {
    final db = await database;
    var result = await db!.query("user", columns: ["id", "name", "profile_pic", "rating"]);

    return result.toList();
  }

  dispose() async {
    final db = await database;
    await db!.close();
  }

}