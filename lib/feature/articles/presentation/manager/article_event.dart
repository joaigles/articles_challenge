part of 'article_bloc.dart';

@immutable
abstract class ArticleEvent {}

class ActionGetArticles extends ArticleEvent {
  final String path;

  ActionGetArticles(this.path);
}