import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/infrastructure/model/todo_model.dart';
import 'package:todo_list/infrastructure/utills/snackbar.util.dart';

class DatabaseService {

  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'todoList_database.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, status TEXT)',
    );
  }

  Future<void> insertTodo(TodoModel todo) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    await db.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ).onError((error, stackTrace) => throw Exception('${error}'));

  }

  Future<List<TodoModel>> getTodoList() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    final List<Map<String, dynamic>> maps = await db.query('todo');

    return List.generate(maps.length, (index) => TodoModel.fromMap(maps[index]));
  }

  Future<TodoModel> getIndividualTodo(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('todo', where: 'id = ?', whereArgs: [id]);
    return TodoModel.fromMap(maps[0]);
  }

  Future<void> updateTodo(TodoModel todo,id) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    await db.update(
      'todo',
      todo.toMap(),

      where: 'id = ?',
      whereArgs: [id],
    ).onError((error, stackTrace) => throw Exception('Something went wrong'));
  }

  Future<void> deleteTodo(int id) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    await db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
