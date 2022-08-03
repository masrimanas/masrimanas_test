import 'dart:developer';

import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:masrimanas_test/data/datasource/local_data_source.dart';
import 'package:masrimanas_test/utils/utils.dart';

abstract class DataRepository {
  Future<Either<Failure, List<String>>> getData();
  Future<Either<Failure, void>> saveData(String name, String age);
}

class DataRepositoryImpl implements DataRepository {
  DataRepositoryImpl(this._dataSource);

  final LocalDataSource _dataSource;

  @override
  Future<Either<Failure, List<String>>> getData() async {
    try {
      final result = await _dataSource.getData();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveData(String name, String age) async {
    try {
      await _dataSource.saveData(name, age);
      return Right(log('sukses'));
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
