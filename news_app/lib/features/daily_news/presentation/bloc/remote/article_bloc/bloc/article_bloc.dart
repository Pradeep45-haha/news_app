// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/usecases/articles_usecases/get_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/articles_usecases/get_saved_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/articles_usecases/save_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/connectivity_usecases/no_net.dart';
part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticleUseCase _getArticleUseCase;
  final SaveArticlesUseCase _saveArticlesUseCase;
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final NoNetworkUsecase _noNetworkUsecase;

  //variables for ui
  Map<SortBY, bool> sortByValues = {
    SortBY.popularity: false,
    SortBY.publishedAt: false,
    SortBY.relevancy: true,
  };
  Map<Category, bool> categoryFilterValues = {
    Category.business: true,
    Category.entertainment: true,
    Category.general: true,
    Category.health: true,
    Category.science: true,
    Category.sports: true,
    Category.technology: true,
  };
  int articlesPerPage = 20;

  ArticleBloc(
    this._getArticleUseCase,
    this._saveArticlesUseCase,
    this._noNetworkUsecase,
    this._getSavedArticleUseCase,
  ) : super(const ArticleLoadingState()) {
    on<ArticleEvent>(
      (event, emit) async {
        if (event is GetArticlesEvent) {
          late DataState dataState;
          if (await _noNetworkUsecase.call(params: "")) {
            dataState = await _getSavedArticleUseCase.call(params: null);
          } else {
            dataState = await _getArticleUseCase.call(params: [
              getCountryCode(countryName: null),
              getCategory(null),
              apiKey
            ]);
          }

          if (dataState is DataSuccess) {
            if (dataState.data.isNotEmpty) {
              emit(
                ArticleDoneState(
                  articlesEntity: dataState.data!,
                ),
              );
              _saveArticlesUseCase.call(params: dataState.data);
            }
            return;
          }
          if (dataState is DataException) {
            emit(
              ArticleErrorState(
                exception: dataState.exception!,
              ),
            );
            return;
          }
        }
        if (event is UserUpdatedArticlesPerPageEvent) {
          articlesPerPage = event.maxArticlesPerPage;
          emit(
            const UserUpdatedArticlesPerPageState(),
          );
        }
        if(event is UserFilterFinalizedEvent)
        {
          
        }
      },
    );
  }
}
