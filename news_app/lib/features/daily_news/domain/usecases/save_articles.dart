import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/i_article_repository.dart';

class SaveArticlesUseCase implements UseCase {
  final ArticleRepository articleRepository;
  SaveArticlesUseCase({
    required this.articleRepository,
  });

  @override
  Future<void> call({required params}) async {
    return articleRepository.saveNewsArticles(
        articleEntity: params as List<ArticleEntity>);
  }
}
