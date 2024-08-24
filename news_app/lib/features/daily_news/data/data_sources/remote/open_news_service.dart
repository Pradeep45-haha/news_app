import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/resources/http_exception.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenNewsService {
  Future<DataState> openNewsService({required String url}) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView)) {
      return DataException(clientException: HttpUnexpectedException());
    }
    return const DataSuccess(null);
  }
}
