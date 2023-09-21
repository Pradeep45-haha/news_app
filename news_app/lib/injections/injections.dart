import "package:connectivity_plus/connectivity_plus.dart";
import "package:get_it/get_it.dart";
import "package:news_app/core/utils/database_helper.dart";
import "package:news_app/features/daily_news/data/data_sources/local/local_news_api_service.dart";
import "package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart";
import "package:news_app/features/daily_news/data/repository/imp_article_repository.dart";
import "package:news_app/features/daily_news/data/repository/imp_connectivity_repository.dart";
import "package:news_app/features/daily_news/domain/repository/i_article_repository.dart";
import "package:news_app/features/daily_news/domain/repository/i_connectivity_repository.dart";
import "package:news_app/features/daily_news/domain/usecases/articles_usecases/get_articles.dart";
import "package:news_app/features/daily_news/domain/usecases/articles_usecases/get_saved_articles.dart";
import "package:news_app/features/daily_news/domain/usecases/articles_usecases/save_articles.dart";
import "package:news_app/features/daily_news/domain/usecases/connectivity_usecases/no_net.dart";
import "package:news_app/features/daily_news/presentation/bloc/remote/article_bloc/bloc/article_bloc.dart";

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<RemoteNewsApiService>(
    RemoteNewsApiService(),
  );
  serviceLocator.registerSingleton(Connectivity());

  serviceLocator.registerSingleton<ConnectivityRepository>(
    ConnectivityRepositoryImp(
      connectivity: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<LocalNewsApiService>(
    LocalNewsApiService(
      databaseHelper: DatabaseHelper(),
    ),
  );

  serviceLocator.registerSingleton<ArticleRepository>(
    ArticleRepositoryImp(
      serviceLocator(),
      LocalNewsApiService(
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
  serviceLocator.registerSingleton<NoNetworkUsecase>(
    NoNetworkUsecase(
      connectivityRepository: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<GetSavedArticleUseCase>(
    GetSavedArticleUseCase(
      serviceLocator.get(),
    ),
  );

  serviceLocator.registerFactory<ArticleBloc>(
    () => ArticleBloc(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );
}
