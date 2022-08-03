import 'package:bloc/bloc.dart' show Bloc, Emitter;
import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:masrimanas_test/data/data.dart';

part 'list_articles_event.dart';
part 'list_articles_state.dart';

class ListArticlesBloc extends Bloc<ListArticlesEvent, ListArticlesState> {
  ListArticlesBloc(
    this._repo,
  ) : super(
          const ListArticlesState(
            status: ArticleState.initial,
            articles: [],
            finished: false,
            page: 1,
          ),
        ) {
    on<ListArticlesFetch>(_fetchArticles, transformer: sequential());
  }

  final ArticleRepository _repo;

  Future<void> _fetchArticles(
    ListArticlesEvent event,
    Emitter<ListArticlesState> emit,
  ) async {
    final result = await _repo.getArticles(state.page);

    result.fold(
      (failure) {
        emit(
          ListArticlesState(
            status: ArticleState.failed,
            articles: state.articles,
            finished: false,
            page: 1,
          ),
        );
      },
      (data) {
        if (data!.isEmpty) {
          emit(
            ListArticlesState(
              status: ArticleState.loaded,
              articles: state.articles,
              finished: true,
              page: state.page,
            ),
          );
        } else {
          emit(
            ListArticlesState(
              status: ArticleState.loaded,
              articles: List.of(state.articles)..addAll(data),
              finished: false,
              page: state.page + 1,
            ),
          );
        }
      },
    );
  }
}
