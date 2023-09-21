part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

final class GetArticlesEvent extends ArticleEvent {
  const GetArticlesEvent();
}
