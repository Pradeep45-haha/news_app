// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';

class ArticleCountAndArticleEntity {
  List<ArticleEntity> article;
  int totalResults;
  ArticleCountAndArticleEntity(
      {required this.article, required this.totalResults});

  factory ArticleCountAndArticleEntity.fromArticleCountAndArticleModel(
      ArticleCountAndArticleModel articleCountAndArticleModel) {
    return ArticleCountAndArticleEntity(
      totalResults: articleCountAndArticleModel.totalResults,
      article: articleCountAndArticleModel.article.map((e) {
        return ArticleEntity.fromArticleModel(e);
      }).toList(),
    );
  }

  @override
  String toString() {
    
    return "AtricleCountAndAtricleEntity(article: ${article.toList()}, totalResults: ${totalResults.toString()})";
  }
}

class ArticleEntity extends Equatable {
  final SourcesEntity? sourcesEntity;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  const ArticleEntity({
    this.sourcesEntity,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  @override
  List<Object?> get props => [
        sourcesEntity,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];

  factory ArticleEntity.fromArticleModel(ArticleModel articleModel) {
    return ArticleEntity(
      author: articleModel.author,
      content: articleModel.content,
      description: articleModel.description,
      publishedAt: articleModel.publishedAt,
      sourcesEntity: SourcesEntity.fromSourceModel(articleModel.sourceModel!),
      title: articleModel.title,
      url: articleModel.url,
      urlToImage: articleModel.urlToImage,
    );
  }

  @override
  String toString() {
    return "ArticleEntity(SourcesEntity: ${sourcesEntity.toString()}, author: $author, title: $title, url: $url, description: $description, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content)";
  }
}

class SourcesEntity extends Equatable {
  final String? id;
  final String? name;
  const SourcesEntity({
    this.id,
    this.name,
  });

  factory SourcesEntity.fromSourceModel(SourceModel sourcesModel) {
    return SourcesEntity(id: sourcesModel.id, name: sourcesModel.name);
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  @override
  String toString() {
    return "SourcesEntity(id:$id, name: $name)";
  }
}
