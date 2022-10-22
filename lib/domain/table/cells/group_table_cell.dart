part of 'table_cell.dart';

@HiveType(typeId: HiveConstants.groupTableCellId)
class GroupTableCell extends TableCell {
  @HiveField(0)
  List<TableCell> children;

  GroupTableCell({
    @HiveField(1) String title = '',
    this.children = const [],
  }) : super(title);

  @override
  List<Object?> get props => [title, children];

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'children': children
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      };

  factory GroupTableCell.fromJson(Map<String, dynamic> json) {
    return GroupTableCell(
      title: json['title'] as String,
      children: (json['children'] as List<Map<String, dynamic>>)
          .map(
            (e) => TableCell.fromJson(e),
          )
          .toList(),
    );
  }
}
