import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/i_article_repository.dart';

class GetArticleUseCase implements UseCase<DataState, SearchParams> {
  final ArticleRepository _articleRepository;
  GetArticleUseCase(this._articleRepository);
  @override
  Future<DataState> call({
    required SearchParams params,
  }) async {
    DataState dataState = await _articleRepository.getNewsArticles(
      country: params.country,
      category: params.category,
      sortBy: params.sortBy,
      getNewsByMatchingText: params.getNewsByMatchingText,
      pageSize: params.pageSize,
      pageNum: params.pageNum,
    );
    if (dataState is DataSuccess) {
      late ArticleCountAndArticleEntity articleCountAndArticleEntity;
      ArticleCountAndArticleModel articlesDetails = dataState.data;

      articleCountAndArticleEntity =
          ArticleCountAndArticleEntity.fromArticleCountAndArticleModel(
              articlesDetails);

      return DataSuccess(articleCountAndArticleEntity);
    }

    return dataState;
  }
}
