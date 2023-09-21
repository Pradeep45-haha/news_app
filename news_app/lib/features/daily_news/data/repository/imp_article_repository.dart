import 'dart:convert';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/local_news_api_service.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import '../../domain/repository/i_article_repository.dart';

class ArticleRepositoryImp implements ArticleRepository {
  final RemoteNewsApiService _newsApiService;
  final LocalNewsApiService _localGetNewsApiService;
  ArticleRepositoryImp(this._newsApiService, this._localGetNewsApiService);

  @override
  Future<DataState> getNewsArticles({
    required String apiKey,
    required String category,
    required String country,
  }) async {
    DataState dataState = await _newsApiService.getNewsArticles(
      apiKey: apiKey,
      country: country,
      category: category,
    );
    if (dataState is DataSuccess) {
      List<ArticleModel> articleModel = [];
      Map<String, dynamic> jsonMap = jsonDecode(dataState.data.body);
      List<dynamic> listOfArticles = jsonMap["articles"];

      for (int i = 0; i < listOfArticles.length; i++) {
        articleModel.add(ArticleModel.fromJson(listOfArticles[i]));
      }

      DataState<List<ArticleModel>> successDataState =
          DataSuccess<List<ArticleModel>>(
        articleModel,
      );
      return successDataState;
    }
    return dataState;
  }

  @override
  Future<void> saveNewsArticles({required List<ArticleEntity> articleEntity}) {
    return _localGetNewsApiService.saveNewsArticles(
        articleEntity: articleEntity);
  }

  @override
  Future<DataState> getSavedNewsArticles() async {
    final dataState = await _localGetNewsApiService.getSavedNewsArticles();
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
