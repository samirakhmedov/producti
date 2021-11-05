part of 'notifications_bloc.dart';

class LocalNotificationsState {
  final TableLink? pathToNotification;
  final int? tableIndex;
  final Failure? failure;

  const LocalNotificationsState({
    this.tableIndex,
    this.pathToNotification,
    this.failure,
  });

  LocalNotificationsState copyWith({
    TableLink? pathToNotification,
    int? tableIndex,
    Failure? failure,
  }) {
    return LocalNotificationsState(
      pathToNotification: pathToNotification ?? this.pathToNotification,
      tableIndex: tableIndex ?? this.tableIndex,
      failure: failure ?? this.failure,
    );
  }
}
