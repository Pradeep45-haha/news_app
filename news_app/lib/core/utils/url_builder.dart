import 'package:news_app/core/constant/constants.dart';



String urlBuilder(
    {required String country,
    required String category,
    required String apiKey}) {
  return "$baseUrl/top-headlines?country=$country&category=$category&apiKey=$apiKey";
}