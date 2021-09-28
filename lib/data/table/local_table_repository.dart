import 'package:hive/hive.dart';
import 'package:producti/domain/table/local_table_repository.dart';
import 'package:producti/domain/table/table.dart';

class LocalTableRepositoryImpl extends LocalTableRepository {
  final Box<Table> _tablesBox;
  final Box<List<String>> _constantsBox;

  LocalTableRepositoryImpl(
    this._tablesBox,
    this._constantsBox,
  );

  @override
  Future<List<Table>> loadData() {
    final order = _constantsBox.get('TABLES_ORDER') ?? [];

    List<Table> result = [];

    for (int i = 0; i < order.length; i++) {
      final table = _tablesBox.get(order[i]);

      result.add(table!);
    }

    return Future.value(result);
  }

  @override
  Future<void> updateData(List<Table> tables) {
    List<String> order = [];

    Map<dynamic, Table> tableValues = {};

    for (int i = 0; i < tables.length; i++) {
      final table = tables[i];

      order.add(table.title);

      tableValues[table.title] = table;
    }

    return Future.wait([
      _constantsBox.put('TABLES_ORDER', order),
      _tablesBox.putAll(tableValues),
    ]);
  }
}
