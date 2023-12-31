import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/i_article_repository.dart';

class GetSavedArticleUseCase implements UseCase<DataState, void> {
  final ArticleRepository _articleRepository;
  GetSavedArticleUseCase(this._articleRepository);
  @override
  Future<DataState> call({required void params}) async {
    DataState dataState = await _articleRepository.getSavedNewsArticles();
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
