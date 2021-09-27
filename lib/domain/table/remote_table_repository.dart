import 'package:dartz/dartz.dart';
import 'package:producti/application/core/error/failure.dart';
import 'package:producti/domain/table/table.dart';

abstract class RemoteTableRepository {
  /// Loading all user data from Firebase.
  Future<Either<Failure, List<Table>>> loadData(String userUid);

  /// Saving new data on Firebase.
  Future<Either<Failure, void>> updateData(String userUid, List<Table> tables);
}
