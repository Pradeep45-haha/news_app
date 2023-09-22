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
  final int updated;
  const UserUpdatedArticlesPerPageState({required this.updated});
  @override
  List<Object> get props => [updated];
}

final class UserUpdatedCategoryState extends FilterState {
  final int updated;

  @override
  List<Object> get props => [updated];
  const UserUpdatedCategoryState({required this.updated});
}

final class UserUpdatedCountryState extends FilterState {
  const UserUpdatedCountryState();
}

final class UserUpdatedSortByState extends FilterState {
  final int updated;
  const UserUpdatedSortByState({required this.updated});
  @override
  List<Object> get props => [updated];
}

final class UserClearedAllFiltersState extends FilterState {
  final int updated;
  @override
  List<Object> get props => [updated];
  const UserClearedAllFiltersState({required this.updated});
}

final class ShowCountrySelectionMenuState extends FilterState {
  final int updated;
  @override
  List<Object> get props => [updated];
  const ShowCountrySelectionMenuState({required this.updated});
}

final class CloseCountrySelectionMenuState extends FilterState {
  final int updated;
  @override
  List<Object> get props => [updated];
  const CloseCountrySelectionMenuState({required this.updated});
}
