import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/resources/http_exception.dart';
import 'package:news_app/core/utils/http_error_handler.dart';
import 'package:news_app/core/utils/url_builder.dart';
import 'package:http/http.dart';

class RemoteNewsApiService {
  Future<DataState> getNewsArticles(
      {required String country,
      required String category,
      required int pageSize,
      required int pageNum}) async {
    try {
      Response httpResponse = await get(
        Uri.parse(urlBuilder(
          articlesPerPage: pageSize,
          page: pageNum,
          category: category,
          country: country,
        )),
      );
      if (httpResponse.statusCode == 200) {
        return DataSuccess(httpResponse);
      }
      return (handleHttpError(httpResponse));
    } catch (e) {
      return DataException(
        clientException: HttpUnexpectedException(
          messageM: e.toString(),
        ),
      );
    }
  }
}
