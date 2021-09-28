import 'package:producti/domain/table/table.dart';

abstract class LocalTableRepository {
  /// Loading all user data from cache.
  Future<List<Table>> loadData();

  /// Saving new data in cache.
  Future<void> updateData(List<Table> tables);
}
