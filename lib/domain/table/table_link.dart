import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/table.dart';

class TableLink {
  final List<int> path;

  const TableLink(this.path);

  TableCell? getParticle(Table table) {
    TableCell cell = table.cells[path[0]];

    if (cell is! GroupTableCell) return cell;

    GroupTableCell? tableCell;

    for (int i = 1; i < path.length; i++) {
      TableCell c =
          tableCell != null ? tableCell.children[i] : cell.children[i];

      if (c is! GroupTableCell) return c;

      tableCell = c;
    }
  }
}
