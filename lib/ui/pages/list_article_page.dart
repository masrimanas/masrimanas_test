import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocConsumer, ReadContext;
import 'package:masrimanas_test/blocs/blocs.dart';
import 'package:masrimanas_test/ui/widgets/article_view.dart';

class ListArticlePage extends StatefulWidget {
  const ListArticlePage({super.key});

  static const route = '/list-article';

  @override
  State<ListArticlePage> createState() => _ListArticlePageState();
}

class _ListArticlePageState extends State<ListArticlePage> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<ListArticlesBloc>().add(const ListArticlesFetch());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 1);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(
      () => context.read<ListArticlesBloc>().add(const ListArticlesFetch()),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ListArticlesBloc, ListArticlesState>(
        listener: (context, state) {
          if (state.finished) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('anda sudah di record terakhir'),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case ArticleState.failed:
              return const Center(child: Text('failed to fetch posts'));
            case ArticleState.loaded:
              if (state.articles.isEmpty) {
                return const Center(child: Text('no posts'));
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.articles.length
                      ? const BottomLoader()
                      : ListArticlesView(
                          item: state.articles[index],
                        );
                },
                itemCount: state.finished
                    ? state.articles.length
                    : state.articles.length + 1,
                controller: _scrollController,
              );
            case ArticleState.initial:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
