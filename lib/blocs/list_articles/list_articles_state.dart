part of 'list_articles_bloc.dart';

enum ArticleState { initial, loaded, failed }

class ListArticlesState extends Equatable {
  const ListArticlesState({
    required this.articles,
    required this.page,
    required this.status,
    required this.finished,
  });

  final List<Article> articles;
  final int page;
  final ArticleState status;
  final bool finished;

  @override
  List<Object> get props => [
        articles,
        finished,
        page,
        status,
      ];
}
