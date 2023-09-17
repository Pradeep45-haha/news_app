import 'package:sqflite/sqflite.dart';

abstract class ILocalDatabase {
  dynamic createDatabase();
  Future<void> createSchema(Database database);
  Future<List<Map<String, dynamic>>> getNewsArticles();
  dynamic removeNewsArticles();
  Future<int> saveNewsArticles({ required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String sourceId,
    required String sourceName,
    required String content,});
  Future<int> updateNewsArticles({required int id});
}
