import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/table.dart';

class TableLink extends Equatable {
  final List<int> path;

  const TableLink(this.path);

  bool get isEmpty => path.isEmpty;

  int get first => path.first;

  List<TableCell> getParticles(Table table) {
    if (path.isEmpty) return table.cells;

    final group = getParticle(table);

    if (group is GroupTableCell) return group.children;

    return [];
  }

  TableCell getParticle(Table table) {
    TableCell cell = table.cells[path[0]];

    if (cell is! GroupTableCell) return cell;

    if (path.length >= 2) {
      GroupTableCell tableCell = cell;

      for (int i = 1; i < path.length; i++) {
        TableCell c = tableCell.children[path[i]];

        if (c is! GroupTableCell) return c;

        tableCell = c;
      }

      return tableCell;
    }

    return cell;
  }

  int getId(int tableIndex) {
    String strPath = path
        .map(
          (e) => e.toString(),
        )
        .join();

    strPath = (tableIndex + 1).toString() + strPath;

    return int.parse(strPath);
  }

  String toRawString(int tableIndex) {
    String strPath = path
        .map(
          (e) => e.toString(),
        )
        .join('-');

    return '$tableIndex-$strPath';
  }

  static Tuple2<int, TableLink> parsefromId(String id) {
    final markIndex = id.indexOf('-');

    final tableIndex = int.parse(
      id.substring(0, markIndex),
    );

    final pathStr = id.substring(markIndex + 1);

    final path = pathStr
        .split('-')
        .map(
          (e) => int.parse(e),
        )
        .toList();

    return Tuple2(tableIndex, TableLink(path));
  }

  TableLink addPath(int index) => TableLink(
        List<int>.of(path)..add(index),
      );

  TableLink popPath() => TableLink(
        List<int>.of(path)..removeLast(),
      );

  @override
  List<Object?> get props => path;
}
