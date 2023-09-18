import 'dart:io';
import 'package:news_app/features/daily_news/data/data_sources/local/i_local_database.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper implements ILocalDatabase {
  late Database _db;
  late Directory _appDirPath;
  final _dbName = "news.db";
  final _tableName = "NEWS_ARTICLES";

  DatabaseHelper() {
    createDatabase();
  }

  @override
  Future<Database> createDatabase() async {
    _appDirPath = await getApplicationDocumentsDirectory();
    String path = join(_appDirPath.path, _dbName);
    _db = await openDatabase(
      path,
      version: 1,
    );
    createSchema(db: _db);
    return _db;
  }

  @override
  Future<void> createSchema({required Database db}) async {
    return await _db.execute("""
CREATE TABLE IF NOT EXISTS $_tableName(
  ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  Author  TEXT,
  Title TEXT,
  Description TEXT,
  Url TEXT,
  UrlToImage TEXT,
  PublishedAt TEXT,
  Content TEXT,
  SourceId TEXT,
  SourceName TEXT
)
""");
  }

  @override
  Future<List<Map<String, dynamic>>> getNewsArticles() async {
    return _db.query(_tableName, orderBy: "ID");
  }

  @override
  removeNewsArticles() async {
    _db.delete("NEWS_ARTICLES");
  }

  @override
  saveNewsArticles({
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String sourceId,
    required String sourceName,
    required String content,
  }) async {
    final data = {
      "Author": author,
      "Title": title,
      "Description": description,
      "Url": url,
      "UrlToImage": urlToImage,
      "PublishedAt": publishedAt,
      "Content": content,
      "SourceId": sourceId,
      "SourceName": sourceName,
    };
    final id = await _db.insert(_tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  @override
  updateNewsArticles({
    required num id,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? sourceId,
    String? sourceName,
    String? content,
  }) async {
    final data = {
      "Author": author,
      "Title": title,
      "Description": description,
      "Url": url,
      "UrlToImage": urlToImage,
      "PublishedAt": publishedAt,
      "Content": content,
      "SourceId": sourceId,
      "SourceName": sourceName,
    };

    final result = await _db.update(
      _tableName,
      data,
      where: "id = ?",
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }
}
