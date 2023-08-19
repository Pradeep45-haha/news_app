import 'dart:convert';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import '../../domain/repository/i_article_repository.dart';

class ArticleRepositoryImp implements ArticleRepository {
  final NewsApiService _newsApiService;
  ArticleRepositoryImp(this._newsApiService);

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
      //debugPrint(listOfArticles.toString());
      for (int i = 0; i < listOfArticles.length; i++) {
        //debugPrint("from data layer");
        //debugPrint(listOfArticles[i].toString());
        articleModel.add(ArticleModel.fromJson(listOfArticles[i]));
        //debugPrint(articleModel.toString());
      }
      //debugPrint(articleModel.toString());
      DataState<List<ArticleModel>> successDataState =
          DataSuccess<List<ArticleModel>>(
        articleModel,
      );
      return successDataState;
    }
    return dataState;
  }
}
