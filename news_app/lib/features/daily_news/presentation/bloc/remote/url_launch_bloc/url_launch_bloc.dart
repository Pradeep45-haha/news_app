// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/usecases/news_usecases/open_news.dart';

part 'url_launch_event.dart';
part 'url_launch_state.dart';

class UrlLaunchBloc extends Bloc<UrlLaunchEvent, UrlLaunchState> {
  final OpenNews openNews;
  UrlLaunchBloc({required this.openNews}) : super(UrlLaunchInitial()) {
    on<UrlLaunchEvent>((event, emit) async {
      if (event is OpenUrlEvent) {
        DataState dataState = await openNews.call(params: event.url);
        if (dataState is DataSuccess) {
          emit(UrlLaunchSuccessState());
          return;
        } else {
          emit(UrlLaunchFailureState());
          return;
        }
      }
    });
  }
}
