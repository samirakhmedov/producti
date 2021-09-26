part of 'table_cell.dart';

class NotificationTableCell extends TableCell {
  final DateTime time;
  final String description;
  final List<Link> links;

  NotificationTableCell({
    required this.time,
    this.description = '',
    this.links = const [],
    String title = '',
  }) : super(title);

  @override
  List<Object?> get props => [time, description, links, title];
}
