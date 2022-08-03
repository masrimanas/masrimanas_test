import 'package:dartz/dartz.dart';
import 'package:masrimanas_test/data/data.dart';
import 'package:masrimanas_test/utils/utils.dart';

// ignore: one_member_abstracts
abstract class ArticleRepository {
  Future<Either<Failure, List<Article>?>> getArticles(int page);
}

class ArticleRepositoryImpl implements ArticleRepository {
  const ArticleRepositoryImpl(this._dataSource);

  final RemoteDataSource _dataSource;

  @override
  Future<Either<Failure, List<Article>?>> getArticles(int page) async {
    try {
      final result = await _dataSource.getArticle(page);
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
