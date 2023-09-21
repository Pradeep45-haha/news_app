import 'package:news_app/core/constant/constants.dart';

String urlBuilder({
  String? country,
  String? category,
  required String apiKey,
  String? sortBy,
  String? getNewsByMatchingText,
}) {
  return "$baseUrl/top-headlines?country=$country&category=$category&sortby=$sortBy&apiKey=$apiKey";
}
