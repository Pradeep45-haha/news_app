part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

final class GetArticlesEvent extends ArticleEvent {
  const GetArticlesEvent();
}

final class UserWantToAddFiltersEvent extends ArticleEvent {}

final class UserUpdatedArticlesPerPageEvent extends ArticleEvent {
  final int maxArticlesPerPage;

  const UserUpdatedArticlesPerPageEvent({
    required this.maxArticlesPerPage,
  });
}

final class UserUpdatedCategoryEvent extends ArticleEvent {
  final String category;

  const UserUpdatedCategoryEvent({
    required this.category,
  });
}

final class UserUpdatedCountryEvent extends ArticleEvent {
  final String country;

  const UserUpdatedCountryEvent({
    required this.country,
  });
}

final class UserUpdatedSortByEvent extends ArticleEvent {
  final String sortBy;
  const UserUpdatedSortByEvent({
    required this.sortBy,
  });
}

final class UserFilterFinalizedEvent extends ArticleEvent {}
