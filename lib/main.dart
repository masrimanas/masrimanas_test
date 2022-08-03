import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocOverrides, BlocProvider, MultiBlocProvider;
import 'package:masrimanas_test/blocs/list_articles/list_articles_bloc.dart';
import 'package:masrimanas_test/blocs/save_data/save_data_bloc.dart';
import 'package:masrimanas_test/injection.dart' as di;
import 'package:masrimanas_test/ui/ui.dart';
import 'package:masrimanas_test/utils/utils.dart';

void main() {
  di.init();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ListArticlesBloc(di.locator()),
        ),
        BlocProvider(
          create: (_) => SaveDataBloc(di.locator())..add(const SaveDataLoad()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case ListArticlePage.route:
              return MaterialPageRoute(builder: (_) => const ListArticlePage());
            case SaveDataPage.route:
              return MaterialPageRoute(builder: (_) => const SaveDataPage());
            default:
              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('Terjadi kesalahan!'),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              child: CustomButton(
                color: Colors.blue,
                text: 'List Articles',
                radius: 20,
                onPressed: () {
                  Navigator.pushNamed(context, ListArticlePage.route);
                },
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(100, 10, 100, 50),
              child: CustomButton(
                color: Colors.blue,
                text: 'Simpan Data',
                radius: 20,
                onPressed: () {
                  Navigator.pushNamed(context, SaveDataPage.route);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
