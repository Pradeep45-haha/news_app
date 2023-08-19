part of 'remote_article_bloc.dart';

sealed class RemoteArticleState extends Equatable {
  final List<Object>? forEquatable;
  const RemoteArticleState({this.forEquatable});

  @override
  List<Object> get props => forEquatable!;
}

final class RemoteArticlesState extends RemoteArticleState {
  final List<ArticleEntity>? articles;
  final DioException? exception;

  RemoteArticlesState({this.articles, this.exception})
      : super(
          forEquatable: [articles!, exception!],
        );
}

final class RemoteArticleLoadingState extends RemoteArticleState {
  const RemoteArticleLoadingState();
}

final class RemoteArticleDoneState extends RemoteArticleState {
  final List<ArticleEntity> articlesEntity;
  const RemoteArticleDoneState({
    required this.articlesEntity,
  }) : super(
          forEquatable: articlesEntity,
        );
}

final class RemoteArticleErrorState extends RemoteArticleState {
  final ClientException exception;
  RemoteArticleErrorState({
    required this.exception,
  }) : super(
          forEquatable: [exception],
        );
}
