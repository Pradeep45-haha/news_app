import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/repository/i_news_repository.dart';

class OpenNews implements UseCase<DataState, String> {
  final NewsRepository _newsRepository;
  OpenNews({required NewsRepository newsRepository})
      : _newsRepository = newsRepository;
  @override
  Future<DataState> call({required String params}) async {
    return await _newsRepository.openNews(url: params);
  }
}
