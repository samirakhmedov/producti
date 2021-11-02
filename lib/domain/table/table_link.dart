import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/table.dart';

class TableLink {
  final List<int> path;

  const TableLink(this.path);

  bool get isEmpty => path.isEmpty;

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

  TableLink addPath(int index) => TableLink(
        List<int>.of(path)..add(index),
      );

  TableLink popPath() => TableLink(
        List<int>.of(path)..removeLast(),
      );
}
