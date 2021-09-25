import 'package:producti/domain/table/table_cell.dart';
import 'package:producti/domain/table/values/link.dart';

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
