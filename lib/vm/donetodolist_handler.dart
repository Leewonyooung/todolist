import 'package:sqflite/sqflite.dart';
import 'package:todolist_v2/model/donetodolist.dart';
import 'package:todolist_v2/model/todolist.dart';
import 'package:todolist_v2/vm/database_handler.dart';

class DonetodolistHandler {
  DatabaseHandler handler = DatabaseHandler();

  Future<List<Donetodolist>> querydoneTodoList(String date) async {
    final Database db = await handler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery('''
          select *
          from donetodolist
          where date = "$date"
          ''');
    return queryResult.map((e) => Donetodolist.fromMap(e),).toList();
  }

  Future<List<TodoList>> querysearchdone(String keyword) async {
    final Database db = await handler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery('''
          select 
                *
          from donetodolist
          where 
                date like "%$keyword%" or
                title like "%$keyword%"
          ''');
    return queryResult.map((e) => TodoList.fromMap(e)).toList();
  }


  Future<int> querydoneTodoListCount(date) async {
    final Database db = await handler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery('''
          select count(*)
          from donetodolist
          where date = "$date"
          ''');
    int result = int.parse(queryResult[0]['count(*)'].toString());
    return result;
  }

  Future<int> insertdoneTodoList(Donetodolist donetodolist) async {
    final Database db = await handler.initializeDB();
    int result = await db.rawInsert("""
          insert into donetodolist(
            todolist_seq, user_seq, title, date, serious, donedate
          )
          values (?, ?, ?, ?, ?, ?)
        """, [
          donetodolist.todolistSeq,
          donetodolist.userSeq,
          donetodolist.title,
          donetodolist.date,
          donetodolist.serious,
          donetodolist.doneDate
        ]
    );
    return result;
  }


  Future<int> deletedonetodoList(int seq) async {
    int result = 0;
    final Database db = await handler.initializeDB();
    result = await db.rawDelete(
        """
          delete from donetodolist
          where seq = ?
        """,
        [
         seq
        ]
      );
    return result;
  }

}
