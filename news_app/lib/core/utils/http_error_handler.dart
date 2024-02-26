import 'package:http/http.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/resources/http_exception.dart';

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
          clientException: UnauthorizedHttpRequest(
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
