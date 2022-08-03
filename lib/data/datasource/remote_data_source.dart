import 'package:dio/dio.dart' show Dio;
import 'package:masrimanas_test/data/model/article.dart';
import 'package:masrimanas_test/utils/utils.dart';

class DioClient {
  factory DioClient() => _singleton;

  DioClient._internal();

  final dio = createDio();

  static final _singleton = DioClient._internal();

  static Dio createDio() {
    final dio = Dio();

    return dio;
  }
}

// ignore: one_member_abstracts
abstract class RemoteDataSource {
  Future<List<Article>>? getArticle(int page);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl(
    this.client,
  );

  final DioClient client;

  String baseUrl = 'https://jsonplaceholder.typicode.com/';

  @override
  Future<List<Article>>? getArticle(
    int page,
  ) async {
    final response = await client.dio.get<List<dynamic>>(
      '${baseUrl}posts?_start=0&_limit=20&_page=$page',
    );
    if (response.data != null) {
      final data =
          response.data!.map((e) => e as Map<String, dynamic>).toList();
      final result = articleToList(data);
      // log(response.data.toString());
      return result;
    } else {
      throw ServerException();
    }
  }
}
