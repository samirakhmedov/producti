import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:producti/domain/table/cells/table_cell.dart' as t;
import 'package:producti/domain/table/local_table_repository.dart';
import 'package:producti/domain/table/table.dart';
import 'package:producti/domain/table/table_link.dart';

part 'anonymous_table_event.dart';
part 'anonymous_table_state.dart';

@lazySingleton
class AnonymousTableBloc
    extends Bloc<AnonymousTableEvent, AnonymousTableState> {
  final LocalTableRepository _localTableRepository;

  AnonymousTableBloc(this._localTableRepository)
      : super(AnonymousTableInitial()) {
    add(AnonymousTableLoad());
  }

  @override
  Stream<AnonymousTableState> mapEventToState(
      AnonymousTableEvent event) async* {
    if (event is AnonymousTableLoad) {
      final result = await _localTableRepository.loadData();

      yield AnonymousTableLoaded(result);
    }

    if (event is AnonymousTableCreate) {
      final loadedState = state as AnonymousTableLoaded;

      yield loadedState.copyWith(
        tables: List.of(loadedState.tables)
          ..add(
            Table(
              title: event.name,
            ),
          ),
      );
    }

    if (event is AnonymousTableGroupCreate) {
      final loadedState = state as AnonymousTableLoaded;

      final currentTable = loadedState.tables[event.tableIndex];

      currentTable.addCell(
        t.GroupTableCell(
          title: event.name,
          parent: event.path?.getParticle(currentTable) ?? currentTable,
        ),
        path: event.path,
      );

      yield loadedState.copyWith(
        tables: loadedState.tables,
      );
    }

    if (event is AnonymousTableSave) {
      final loadedState = state as AnonymousTableLoaded;

      await _localTableRepository.updateData(loadedState.tables);
    }
  }
}
