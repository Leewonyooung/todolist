import 'package:sqflite/sqflite.dart';
import 'package:todolist_v2/model/searchtodo.dart';
import 'package:todolist_v2/model/todolist.dart';
import 'package:todolist_v2/vm/database_handler.dart';

class TodolistHandler {
  DatabaseHandler handler = DatabaseHandler();

  Future<List<TodoList>> queryTodoList() async {
    final Database db = await handler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      '''
          select *
          from todolist
      '''
    );
    return queryResult
        .map(
          (e) => TodoList.fromMap(e),
        )
        .toList();
  }

  Future<List<TodoList>> queryTodoListbyDate(String date) async {
    final Database db = await handler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      '''
          select *
          from todolist
          where date = '$date'
                ORDER by serious DESC
      '''
    );
    return queryResult.map(
          (e) => TodoList.fromMap(e),
        ).toList();
  }

  Future<int> queryTodoListcount(String date) async {
    final Database db = await handler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      '''
          select count(seq) 
          from todolist
          where date = "$date"
      '''
    );
    int result = int.parse(queryResult[0]['count(seq)'].toString());
    return result;
  }

  Future<List<Searchtodo>> querysearchtodo(String keyword) async {
    final Database db = await handler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      '''
          select seq, title, date
          from todolist
          where date like "%$keyword%" 
                or title like "%$keyword%"
      '''
    );
    return queryResult.map(
          (e) => Searchtodo.fromMap(e),
        ).toList();
  }



  Future<int> queryTodoListseriouscount(String date) async {
    final Database db = await handler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      '''
          select count(serious)
          from todolist
          where date = "$date" 
                and serious = "${1}"
      '''
    );
    int result = int.parse(queryResult[0]['count(serious)'].toString());
    return result;
  }

Future<List<TodoList>> queryTodoListfuture(String date) async {
    final Database db = await handler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      '''
          select count(*)
          from todolist
          where date = "$date"
      '''
    );
    return queryResult.map(
          (e) => TodoList.countfromMap(e),
        ).toList();
  }

  Future<int> insertTodoList(TodoList todolist) async {
    final Database db = await handler.initializeDB();
    int result = await db.rawInsert(
      """
          insert into todolist(
            title, date, serious, done
          )
          values (?, ?, ?, ?)
      """, 
      [
        todolist.title,
        todolist.date,
        todolist.serious,
        0
      ]
    );
    return result;
  }

  Future<int> updateSerious(TodoList todoList) async{
    int result = 0;
    final Database db = await handler.initializeDB();
    result = await db.rawUpdate(
      """
          update todolist
          set serious = ?
          where seq = ?
      """,
      [
        todoList.serious == 1 ? 0 : 1, 
        todoList.seq
      ]
    );
    return result;
  }

  Future<int> updatetodoList(TodoList todoList) async{
    int result = 0;
    final Database db = await handler.initializeDB();
    result = await db.rawUpdate(
      """
          update todolist
          set 
            title = ?,
            date = ?,
            serious = ?
          where 
            seq = ?
      """,
      [
        todoList.title,
        todoList.date,
        todoList.serious, 
        todoList.seq
      ]
    );
    return result;
  }


  Future<int> deletetodoList(int seq) async {
    int result = 0;
    final Database db = await handler.initializeDB();
    result = await db.rawDelete(
        """
          delete from todolist
          where seq = ?
        """,
        [
         seq
        ]
      );
      return result;
  }

}
