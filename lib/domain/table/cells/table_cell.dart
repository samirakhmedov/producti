import 'package:equatable/equatable.dart';
import 'package:producti/domain/table/values/link.dart';

part 'group_table_cell.dart';
part 'note_table_cell.dart';
part 'notification_table_cell.dart';

abstract class TableCell extends Equatable {
  final String title;

  TableCell(this.title);
}
