part of 'notifications_bloc.dart';

class LocalNotificationsState extends Equatable {
  final TableLink? pathToNotification;
  final int? tableIndex;
  final Failure? failure;

  const LocalNotificationsState({
    this.tableIndex,
    this.pathToNotification,
    this.failure,
  });

  @override
  List<Object> get props => [pathToNotification ?? 0, failure ?? 0];

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
