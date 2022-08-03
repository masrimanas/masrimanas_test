part of 'list_articles_bloc.dart';

abstract class ListArticlesEvent {
  const ListArticlesEvent();
}

class ListArticlesFetch extends ListArticlesEvent {
  const ListArticlesFetch();
}
