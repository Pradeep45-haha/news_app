import "package:get_it/get_it.dart";
import "package:connectivity_plus/connectivity_plus.dart";
import "package:news_app/core/utils/database_helper.dart";
import "package:news_app/features/daily_news/data/data_sources/local/local_news_api_service.dart";
import "package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart";
import "package:news_app/features/daily_news/data/data_sources/remote/open_news_service.dart";
import "package:news_app/features/daily_news/data/repository/imp_article_repository.dart";
import "package:news_app/features/daily_news/data/repository/imp_news_repository.dart";
import "package:news_app/features/daily_news/domain/repository/i_article_repository.dart";
import "package:news_app/features/daily_news/domain/repository/i_news_repository.dart";
import "package:news_app/features/daily_news/domain/usecases/articles_usecases/get_articles.dart";
import "package:news_app/features/daily_news/domain/usecases/news_usecases/open_news.dart";
import "package:news_app/features/daily_news/presentation/bloc/remote/article_bloc/bloc/article_bloc.dart";
import "package:news_app/features/daily_news/presentation/bloc/remote/filter_bloc/bloc/filter_bloc.dart";
import "package:news_app/features/daily_news/presentation/bloc/remote/url_launch_bloc/url_launch_bloc.dart";
import "package:news_app/net_connection/net_status.dart";

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<RemoteNewsApiService>(
    RemoteNewsApiService(),
  );
  serviceLocator.registerSingleton(Connectivity());
  serviceLocator.registerSingleton(FilterBloc());

  serviceLocator.registerSingleton(OpenNewsService());

  serviceLocator.registerSingleton<NewsRepository>(NewsRepositoryImp(
    netStatus: NetStatus(connectivity: serviceLocator()),
    openNewsService: serviceLocator(),
  ));
  serviceLocator.registerSingleton(
    OpenNews(
      newsRepository: serviceLocator(),
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
      NetStatus(connectivity: serviceLocator()),
    ),
  );
  serviceLocator.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<UrlLaunchBloc>(
    () => UrlLaunchBloc(
      openNews: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<ArticleBloc>(
    () => ArticleBloc(
      serviceLocator(),
      serviceLocator(),
    ),
  );
}
