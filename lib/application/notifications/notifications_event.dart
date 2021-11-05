part of 'notifications_bloc.dart';

abstract class LocalNotificationsEvent {
  const LocalNotificationsEvent();
}

class LocalNotificationsInitialise extends LocalNotificationsEvent {}

class LocalNotificationsNotificationHandle extends LocalNotificationsEvent {
  final String payload;

  const LocalNotificationsNotificationHandle(this.payload);
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
}

class LocalNotificationsAddNotification extends LocalNotificationsEvent {
  final Notification notification;
  final int tableIndex;

  const LocalNotificationsAddNotification(this.notification, this.tableIndex);
}
