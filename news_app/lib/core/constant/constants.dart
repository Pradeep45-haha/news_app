const String baseUrl = "https://newsapi.org/v2";

const String _apiKey = "82e976ed8a1d4945b21c818d7abbb7da";
get apiKey {
  return _apiKey;
}

enum CounrtyName {
  india,
  usa,
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

String getCategory(Category? category) {
  String tempCategory = "";
  switch (category) {
    case Category.business:
      tempCategory = "business";
      break;
    case Category.entertainment:
      tempCategory = "entertainment";
      break;
    case Category.general:
      tempCategory = "general";
      break;
    case Category.health:
      tempCategory = "health";
      break;
    case Category.science:
      tempCategory = "science";
      break;
    case Category.sports:
      tempCategory = "sports";
      break;
    case Category.technology:
      tempCategory = "technology";
      break;
    default:
      tempCategory = "general";
      break;
  }
  return tempCategory;
}

Map<String, String> countryNameAndCode = {"India": "in", "USA": "us"};

String getCountryCode({required CounrtyName? counrtyName}) {
  if (counrtyName == CounrtyName.india) {
    return countryNameAndCode["India"]!;
  }
  if (counrtyName == CounrtyName.usa) {
    return countryNameAndCode["USA"]!;
  }
  return countryNameAndCode["India"]!;
}
