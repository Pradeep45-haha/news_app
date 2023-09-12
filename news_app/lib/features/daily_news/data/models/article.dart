import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleModel extends ArticleEntity {
  final SourceModel? sourceModel;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleModel({
    required this.sourceModel,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    
    return ArticleModel(
      author: map["author"].toString(),
      content: map["content"].toString(),
      description: map["description"].toString(),
      publishedAt: map["publishedAt"].toString(),
      sourceModel: SourceModel.fromJson(
        map["source"],
      ),
      title: map["title"].toString(),
      url: map["url"].toString(),
      urlToImage: map["urlToImage"].toString(),
    );
  }
}

class SourceModel extends SourcesEntity {
  final String? id;
  final String? name;
  const SourceModel({
    this.id,
    this.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> map) {
    return SourceModel(
      id: map["id"].toString(),
      name: map["name"].toString(),
    );
  }
}
