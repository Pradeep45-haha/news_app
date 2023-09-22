import 'package:news_app/core/constant/constants.dart';

String urlBuilder({
  String? country,
  String? category,
  required String apiKey,
  String? sortBy,
  String? getNewsByMatchingText,
}) {
  List<String> parameterList = [
    "category=$category&",
    "q=$getNewsByMatchingText&"
  ];
  String url = "$baseUrl/top-headlines?country=$country&";

  if (getNewsByMatchingText != null) {
    url = "$url${parameterList[1]}";
  }
  if (category != null) {
    url = "$url${parameterList[0]}apiKey=$apiKey";
  } else {
    url = "$url{apiKey=$apiKey}";
  }

  return url;
}
