part of 'filter_bloc.dart';

sealed class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

final class UserWantToAddFiltersEvent extends FilterEvent {
  @override
  List<Object> get props => [];
}

final class UserUpdatedArticlesPerPageEvent extends FilterEvent {
  final int maxArticlesPerPage;
  @override
  List<Object> get props => [maxArticlesPerPage];
  const UserUpdatedArticlesPerPageEvent({
    required this.maxArticlesPerPage,
  });
}

final class UserUpdatedCategoryEvent extends FilterEvent {
  @override
  List<Object> get props => [category];
  final Category category;

  const UserUpdatedCategoryEvent({
    required this.category,
  });
}

final class UserUpdatedCountryEvent extends FilterEvent {
  @override
  List<Object> get props => [country];
  final String country;

  const UserUpdatedCountryEvent({
    required this.country,
  });
}

final class UserUpdatedSortByEvent extends FilterEvent {
  @override
  List<Object> get props => [sortBy];
  final SortNewsBy sortBy;
  const UserUpdatedSortByEvent({
    required this.sortBy,
  });
}

final class UserFilterFinalizedEvent extends FilterEvent {
  @override
  List<Object> get props => [];
}

final class UserClearedAllFiltersEvent extends FilterEvent {
  @override
  List<Object> get props => [];
}

final class ShowCountrySelectionMenuEvent extends FilterEvent {
  @override
  List<Object> get props => [];
}

final class CloseCountrySelectionMenuEvent extends FilterEvent {
  const CloseCountrySelectionMenuEvent();
}
