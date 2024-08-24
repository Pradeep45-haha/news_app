import 'package:news_app/core/resources/data_state.dart';

abstract class NewsRepository {
  Future<DataState> openNews({required String url});
}
