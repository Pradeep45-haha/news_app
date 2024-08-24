import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState> getNewsArticles({
    required int pageSize,
    required int pageNum,
    required String category,
    required String country,
    required String sortBy,
    String getNewsByMatchingText = "",
  });

  
  
  Future<void> removeArticles();
  Future<int> updateArticle(
      {required ArticleEntity articleEntity, required int id});


}
