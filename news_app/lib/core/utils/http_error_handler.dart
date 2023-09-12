import 'package:http/http.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';


DataState handleHttpError(Response response) {
  late DataException dataException;
  switch (response.statusCode) {
    case 400:
      dataException = DataException(
        clientException: BadHttpRequest(
          response.request!.url.toString(),
        ),
      );
      break;
    case 401:
      dataException = DataException(
          clientException: UnauthorisedHttpRequest(
        response.request!.url.toString(),
      ));
      break;
    case 429:
      dataException = DataException(
          clientException: TooManyRequest(
        response.request!.url.toString(),
      ));
      break;
    case 500:
      dataException = DataException(
          clientException: HttpServerException(
        response.request!.url.toString(),
      ));
    default:
      dataException = DataException(
        clientException: HttpUnexpectedException(),
      );
      break;
  }
  return dataException;
}
