import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class MovieDatabaseService {
  static final String tableName = 'movieReview';
  static final MovieDatabaseService instance = MovieDatabaseService._init();
  static Database? _database;

  MovieDatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movie.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    await db.execute('''
    CREATE TABLE $tableName ( 
      id_movie $textType,
      username_movie $textType,
      userid_movie $textType,
      userimage_movie $textType,
      review_movie $textType,
      rate_movie $integerType
      )
    ''');
  }

  Future<int> create({required Map<String, dynamic> value}) async {
    final db = await instance.database;
    return await db.insert(tableName, value);
  }

  Future<List<Map<String, dynamic>>> getList() async {
    final db = await instance.database;
    final result = await db.query(tableName);
    return result;
  }

  Future<int> update({required Map<String, dynamic> map}) async {
    final db = await instance.database;
    return db.update(
      tableName,
      map,
    );
  }

  Future<int> delete({required int id}) async {
    final db = await instance.database;

    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
