import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/local_news_api_service.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/net_connection/net_status.dart';
import '../../domain/repository/i_article_repository.dart';

class ArticleRepositoryImp implements ArticleRepository {
  final RemoteNewsApiService _newsApiService;
  final LocalNewsApiService _localGetNewsApiService;
  final NetStatus _netStatus;
  ArticleRepositoryImp(
    this._newsApiService,
    this._localGetNewsApiService,
    this._netStatus,
  );

  @override
  Future<DataState> getNewsArticles({
    required int pageSize,
    required int pageNum,
    required String category,
    required String country,
    required String sortBy,
    String getNewsByMatchingText = "",
  }) async {
    late DataState dataState;
    if (await _netStatus.isNotConnectedToAnyNetwork()) {
      dataState = await _localGetNewsApiService.getSavedNewsArticles();
    } else {
      debugPrint("net connection is on");
      dataState = await _newsApiService.getNewsArticles(
        pageNum: pageNum,
        pageSize: pageSize,
        country: country,
        category: category,
      );
    }

    if (dataState is DataSuccess) {
      List<ArticleModel> articleModel = [];
      Map<String, dynamic> jsonMap = jsonDecode(dataState.data.body);
      int totalResults = jsonMap["totalResults"];
      List<dynamic> listOfArticles = jsonMap["articles"];

      for (var article in listOfArticles) {
        articleModel.add(ArticleModel.fromJson(article));
      }
      DataState<ArticleCountAndArticleModel> successDataState =
          DataSuccess<ArticleCountAndArticleModel>(ArticleCountAndArticleModel(
              article: articleModel, totalResults: totalResults));
      return successDataState;
    }
    return dataState;
  }

  @override
  Future<void> removeArticles() {
    return _localGetNewsApiService.removeNewsArticles();
  }

  @override
  Future<int> updateArticle({
    required ArticleEntity articleEntity,
    required int id,
  }) async {
    return await _localGetNewsApiService.updateNewsArticles(
      articleEntity: articleEntity,
      id: id,
    );
  }
}
