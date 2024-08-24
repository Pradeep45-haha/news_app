part of 'article_bloc.dart';

sealed class ArticleState extends Equatable {
  final List<Object>? forEquatable;
  const ArticleState({this.forEquatable});

  @override
  List<Object> get props => forEquatable!;
}

final class ArticlesState extends ArticleState {
  final List<ArticleEntity>? articles;

  ArticlesState({
    this.articles,
  }) : super(
          forEquatable: [
            articles!,
          ],
        );
}

final class ArticleLoadingState extends ArticleState {
  const ArticleLoadingState();
}

final class ArticleDoneState extends ArticleState {
  final ArticleCountAndArticleEntity articleCountAndArticleEntity;
  ArticleDoneState({
    required this.articleCountAndArticleEntity,
  }) : super(
          forEquatable: [articleCountAndArticleEntity],
        );
}

final class ArticleErrorState extends ArticleState {
  final ClientException exception;
  ArticleErrorState({
    required this.exception,
  }) : super(
          forEquatable: [exception],
        );
}
