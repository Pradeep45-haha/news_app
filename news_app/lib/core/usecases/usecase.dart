abstract class UseCase<Type, Params> {
  dynamic call({required Params params});
}

class SearchParams {
  final String country;
  final String category;
  final String sortBy;
  final String getNewsByMatchingText;
  final int pageSize;
  final int pageNum;

  SearchParams(
      {required this.country,
      required this.category,
      required this.sortBy,
      required this.getNewsByMatchingText,
      required this.pageNum,
      required this.pageSize});
  @override
  String toString() {
    return '''Country: $country, Category: $category, SortBy: $sortBy, GetNewsByMatchingText $getNewsByMatchingText, PageSize: $pageSize, PageNum: $pageNum''';
  }
}
