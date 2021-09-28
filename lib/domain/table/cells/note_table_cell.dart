part of 'table_cell.dart';

@HiveType(typeId: HiveConstants.noteTableCellId)
class NoteTableCell extends TableCell {
  @HiveField(0)
  final String description;
  @HiveField(1)
  final List<Link> links;

  NoteTableCell({
    this.description = '',
    this.links = const [],
    @HiveField(2) String title = '',
  }) : super(title);

  @override
  List<Object?> get props => [description, links, title];

  Map<String, dynamic> toJson() => {
        'description': description,
        'links': links
            .map(
              (e) => e.getOrCrash(),
            )
            .toList(),
        'title': title,
      };

  factory NoteTableCell.fromJson(Map<String, dynamic> json) {
    return NoteTableCell(
      description: json['description'] as String,
      links: (json['links'] as List<String>)
          .map(
            (e) => Link(e),
          )
          .toList(),
      title: json['title'] as String,
    );
  }
}
