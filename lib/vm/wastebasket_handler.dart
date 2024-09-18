import 'package:sqflite/sqflite.dart';
import 'package:todolist_v2/model/wastebasket.dart';
import 'package:todolist_v2/vm/database_handler.dart';

class WastebasketHandler {
  DatabaseHandler handler = DatabaseHandler();
  Future<List<Wastebasket>> querydeleted() async {
    final Database db = await handler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      '''
        select *
        from wastebasket
      '''
    );
    return queryResult.map(
          (e) => Wastebasket.fromMap(e),
        ).toList();
  }

  Future<int> insertdeletedTodoList(Wastebasket deletedtodolist) async {
    final Database db = await handler.initializeDB();
    int result = await db.rawInsert(
      """
          insert into wastebasket(
            todolist_seq, user_seq, title, date, serious, deleteddate
          )
          values (?, ?, ?, ?, ?, ?)
      """, 
      [
        deletedtodolist.todolistSeq,
        deletedtodolist.userSeq,
        deletedtodolist.title,
        deletedtodolist.date,
        deletedtodolist.serious,
        deletedtodolist.deletedDate,
      ]
    );
    return result;
  }


   Future<int> deletedeletedtodoList(int seq) async {
    int result = 0;
    final Database db = await handler.initializeDB();
    result = await db.rawDelete(
        """
          delete from wastebasket
          where seq = ?
        """,
        [
         seq
        ]
      );
      return result;
  }

}