part of 'notifications_bloc.dart';

abstract class LocalNotificationsEvent extends Equatable {
  const LocalNotificationsEvent();

  @override
  List<Object> get props => [];
}

class LocalNotificationsInitialise extends LocalNotificationsEvent {}

class LocalNotificationsNotificationHandle extends LocalNotificationsEvent {
  final String payload;

  const LocalNotificationsNotificationHandle(this.payload);

  @override
  List<Object> get props => [payload];
}

class LocalNotificationsCellDelete extends LocalNotificationsEvent {
  final Table table;
  final int tableIndex;
  final TableLink pathToCell;

  const LocalNotificationsCellDelete(
    this.table,
    this.pathToCell,
    this.tableIndex,
  );

  @override
  List<Object> get props => [table, tableIndex, pathToCell];
}

class LocalNotificationsAddNotification extends LocalNotificationsEvent {
  final Notification notification;
  final int tableIndex;

  const LocalNotificationsAddNotification(this.notification, this.tableIndex);

  @override
  List<Object> get props => [notification, tableIndex];
}
