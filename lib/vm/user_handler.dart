import 'package:sqflite/sqflite.dart';
import 'package:todolist_v2/model/user.dart';
import 'package:todolist_v2/vm/database_handler.dart';

class UserHandler {
  DatabaseHandler handler = DatabaseHandler();
  Future<List<User>> queryUser() async {
    final Database db = await handler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery('''
          select *
          from user
          ''');
    print(queryResult);      
    return queryResult.map(
          (e) => User.fromMap(e),
        ).toList();
  }

  Future<int> initUser() async {
    int result = 0;
    final Database db = await handler.initializeDB();
    result = await db.rawInsert("""
          insert into user(
            id, name, password, purchased
          )
          values (?, ?, ?, ?)
        """, ["guest", "guest", "guest", "F"]);
    return result;
  }
}
