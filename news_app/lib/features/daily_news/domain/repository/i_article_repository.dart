import 'package:news_app/core/resources/data_state.dart';

abstract class ArticleRepository {
  Future<DataState> getNewsArticles({
    required String apiKey,
    required String category,
    required String country,
  });

  Future<void> saveNewsArticles();
  Future<DataState> getSavedNewsArticles();
  Future<void> removeArticles();
}
