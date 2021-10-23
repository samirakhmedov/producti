part of 'table_cell.dart';

@HiveType(typeId: HiveConstants.notificationTableCellId)
@immutable
class NotificationTableCell extends TableCell {
  @HiveField(0)
  final DateTime time;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final List<String> links;

  NotificationTableCell({
    required this.time,
    this.description = '',
    this.links = const [],
    @HiveField(3) String title = '',
    TableCell? parent,
  }) : super(title, parent);

  @override
  List<Object?> get props => [time, description, links, title, parent];

  Map<String, dynamic> toJson() => {
        'description': description,
        'links': links,
        'title': title,
        'date': Timestamp.fromDate(time),
      };

  factory NotificationTableCell.fromJson(Map<String, dynamic> json) {
    return NotificationTableCell(
      description: json['description'] as String,
      links: json['links'] as List<String>,
      title: json['title'] as String,
      time: Timestamp.fromMicrosecondsSinceEpoch(json['date'] as int).toDate(),
    );
  }
}
