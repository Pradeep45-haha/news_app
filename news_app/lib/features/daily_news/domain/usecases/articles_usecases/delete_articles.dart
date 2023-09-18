import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/repository/i_article_repository.dart';

class DeleteArticles implements UseCase {
  final ArticleRepository articleRepository;
  DeleteArticles({required this.articleRepository});

  @override
  Future<void> call({params}) async {
    return articleRepository.removeArticles();
  }
}
