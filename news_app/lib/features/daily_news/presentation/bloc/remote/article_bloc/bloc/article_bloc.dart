// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/usecases/articles_usecases/get_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/articles_usecases/get_saved_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/articles_usecases/save_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/connectivity_usecases/no_net.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote/filter_bloc/bloc/filter_bloc.dart';
part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final FilterBloc _filterBloc;
  final GetArticleUseCase _getArticleUseCase;
  final SaveArticlesUseCase _saveArticlesUseCase;
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final NoNetworkUsecase _noNetworkUsecase;

  ArticleBloc(this._getArticleUseCase, this._saveArticlesUseCase,
      this._noNetworkUsecase, this._getSavedArticleUseCase, this._filterBloc)
      : super(const ArticleLoadingState()) {
    on<ArticleEvent>(
      (event, emit) async {
        _filterBloc.stream.listen((state) {
          debugPrint(" got filter state  in ArticleBloc");
          debugPrint(state.toString());
          if (state is UserFilterFinalizedState) {
            debugPrint("UserFilterFinalizedState got in ArticleBloc");
            add(const GetArticlesEvent());
          }
        });

        if (event is GetArticlesEvent) {
          debugPrint(event.toString());
          late DataState dataState;
          // if (await _noNetworkUsecase.call()) {
          //   dataState = await _getSavedArticleUseCase.call();
          // } else {
          dataState = await _getArticleUseCase.call(params: [
            getCountryCode(countryName: CountryName.india),
            _filterBloc.categoryFilterValues.keys
                .firstWhere((element) => true)
                .name,
            apiKey,
            SortNewsBy.relevancy.name,
            "",
          ]);
          //}

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
      },
    );
  }
}
