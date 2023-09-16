import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/utils/sql_helper.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class LocalGetNewsApiService {
  Future<void> saveNewsArticles({required ArticleEntity articleEntity}) async {
    final db = await SqlHelper.db();
    SqlHelper.createTable(db);
    SqlHelper.postNewsArticle(
        author: articleEntity.author!,
        title: articleEntity.title!,
        description: articleEntity.description!,
        url: articleEntity.url!,
        urlToImage: articleEntity.urlToImage!,
        publishedAt: articleEntity.publishedAt!,
        sourceId: articleEntity.sourcesEntity!.id!,
        sourceName: articleEntity.sourcesEntity!.name!,
        content: articleEntity.content!);
  }

  Future<DataState> getSavedNewsArticles() async {
    final List<Map<String, dynamic>> newsArticles =
        await SqlHelper.getNewsArticles();
    DataSuccess dataSuccess = DataSuccess(newsArticles);
    return dataSuccess;
  }

  Future<void> removeNewsArticles() async {
    SqlHelper.deleteNewArticles();
  }
}
