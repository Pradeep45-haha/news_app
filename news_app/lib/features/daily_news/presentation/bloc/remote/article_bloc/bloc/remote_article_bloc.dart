import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:dio/dio.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';
part 'remote_article_event.dart';
part 'remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;
  RemoteArticleBloc(this._getArticleUseCase)
      : super(const RemoteArticleLoadingState()) {
    on<RemoteArticleEvent>((event, emit) async {
      if (event is GetArticlesEvent) {
        final dataState =
            await _getArticleUseCase.call(params: [ getCountryCode(counrtyName: null),getCategory(null), apiKey]);
        if (dataState is DataSuccess) {
          if (dataState.data!.isNotEmpty) {
            emit(
              RemoteArticleDoneState(
                articlesEntity: dataState.data!,
              ),
            );
          }
          return;
        }
        if (dataState is DataException) {
          emit(
            RemoteArticleErrorState(
              exception: dataState.exception!,
            ),
          );
          return;
        }
      }
    });
  }
}
