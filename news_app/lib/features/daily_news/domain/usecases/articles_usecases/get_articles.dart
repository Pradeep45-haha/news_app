import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/i_article_repository.dart';

class GetArticleUseCase implements UseCase<DataState, List<String>> {
  final ArticleRepository _articleRepository;
  GetArticleUseCase(this._articleRepository);
  @override
  Future<DataState> call({
    required List<String> params,
  }) async {
    DataState dataState = await _articleRepository.getNewsArticles(
      country: params[0],
      category: params[1],
      apiKey: params[2],
      sortBy: params[3],
      getNewsMatchingText: params[4],
    );
    if (dataState is DataSuccess) {
      List<ArticleEntity> listOfArticleEntity = [];
      List<dynamic> listOfArticle = dataState.data;

      for (int i = 0; i < listOfArticle.length; i++) {
        listOfArticleEntity.add(
          ArticleEntity.fromArticleModel(listOfArticle[i]),
        );
      }
      return DataSuccess(listOfArticleEntity);
    }

    return dataState;
  }
}
