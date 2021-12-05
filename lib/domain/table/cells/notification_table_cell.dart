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
  @HiveField(3)
  final String title;

  NotificationTableCell({
    required this.time,
    this.description = '',
    this.links = const [],
    this.title = '',
  }) : super(title);

  @override
  List<Object?> get props => [
        time,
        description,
        links,
        title,
      ];

  @override
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
