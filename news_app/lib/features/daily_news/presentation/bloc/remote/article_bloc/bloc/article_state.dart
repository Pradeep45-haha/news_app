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
  final List<ArticleEntity> articlesEntity;
  const ArticleDoneState({
    required this.articlesEntity,
  }) : super(
          forEquatable: articlesEntity,
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

final class UserWantsToAddFiltersState extends ArticleState {}

final class UserUpdatedArticlesPerPageState extends ArticleState {
  const UserUpdatedArticlesPerPageState();
}

final class UserUpdatedCategoryState extends ArticleState {
  const UserUpdatedCategoryState();
}

final class UserUpdatedCountryState extends ArticleState {
  const UserUpdatedCountryState();
}

final class UserUpdatedSortByState extends ArticleState {
  const UserUpdatedSortByState();
}
