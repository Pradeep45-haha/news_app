part of 'filter_bloc.dart';

sealed class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

final class UserWantToAddFiltersEvent extends FilterEvent {}

final class UserUpdatedArticlesPerPageEvent extends FilterEvent {
  final int maxArticlesPerPage;

  const UserUpdatedArticlesPerPageEvent({
    required this.maxArticlesPerPage,
  });
}

final class UserUpdatedCategoryEvent extends FilterEvent {
  final String category;

  const UserUpdatedCategoryEvent({
    required this.category,
  });
}

final class UserUpdatedCountryEvent extends FilterEvent {
  final String country;

  const UserUpdatedCountryEvent({
    required this.country,
  });
}

final class UserUpdatedSortByEvent extends FilterEvent {
  final String sortBy;
  const UserUpdatedSortByEvent({
    required this.sortBy,
  });
}

final class UserFilterFinalizedEvent extends FilterEvent {}
