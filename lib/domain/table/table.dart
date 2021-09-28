import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:producti/domain/core/hive_constants.dart';
import 'package:producti/domain/table/cells/table_cell.dart';

part 'table.g.dart';

@HiveType(typeId: HiveConstants.tableId)
class Table extends Equatable {
  @HiveField(0)
  final String title;

  @HiveField(1, defaultValue: [])
  final List<TableCell> cells;

  Table({
    required this.title,
    this.cells = const [],
  });

  @override
  List<Object?> get props => [title, cells];

  Map<String, dynamic> toJson() => {
        'title': title,
        'cells': cells
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      };

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      title: json['title'] as String,
      cells: (json['cells'] as List<Map<String, dynamic>>)
          .map(
            (e) => TableCell.fromJson(e),
          )
          .toList(),
    );
  }
}
