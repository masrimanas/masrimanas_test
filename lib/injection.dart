import 'package:get_it/get_it.dart' show GetIt;
import 'package:masrimanas_test/data/data.dart';

final locator = GetIt.instance;

void init() {
  // data sources
  locator
    ..registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(
        locator(),
      ),
    )
    ..registerLazySingleton<LocalDataSource>(
      LocalDataSourceImpl.new,
    )

    // repository
    ..registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(
        locator(),
      ),
    )
    ..registerLazySingleton<DataRepository>(
      () => DataRepositoryImpl(
        locator(),
      ),
    )

    // external
    ..registerLazySingleton(DioClient.new);
}
