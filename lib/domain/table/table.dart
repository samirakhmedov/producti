import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'package:producti/domain/core/hive_constants.dart';
import 'package:producti/domain/table/cells/table_cell.dart' as t;
import 'package:producti/domain/table/table_link.dart';

part 'table.g.dart';

@HiveType(typeId: HiveConstants.tableId)
@immutable
class Table extends t.TableCell {
  @override
  @HiveField(0)
  String title;

  @HiveField(1, defaultValue: [])
  List<t.TableCell> cells;

  Table({
    required this.title,
    this.cells = const [],
  }) : super(title, null);

  @override
  List<Object?> get props => [title, cells];

  @override
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
            (e) => t.TableCell.fromJson(e),
          )
          .toList(),
    );
  }

  void addCell(t.TableCell cell, {TableLink? path}) {
    if (path != null) {
      final group = path.getParticle(this) as t.GroupTableCell;

      group.children = [...group.children, cell];

      return;
    }

    cells = [...cells, cell];
  }

  void reorderCells(int oldIndex, int newIndex, {TableLink? path}) {
    late int newIndexValue;

    if (path != null) {
      final group = path.getParticle(this) as t.GroupTableCell;

      newIndexValue = newIndex == group.children.length
          ? group.children.length - 1
          : newIndex;

      final cell = group.children[newIndexValue];

      group.children[newIndexValue] = group.children[oldIndex];

      group.children[oldIndex] = cell;

      return;
    }

    newIndexValue = newIndex == cells.length ? cells.length - 1 : newIndex;

    final cell = cells[newIndexValue];

    cells[newIndexValue] = cells[oldIndex];

    cells[oldIndex] = cell;
  }

  Table copyWith({
    String? title,
    List<t.TableCell>? cells,
  }) {
    return Table(
      title: title ?? this.title,
      cells: cells ?? this.cells,
    );
  }
}
