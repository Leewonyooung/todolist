import 'package:sqflite/sqflite.dart';
import 'package:todolist_v2/model/todolist.dart';
import 'package:todolist_v2/vm/database_handler.dart';
import 'package:todolist_v2/vm/donetodolist_handler.dart';
import 'package:todolist_v2/vm/todolist_handler.dart';

class StateHandler {
  DatabaseHandler handler = DatabaseHandler();

  Future<List<TodoList>> queryState() async {
    final Database db = await handler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      '''
          select *
          from todolist todo, donetodolist done
      '''
    );
    return queryResult.map((e) => TodoList.fromMap(e),).toList();
  }

  Future<(int, int, int)> getState(date) async{
    TodolistHandler todolistHandler = TodolistHandler();
    DonetodolistHandler donetodolistHandler = DonetodolistHandler();
    int todayCount = await todolistHandler.queryTodoListcount(date);
    int seriousCount = await todolistHandler.queryTodoListseriouscount(date);
    int doneCount = await donetodolistHandler.querydoneTodoListCount(date);
    return (todayCount, seriousCount, doneCount);
  }
}