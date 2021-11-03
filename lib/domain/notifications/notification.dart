import 'package:equatable/equatable.dart';

import 'package:producti/domain/table/table_link.dart';

class Notification extends Equatable {
  final int id;
  final String title;
  final String body;
  final DateTime time;
  final TableLink pathToNotification;

  const Notification({
    required this.time,
    required this.body,
    required this.id,
    required this.title,
    required this.pathToNotification,
  });

  @override
  List<Object?> get props => [
        id,
      ];

  Notification copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? time,
    TableLink? pathToNotification,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      time: time ?? this.time,
      pathToNotification: pathToNotification ?? this.pathToNotification,
    );
  }
}
