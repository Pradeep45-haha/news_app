// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/usecases/articles_usecases/get_articles.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote/filter_bloc/bloc/filter_bloc.dart';
part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final FilterBloc _filterBloc;
  final GetArticleUseCase _getArticleUseCase;

  //for one time filter bloc listen
  bool isListeningToFilterBloc = false;

  ArticleBloc(this._getArticleUseCase, this._filterBloc)
      : super(const ArticleLoadingState()) {
    on<ArticleEvent>(
      (event, emit) async {
        if (!isListeningToFilterBloc) {
          isListeningToFilterBloc = true;
          _filterBloc.stream.listen((state) {
            debugPrint(" got filter state  in ArticleBloc");
            debugPrint(state.toString());
            if (state is UserFilterFinalizedState) {
              debugPrint("UserFilterFinalizedState got in ArticleBloc");
              add(const GetArticlesEvent());
            }
            if (state is UserUpdatedPageNumState) {
              add(const GetArticlesEvent());
            }
          });
        }

        if (event is GetArticlesEvent) {
          emit(const ArticleLoadingState());
          debugPrint(event.toString());
          late DataState dataState;
          //search data
          SearchParams searchParams = SearchParams(
              country: _filterBloc.seledtedCountryCodeName,
              category:
                  _filterBloc.categoryFilterValues.keys.firstWhere((element) {
                return _filterBloc.categoryFilterValues[element] == true;
              }).name,
              sortBy: _filterBloc.sortByValues.keys.firstWhere((element) {
                return _filterBloc.sortByValues[element] == true;
              }).name,
              getNewsByMatchingText: "modi",
              pageSize: _filterBloc.articlesPerPage,
              pageNum: _filterBloc.pageNum);

          //calling getArticle
          dataState = await _getArticleUseCase.call(
            params: searchParams,
          );
          debugPrint("search params : ${searchParams.toString()}");
          //check datastate
          if (dataState is DataSuccess) {
            debugPrint("data state is data success");
            if ((dataState.data as ArticleCountAndArticleEntity)
                .article
                .isNotEmpty) {
              debugPrint("data is not empty");
              for (ArticleEntity element
                  in ((dataState.data as ArticleCountAndArticleEntity)
                      .article)) {
                debugPrint("${element.toString()}\n");
              }
              emit(
                ArticleDoneState(
                  articleCountAndArticleEntity: dataState.data!,
                ),
              );
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
      },
    );
  }
}
