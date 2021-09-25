import 'package:producti/domain/table/table_cell.dart';
import 'package:producti/domain/table/values/link.dart';

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
