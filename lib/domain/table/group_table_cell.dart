import 'package:producti/domain/table/table_cell.dart';

class GroupTableCell extends TableCell {
  final List<TableCell> children;

  GroupTableCell({
    String title = '',
    this.children = const [],
  }) : super(title);

  @override
  List<Object?> get props => [title, children];
}
