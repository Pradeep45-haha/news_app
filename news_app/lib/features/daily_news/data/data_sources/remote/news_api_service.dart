import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:http/http.dart';

class BadHttpRequest implements ClientException {
  final String _uri;

  BadHttpRequest(
    this._uri,
  );

  @override
  String get message => "Bad request";

  @override
  Uri? get uri => Uri.parse(_uri);
}

class UnauthorisedHttpRequest implements ClientException {
  final String _uri;

  UnauthorisedHttpRequest(
    this._uri,
  );

  @override
  String get message => "Unauthorised";

  @override
  Uri? get uri => Uri.parse(_uri);
}

class TooManyRequest implements ClientException {
  final String _uri;

  TooManyRequest(
    this._uri,
  );

  @override
  String get message => "Too Many Requests";

  @override
  Uri? get uri => Uri.parse(_uri);
}

class HttpServerException implements ClientException {
  final String _uri;
  HttpServerException(this._uri);

  @override
  String get message => "Internal Server Error";

  @override
  Uri? get uri => Uri.parse(_uri);
}

class HttpUnexpectedException implements ClientException {
  final String messageM;
  HttpUnexpectedException({this.messageM = "Unexpected Error"});
  @override
  String get message => messageM;

  @override
  Uri? get uri => Uri.parse("no url");
}

class NewsApiService {
  Future<DataState> getNewsArticles(
      {required String apiKey,
      required String country,
      required String category}) async {
    try {
      Response httpResponse = await get(
        Uri.parse(urlBuilder(
          apiKey: apiKey,
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
