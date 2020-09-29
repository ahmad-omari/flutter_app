import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:flutter_app/user.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async{
    if(_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(),'user_info.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user(
            PHONE_NO TEXT PRIMARY KEY, PASSWORD TEXT, FULL_NAME TEXT, GENDER TEXT, DOB TEXT, IMAGE TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  addUser(User addUser) async{
    final db = await database;
    var res = await db.rawInsert('''
      INSERT INTO user(
            PHONE_NO, PASSWORD, FULL_NAME, GENDER, DOB, IMAGE
          ) VALUES (? , ? , ? , ? , ? , ?)
    ''',
    [addUser.PHONE_NO, addUser.PASSWORD, addUser.FULL_NAME, addUser.GENDER, addUser.DOB, addUser.IMAGE]);
    return res;
  }

  Future<List<dynamic>> getUser() async{
    final db = await database;
    List<dynamic> res = await db.query("user");
    if(res.length == 0){
      return null;
    }else{
      var resMap = res;
      return resMap.isNotEmpty ? resMap : null;
    }
  }
}
