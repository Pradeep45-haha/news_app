part of 'filter_bloc.dart';

@immutable
sealed class FilterState extends Equatable {
  const FilterState();
  @override
  List<Object> get props => [];
}

final class FilterInitial extends FilterState {}

final class UserWantsToAddFiltersState extends FilterState {}

final class UserUpdatedArticlesPerPageState extends FilterState {
  const UserUpdatedArticlesPerPageState();
}

final class UserUpdatedCategoryState extends FilterState {
  const UserUpdatedCategoryState();
}

final class UserUpdatedCountryState extends FilterState {
  const UserUpdatedCountryState();
}

final class UserUpdatedSortByState extends FilterState {
  const UserUpdatedSortByState();
}
