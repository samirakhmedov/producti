import 'package:flutter/material.dart';
import 'package:producti/domain/table/cells/table_cell.dart' as t;
import 'package:producti_ui/producti_ui.dart';

class TableCellTile extends StatelessWidget {
  final t.TableCell cell;
  final void Function()? onTap;

  const TableCellTile({Key? key, required this.cell, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cell is t.GroupTableCell) {
      return _GroupTableCellTile(
        cell as t.GroupTableCell,
        onTap: onTap,
      );
    }

    return const SizedBox();
  }
}

class _GroupTableCellTile extends StatelessWidget {
  final t.GroupTableCell cell;
  final void Function()? onTap;

  const _GroupTableCellTile(this.cell, {Key? key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final theme = ThemeHelper.getTheme(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: theme.primaryColor,
              width: 3,
            ),
          ),
        ),
        height: 45,
        width: size.width,
        child: Row(
          children: [
            const Gap(),
            Expanded(
              child: Text(cell.title),
            ),
            const Icon(
              Icons.menu,
            ),
            const Gap(),
          ],
        ),
      ),
    );
  }
}
