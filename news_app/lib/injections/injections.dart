import "package:get_it/get_it.dart";
import "package:news_app/core/utils/database_helper.dart";
import "package:news_app/features/daily_news/data/data_sources/local/local_news_api_service.dart";
import "package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart";
import "package:news_app/features/daily_news/data/repository/imp_article_repository.dart";
import "package:news_app/features/daily_news/domain/repository/i_article_repository.dart";
import 'package:news_app/features/daily_news/domain/usecases/get_articles.dart';
import "package:news_app/features/daily_news/domain/usecases/save_articles.dart";
import "package:news_app/features/daily_news/presentation/bloc/remote/article_bloc/bloc/remote_article_bloc.dart";

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<NewsApiService>(
    NewsApiService(),
  );

  serviceLocator.registerSingleton<LocalGetNewsApiService>(
    LocalGetNewsApiService(
      databaseHelper: DatabaseHelper(),
    ),
  );

  serviceLocator.registerSingleton<ArticleRepository>(
    ArticleRepositoryImp(
      serviceLocator(),
      LocalGetNewsApiService(
        databaseHelper: DatabaseHelper(),
      ),
    ),
  );
  serviceLocator.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerSingleton<SaveArticlesUseCase>(
    SaveArticlesUseCase(
      articleRepository: ArticleRepositoryImp(
        serviceLocator(),
        serviceLocator(),
      ),
    ),
  );

  serviceLocator.registerFactory<RemoteArticleBloc>(
    () => RemoteArticleBloc(
      serviceLocator(),
      serviceLocator(),
    ),
  );
}
