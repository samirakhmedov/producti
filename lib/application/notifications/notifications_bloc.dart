import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:producti/data/core/error/failure.dart';
import 'package:producti/data/notifications/local_notification_repository.dart';
import 'package:producti/domain/notifications/notification.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/table.dart';
import 'package:producti/domain/table/table_link.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

@singleton
class LocalNotificationsBloc
    extends Bloc<LocalNotificationsEvent, LocalNotificationsState> {
  final LocalNotificationRepository _notificationRepository;

  List<TableLink> _getNotificationsPaths(
      List<TableCell> cells, TableLink root) {
    final paths = <TableLink>[];

    for (int i = 0; i < cells.length; i++) {
      final c = cells[i];

      if (c is NotificationTableCell) paths.add(root.addPath(i));
      if (c is GroupTableCell) {
        paths.addAll(
          _getNotificationsPaths(
            c.children,
            root.addPath(i),
          ),
        );
      }
    }

    return paths;
  }

  LocalNotificationsBloc(this._notificationRepository)
      : super(const LocalNotificationsState()) {
    on<LocalNotificationsInitialise>((event, emit) async {
      final result = await _notificationRepository.setup(
        (payload) {
          add(LocalNotificationsNotificationHandle(payload!));
        },
      );

      final launchDetails = await _notificationRepository.getAppLaunchDetails();

      result.fold(
        (failure) => emit(
          state.copyWith(
            failure: failure,
          ),
        ),
        (_) => null,
      );

      if (launchDetails?.didNotificationLaunchApp ?? false) {
        final payload = launchDetails!.payload;

        if (payload != null) add(LocalNotificationsNotificationHandle(payload));
      }
    });

    on<LocalNotificationsNotificationHandle>(
      (event, emit) {
        final data = TableLink.parsefromId(event.payload);

        emit(
          state.copyWith(
            pathToNotification: data.value2,
            tableIndex: data.value1,
          ),
        );
      },
    );

    on<LocalNotificationsAddNotification>(
      (event, emit) => _notificationRepository.setNotification(
        event.notification,
        tableIndex: event.tableIndex,
      ),
    );

    on<LocalNotificationsCellDelete>(
      (event, emit) async {
        final cell = event.pathToCell.getParticle(event.table);

        if (cell is GroupTableCell) {
          final paths = _getNotificationsPaths(cell.children, event.pathToCell);

          await _notificationRepository.deleteNotifications(
            paths
                .map(
                  (e) => e.getId(event.tableIndex),
                )
                .toList(),
          );
        } else if (cell is NotificationTableCell) {
          await _notificationRepository.deleteNotifications(
            [
              event.pathToCell.getId(
                event.tableIndex,
              ),
            ],
          );
        }
      },
    );
  }
}
