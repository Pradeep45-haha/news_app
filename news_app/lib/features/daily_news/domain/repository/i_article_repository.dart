import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState> getNewsArticles({
    required String apiKey,
    required String category,
    required String country,
    required String sortBy,
    String getNewsMatchingText = "",
  });

  Future<void> saveNewsArticles({required List<ArticleEntity> articleEntity});
  Future<DataState> getSavedNewsArticles();
  Future<void> removeArticles();
  Future<int> updateArticle(
      {required ArticleEntity articleEntity, required int id});
}
