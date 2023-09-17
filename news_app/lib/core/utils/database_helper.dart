import 'package:news_app/core/resources/i_local_database.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper implements ILocalDatabase {
//   static Future<void> createTable(Database database) async {
//     return await database.execute("""
// CREATE TABLE NEWS_ARTICLES(
//   ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//   Author  TEXT,
//   Title TEXT,
//   Description TEXT,
//   Url TEXT,
//   UrlToImage TEXT,
//   PublishedAt TEXT,
//   Content TEXT,
//   SourceId TEXT,
//   SourceName TEXT
// )
// """);
//   }

//   static Future<Database> db() async {
//     return openDatabase(
//       "news.db",
//       version: 1,
//       onCreate: (db, version) async {
//         return await createTable(db);
//       },
//     );
//   }

//   static Future<int> postNewsArticle({
//     required String author,
//     required String title,
//     required String description,
//     required String url,
//     required String urlToImage,
//     required String publishedAt,
//     required String sourceId,
//     required String sourceName,
//     required String content,
//   }) async {
//     final db = await SqlHelper.db();
//     final data = {
//       "Author": author,
//       "Title": title,
//       "Description": description,
//       "Url": url,
//       "UrlToImage": urlToImage,
//       "PublishedAt": publishedAt,
//       "Content": content,
//       "SourceId": sourceId,
//       "SourceName": sourceName,
//     };
//     final id = await db.insert("NEWS_ARTICLES", data,
//         conflictAlgorithm: ConflictAlgorithm.replace);
//     return id;
//   }

//   static Future<List<Map<String, dynamic>>> getNewsArticles() async {
//     final db = await SqlHelper.db();
//     return db.query("NEWS_ARTICLES", orderBy: "ID");
//   }

//   static Future<List<Map<String, dynamic>>> getNewsArticle(
//       {required num id}) async {
//     final db = await SqlHelper.db();
//     return db.query("NEWS_ARTICLES", where: "id =?", whereArgs: [id], limit: 1);
//   }

//   static Future<void> deleteNewArticles() async {
//     final db = await SqlHelper.db();
//     db.delete("NEWS_ARTICLES");
//   }

//   static Future<int> updateNewsArticle({
//     required num id,
//     String? author,
//     String? title,
//     String? description,
//     String? url,
//     String? urlToImage,
//     String? publishedAt,
//     String? sourceId,
//     String? sourceName,
//     String? content,
//   }) async {
//     final db = await SqlHelper.db();
//     final data = {
//       "Author": author,
//       "Title": title,
//       "Description": description,
//       "Url": url,
//       "UrlToImage": urlToImage,
//       "PublishedAt": publishedAt,
//       "Content": content,
//       "SourceId": sourceId,
//       "SourceName": sourceName,
//     };

//     final result = await db.update(
//       "NEWS_ARTICLES",
//       data,
//       where: "id = ?",
//       whereArgs: [id],
//     );
//     return result;
//   }

//   static Future<void> deleteNewsArticle({required num id}) async {
//     final db = await SqlHelper.db();
//     try {
//       await db.delete("NEWS_ARTICLES", where: "id = ?", whereArgs: [id]);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
  ///////

  @override
  Future<void> createSchema(Database database) async {
    return await database.execute("""
CREATE TABLE NEWS_ARTICLES(
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
    final db = await createDatabase();
    return db.query("NEWS_ARTICLES", orderBy: "ID");
  }

  @override
  Future<Database> createDatabase() {
    return openDatabase(
      "news.db",
      version: 1,
      onCreate: (db, version) async {
        return await createSchema(db);
      },
    );
  }

  @override
  removeNewsArticles() async {
    final db = await createDatabase();
    db.delete("NEWS_ARTICLES");
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
    final db = await createDatabase();
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
    final id = await db.insert("NEWS_ARTICLES", data,
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
    final db = await createDatabase();
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

    final result = await db.update(
      "NEWS_ARTICLES",
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }
}
