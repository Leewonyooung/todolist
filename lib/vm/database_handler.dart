import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'todo.db'),
      onCreate: (db, version) async {
        await db.execute("""
            CREATE TABLE user (
            `seq` integer primary key autoincrement,
            `id` VARCHAR(45) NULL,
            `name` VARCHAR(45) NULL,
            `password` VARCHAR(45) NULL,
            `purchased` VARCHAR(45) NULL
            )
        """);
        await db.execute("""
             CREATE TABLE `todolist` (
            `seq` integer primary key autoincrement,
            `title` TEXT NULL,
            `date` TEXT NULL,
            `serious` INT NULL,
            `done` INT NULL
            )
        """);
        await db.execute("""
            CREATE TABLE `donetodolist` (
            `seq` integer primary key autoincrement,
            `todolist_seq` INT NULL,
            `user_seq` INT NULL,
            `title` TEXT NULL,
            `date` TEXT NULL,
            `serious` INT NULL,
            `donedate` TEXT NULL
            )
        """);
        await db.execute("""
           CREATE TABLE `wastebasket` (
            `seq` integer primary key autoincrement,
            `todolist_seq` INT NULL,
            `user_seq` INT NULL,
            `title` TEXT NULL,
            `date` TEXT NULL,
            `serious` INT NULL,
            `deleteddate` TEXT NULL
            )
        """);
      },
      version: 1,
    );
  }
}
