import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/utils/database_helper.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class LocalGetNewsApiService {
  final DatabaseHelper databaseHelper;
  LocalGetNewsApiService({required this.databaseHelper});
  Future<void> saveNewsArticles(
      {required List<ArticleEntity> articleEntity}) async {
    
   
    for (int i = 0; i < articleEntity.length; i++) {
      databaseHelper.saveNewsArticles(
          author: articleEntity[i].author!,
          title: articleEntity[i].title!,
          description: articleEntity[i].description!,
          url: articleEntity[i].url!,
          urlToImage: articleEntity[i].urlToImage!,
          publishedAt: articleEntity[i].publishedAt!,
          sourceId: articleEntity[i].sourcesEntity!.id!,
          sourceName: articleEntity[i].sourcesEntity!.name!,
          content: articleEntity[i].content!);
    }
  }

  Future<DataState> getSavedNewsArticles() async {
    final List<Map<String, dynamic>> newsArticles =
        await databaseHelper.getNewsArticles();
    DataSuccess dataSuccess = DataSuccess(newsArticles);
    return dataSuccess;
  }

  Future<void> removeNewsArticles() async {
    databaseHelper.removeNewsArticles();
  }

  Future<int> updateNewsArticles(
      {required ArticleEntity articleEntity, required int id}) async {
    return await databaseHelper.updateNewsArticles(
      id: id,
      author: articleEntity.author,
      content: articleEntity.content,
      description: articleEntity.description,
      publishedAt: articleEntity.publishedAt,
      sourceId: articleEntity.sourcesEntity!.id,
      sourceName: articleEntity.sourcesEntity!.name,
      title: articleEntity.title,
      url: articleEntity.url,
      urlToImage: articleEntity.urlToImage,
    );
  }
}
