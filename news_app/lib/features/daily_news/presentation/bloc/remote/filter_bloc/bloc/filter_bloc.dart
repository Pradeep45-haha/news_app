// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import, depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:news_app/config/data_helper.dart';
import 'package:news_app/core/constant/constants.dart';
part 'filter_event.dart';
part 'filter_state.dart';

class Value {
  int _value = 0;

  int currentValue() {
    checkMax();
    _value++;
    return _value;
  }

  checkMax() {
    if (_value >= 999999) {
      _value = 0;
    }
  }
}

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  Value value = Value();

  //data for filter
  Map<SortNewsBy, bool> sortByValues = {
    SortNewsBy.popularity: false,
    SortNewsBy.publishedAt: false,
    SortNewsBy.relevancy: true,
  };
  Map<Category, bool> categoryFilterValues = {
    Category.business: true,
    Category.entertainment: false,
    Category.general: false,
    Category.health: false,
    Category.science: false,
    Category.sports: false,
    Category.technology: false,
  };

  int articlesPerPage = 20;
  int pageNum = 1;
  //country codeName
  String seledtedCountryCodeName = "in";

  FilterBloc() : super(FilterInitial()) {
    on<FilterEvent>((event, emit) {
      if (event is UserUpdatedArticlesPerPageEvent) {
        articlesPerPage = event.maxArticlesPerPage;
        emit(
          UserUpdatedArticlesPerPageState(updated: value.currentValue()),
        );
      }
      if (event is UserUpdatedCategoryEvent) {
        pageNum = 1;
        categoryFilterValues = categoryFilterValues.map((key, value) {
          return MapEntry(key, false);
        });
        categoryFilterValues[event.category] =
            !categoryFilterValues[event.category]!;
        emit(UserUpdatedCategoryState(updated: value.currentValue()));
      }
      if (event is UserUpdatedCountryEvent) {
        seledtedCountryCodeName = countryNameCodeMap[event.country]!;
        emit(const UserUpdatedCountryState());
      }
      if (event is UserUpdatedSortByEvent) {
        sortByValues = sortByValues.map((key, value) {
          return MapEntry(key, false);
        });
        debugPrint(sortByValues.toString());
        sortByValues[event.sortBy] = true;
        debugPrint(sortByValues.toString());

        emit(UserUpdatedSortByState(updated: value.currentValue()));
      }
      if (event is UserChangedPageNumEvent) {
        pageNum = event.pageNum;
        emit(UserUpdatedPageNumState(updated: value.currentValue()));
      }

      if (event is UserFilterFinalizedEvent) {
        debugPrint("got UserFilterFinalizedEvent ");

        emit(UserFilterFinalizedState(updated: value.currentValue()));
      }
      if (event is UserClearedAllFiltersEvent) {
        categoryFilterValues = categoryFilterValues.map((key, value) {
          return MapEntry(key, false);
        });
        sortByValues = sortByValues.map((key, value) {
          return MapEntry(key, false);
        });
        sortByValues[SortNewsBy.relevancy] = true;
        articlesPerPage = 20;
        emit(UserClearedAllFiltersState(updated: value.currentValue()));
      }
      if (event is ShowCountrySelectionMenuEvent) {
        emit(ShowCountrySelectionMenuState(updated: value.currentValue()));
      }
      if (event is CloseCountrySelectionMenuEvent) {
        emit(CloseCountrySelectionMenuState(updated: value.currentValue()));
      }
    });
  }
}
