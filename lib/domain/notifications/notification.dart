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
}
