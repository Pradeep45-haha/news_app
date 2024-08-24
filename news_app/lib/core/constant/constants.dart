const String baseUrl = "https://newsapi.org/v2";

const String _apiKey = "82e976ed8a1d4945b21c818d7abbb7da";
String get getApiKey {
  return _apiKey;
}

enum CountryName {
  india,
  usa,
}

enum SortNewsBy {
  relevancy,
  popularity,
  publishedAt,
}

enum Category {
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology,
}


Map<String, String> countryNameAndCode = {"India": "in", "USA": "us"};

String getCountryCode({required CountryName? countryName}) {
  if (countryName == CountryName.india) {
    return countryNameAndCode["India"]!;
  }
  if (countryName == CountryName.usa) {
    return countryNameAndCode["USA"]!;
  }
  return countryNameAndCode["India"]!;
}
