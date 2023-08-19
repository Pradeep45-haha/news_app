import "package:get_it/get_it.dart";
import "package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart";
import "package:news_app/features/daily_news/data/repository/imp_article_repository.dart";
import "package:news_app/features/daily_news/domain/repository/i_article_repository.dart";
import "package:news_app/features/daily_news/domain/usecases/get_article.dart";
import "package:news_app/features/daily_news/presentation/bloc/remote/article_bloc/bloc/remote_article_bloc.dart";

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {

  serviceLocator.registerSingleton<NewsApiService>(NewsApiService());
  serviceLocator.registerSingleton<ArticleRepository>(
      ArticleRepositoryImp(serviceLocator()));
  serviceLocator.registerSingleton<GetArticleUseCase>(
      GetArticleUseCase(serviceLocator()));

  serviceLocator.registerFactory<RemoteArticleBloc>(
      () => RemoteArticleBloc(serviceLocator()));
}
