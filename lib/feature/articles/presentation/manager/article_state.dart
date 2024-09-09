part of 'article_bloc.dart';

abstract class ArticleState {
  const ArticleState();
}

class ArticlesInitial extends ArticleState {}

class OnLoading extends ArticleState {}

class OnGetArticles extends ArticleState {
  final List<Article> articles;

  OnGetArticles({required this.articles});
}

class OnGetArticlesFailure extends ArticleState {
  final Failure failure;

  OnGetArticlesFailure({required this.failure});
}
