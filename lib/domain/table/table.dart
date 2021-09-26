import 'package:equatable/equatable.dart';
import 'package:producti/domain/table/cells/table_cell.dart';

class Table extends Equatable {
  final String title;
  final List<TableCell> cells;

  Table({
    required this.title,
    this.cells = const [],
  });

  @override
  List<Object?> get props => [title, cells];
}
