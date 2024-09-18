import 'package:todolist_v2/model/searchtodo.dart';
import 'package:todolist_v2/vm/database_handler.dart';
import 'package:todolist_v2/vm/donetodolist_handler.dart';
import 'package:todolist_v2/vm/todolist_handler.dart';

class SearchtodoHandler {
  DatabaseHandler handler = DatabaseHandler();
  
  Future<List<Searchtodo>> searchtodo(String keyword) async {
    List<Searchtodo> result = [];
    TodolistHandler todolistHandler = TodolistHandler();
    DonetodolistHandler donetodolistHandler = DonetodolistHandler();
    
    List<Searchtodo> result1 = await donetodolistHandler.querysearchdone(keyword);
    List<Searchtodo> result2 = await todolistHandler.querysearchtodo(keyword);
    result.addAll(result1);
    result.addAll(result2);
    return result;
  }


}