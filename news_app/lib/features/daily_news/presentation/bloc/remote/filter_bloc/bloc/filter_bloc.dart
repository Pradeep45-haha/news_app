import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/constant/constants.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  //variables for ui
  Map<SortNewsBy, bool> sortByValues = {
    SortNewsBy.popularity: false,
    SortNewsBy.publishedAt: false,
    SortNewsBy.relevancy: true,
  };
  Map<Category, bool> categoryFilterValues = {
    Category.business: true,
    Category.entertainment: true,
    Category.general: true,
    Category.health: true,
    Category.science: true,
    Category.sports: true,
    Category.technology: true,
  };
  int articlesPerPage = 20;

  FilterBloc() : super(FilterInitial()) {
    on<FilterEvent>((event, emit) {
       if (event is UserUpdatedArticlesPerPageEvent) {
          articlesPerPage = event.maxArticlesPerPage;
          emit(
            const UserUpdatedArticlesPerPageState(),
          );
        }
        if (event is UserFilterFinalizedEvent) {
          debugPrint("got UserFilterFinalizedEvent ");
        }
    });
  }
}
