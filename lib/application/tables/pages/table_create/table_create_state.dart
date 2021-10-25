part of 'table_create_cubit.dart';

class TableCreateState extends Equatable {
  final List<Table> tables;

  final String tableName;

  final bool showErrors;

  const TableCreateState({
    required this.tables,
    this.tableName = '',
    this.showErrors = false,
  });

  @override
  List<Object> get props => [tables, tableName, showErrors];

  ErrorCode? get error {
    if (tableName.isEmpty) return ErrorCode.voidValue;

    if (tables.any((element) => element.title == tableName)) {
      return ErrorCode.tableAlreadyExists;
    }
  }

  TableCreateState copyWith({
    List<Table>? tables,
    String? tableName,
    bool? showErrors,
  }) {
    return TableCreateState(
      tables: tables ?? this.tables,
      tableName: tableName ?? this.tableName,
      showErrors: showErrors ?? this.showErrors,
    );
  }
}
