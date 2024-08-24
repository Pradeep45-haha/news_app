import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/resources/http_exception.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/open_news_service.dart';
import 'package:news_app/features/daily_news/domain/repository/i_news_repository.dart';
import 'package:news_app/net_connection/net_status.dart';

class NewsRepositoryImp implements NewsRepository {
  final OpenNewsService _openNewsService;
  final NetStatus _netStatus;

  NewsRepositoryImp(
      {required OpenNewsService openNewsService, required NetStatus netStatus})
      : _netStatus = netStatus,
        _openNewsService = openNewsService;

  @override
  Future<DataState> openNews({required String url}) async {
    if (await _netStatus.isNotConnectedToAnyNetwork() == true) {
      return DataException(clientException: HttpUnexpectedException());
    }
    return _openNewsService.openNewsService(url: url);
  }
}
