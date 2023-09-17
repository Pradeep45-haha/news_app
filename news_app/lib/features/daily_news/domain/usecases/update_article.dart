import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/repository/i_article_repository.dart';

class UpdateArticle implements UseCase {
  final ArticleRepository articleRepository;
  UpdateArticle({required this.articleRepository});

  @override
  Future<int> call({required params}) async {
    return articleRepository.updateArticle(
        articleEntity: params[1], id: params[0]);
  }
}
