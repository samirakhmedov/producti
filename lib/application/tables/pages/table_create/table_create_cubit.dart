import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/domain/table/table.dart';

part 'table_create_state.dart';

class TableCreateCubit extends Cubit<TableCreateState> {
  final List<Table> tables;

  TableCreateCubit(
    this.tables,
  ) : super(TableCreateState(tables: tables));

  void mutate({
    String? tableName,
    bool? showErrors,
  }) =>
      emit(
        state.copyWith(
          showErrors: showErrors,
          tableName: tableName,
        ),
      );
}
