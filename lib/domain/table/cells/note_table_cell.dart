part of 'table_cell.dart';

class NoteTableCell extends TableCell {
  final String description;
  final List<Link> links;

  NoteTableCell({
    this.description = '',
    this.links = const [],
    String title = '',
  }) : super(title);

  @override
  List<Object?> get props => [description, links, title];
}
