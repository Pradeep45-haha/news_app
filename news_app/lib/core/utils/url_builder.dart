import 'package:news_app/core/constant/constants.dart';

String urlBuilder({
  String? country,
  String? category,
  required String apiKey,
  String? sortBy,
  String? getNewsByMatchingText,
  int articlesPerPage = 20,
  int page = 1,
}) {
  List<String> parameterList = [
    "category=$category&",
    "q=$getNewsByMatchingText&",
  ];
  String url =
      "$baseUrl/top-headlines?country=$country&pageSize=$articlesPerPage&page=$page";

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
