import 'package:flutter/material.dart';
import 'package:news_app/core/constant/constants.dart';

String urlBuilder({
  String? country,
  String? category,
  String? apiKey,
  String? sortBy,
  String? getNewsByMatchingText,
  int articlesPerPage = 20,
  int page = 1,
}) {
  apiKey = getApiKey;
  List<String> parameterList = [
    "category=$category&",
    "q=$getNewsByMatchingText&",
  ];
  String url = "$baseUrl/top-headlines?country=$country&";

  if (getNewsByMatchingText != null) {
    url = "$url${parameterList[1]}";
    return url = "${url}pageSize=$articlesPerPage&page=$page&apiKey=$apiKey";
  }
  if (category != null) {
    url = "$url${parameterList[0]}";
  }
  url = "${url}pageSize=$articlesPerPage&page=$page&apiKey=$apiKey";
  debugPrint("url value: $url");
  return url;

  // return "https://newsapi.org/v2/everything?q=bitcoin&apiKey=82e976ed8a1d4945b21c818d7abbb7da";
}
