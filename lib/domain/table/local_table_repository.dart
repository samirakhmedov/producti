import 'package:dartz/dartz.dart';
import 'package:producti/application/core/error/failure.dart';
import 'package:producti/domain/table/table.dart';

abstract class LocalTableRepository {
  /// Loading all user data from cache.
  Future<Either<Failure, List<Table>>> loadData();

  /// Saving new data in cache.
  Future<Either<Failure, void>> updateData(List<Table> tables);
}
