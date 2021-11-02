import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:producti/data/notifications/local_notification_repository.dart';
import 'package:producti/domain/notifications/notification.dart';
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
  final LocalNotificationRepository _localNotificationRepository;

  AnonymousTableBloc(
    this._localTableRepository,
    this._localNotificationRepository,
  ) : super(AnonymousTableInitial()) {
    add(AnonymousTableLoad());
  }

  @override
  Stream<AnonymousTableState> mapEventToState(
      AnonymousTableEvent event) async* {
    if (event is AnonymousTableLoad) {
      final result = _localTableRepository.loadData();

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

    if (event is AnonymousTableCellCreate) {
      final loadedState = state as AnonymousTableLoaded;

      final currentTable = loadedState.tables[event.tableIndex];

      currentTable.addCell(
        event.cell,
        event.path,
      );

      if (event.cell is t.NotificationTableCell) {
        final cell = event.cell as t.NotificationTableCell;

        final cells = event.path.getParticles(currentTable);

        // _localNotificationRepository.setNotification(
        //   Notification(
        //     time: cell.time,
        //     body: cell.description,
        //     // id: cell.id,
        //     title: cell.title,
        //     pathToNotification: event.path,
        //   ),
        // );
      }

      yield loadedState.copyWith(
        tables: loadedState.tables,
      );
    }

    if (event is AnonymousTableReorderCells) {
      final loadedState = state as AnonymousTableLoaded;

      final currentTable = loadedState.tables[event.tableIndex];

      currentTable.reorderCells(
        event.oldIndex,
        event.newIndex,
        event.path,
      );

      yield loadedState.copyWith(
        tables: loadedState.tables,
      );
    }

    if (event is AnonymousTableChangeCell) {
      final loadedState = state as AnonymousTableLoaded;

      final currentTable = loadedState.tables[event.tableIndex];

      final newPathList = List.of(event.pathToNote.path);

      newPathList.removeLast();

      final pathToGroup = TableLink(newPathList);

      if (pathToGroup.isEmpty) {
        currentTable.cells[event.pathToNote.path.last] = event.newCell;
      } else {
        final group = pathToGroup.getParticle(currentTable) as t.GroupTableCell;

        group.children[event.pathToNote.path.last] = event.newCell;
      }

      yield loadedState.copyWith(
        tables: loadedState.tables,
      );
    }

    if (event is AnonymousTableRenameTable) {
      final loadedState = state as AnonymousTableLoaded;

      final currentTable = loadedState.tables[event.tableIndex];

      currentTable.title = event.tableName;

      yield loadedState.copyWith(
        tables: loadedState.tables,
      );
    }

    if (event is AnonymousTableRenameCell) {
      final loadedState = state as AnonymousTableLoaded;

      final currentTable = loadedState.tables[event.tableIndex];

      final cell = event.path.getParticle(currentTable);

      cell.title = event.name;

      yield loadedState.copyWith(
        tables: loadedState.tables,
      );
    }

    if (event is AnonymousTableDeleteCell) {
      final loadedState = state as AnonymousTableLoaded;

      final currentTable = loadedState.tables[event.tableIndex];

      final parentGroupLink = event.pathToCell.popPath();

      final cells = parentGroupLink.getParticles(currentTable);

      cells.removeAt(event.pathToCell.path.last);

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
