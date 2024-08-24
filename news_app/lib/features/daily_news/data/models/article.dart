class ArticleCountAndArticleModel {
  List<ArticleModel> article;
  int totalResults;
  ArticleCountAndArticleModel(
      {required this.article, required this.totalResults});

  factory ArticleCountAndArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleCountAndArticleModel(
        article: (map["articles"] as List<dynamic>).map((e) {
          return ArticleModel.fromJson(e);
        }).toList(),
        totalResults: map["totalResults"]);
  }
}

class ArticleModel {
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

class SourceModel {
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
