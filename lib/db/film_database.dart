import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/film.dart';

class FilmDatabase {
  static final FilmDatabase instance = FilmDatabase._init();

  static Database? _database;

  FilmDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('films.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableFilm ( 
  ${FilmFields.id} $idType, 
  ${FilmFields.title} $textType,
  ${FilmFields.description} $textType,
  ${FilmFields.gambar} $textType,
  ${FilmFields.time} $textType
  )
''');
  }

  Future<Film> create(Film film) async {
    final db = await instance.database;

    final id = await db.insert(tableFilm, film.toJson());
    return film.copy(id: id);
  }

  Future<Film> readFilm(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFilm,
      columns: FilmFields.values,
      where: '${FilmFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Film.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Film>> readAllFilms() async {
    final db = await instance.database;

    const orderBy = '${FilmFields.time} ASC';

    final result = await db.query(tableFilm, orderBy: orderBy);

    return result.map((json) => Film.fromJson(json)).toList();
  }

  Future<int> update(Film film) async {
    final db = await instance.database;

    return db.update(
      tableFilm,
      film.toJson(),
      where: '${FilmFields.id} = ?',
      whereArgs: [film.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableFilm,
      where: '${FilmFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
