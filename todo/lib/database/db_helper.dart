import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//this is at the service level
class DBHelper {
  //singleton class instance - can create only one instance
  static final DBHelper dbHero = DBHelper._internal();
  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    //if db is alredy initialized it returns otherwise call to initDb
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        createdAt TEXT NOT NULL,
        isCompleted INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertDb(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert('todos', row);
  }

  Future<List<Map<String, dynamic>>> readDb() async {
    final db = await database;
    return await db.query('todos');
  }

  Future<int> updateDb(Map<String, dynamic> row) async {
    final db = await database;
    int id = row['id'];
    return await db.update(
      'todos',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteDb(int id) async {
    final db = await database;
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
