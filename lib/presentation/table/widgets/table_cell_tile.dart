import 'package:flutter/material.dart';
import 'package:producti/domain/table/cells/table_cell.dart' as t;
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/table/widgets/time_widget.dart';
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

    if (cell is t.CheckListTableCell) {
      return _CheckListTableCell(
        cell as t.CheckListTableCell,
        onTap: onTap,
      );
    }

    if (cell is t.NoteTableCell) {
      return _NoteTableCellTile(
        cell: cell as t.NoteTableCell,
        onTap: onTap,
      );
    }

    if (cell is t.NotificationTableCell) {
      return _NotificationTableCellTile(
        cell: cell as t.NotificationTableCell,
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
              child: Text(
                cell.title,
                style: theme.textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.menu,
              color: theme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteTableCellTile extends StatelessWidget {
  final t.NoteTableCell cell;
  final void Function()? onTap;

  const _NoteTableCellTile({
    Key? key,
    required this.cell,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

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
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const _Dot(),
                  const Gap(),
                  Expanded(
                    child: cell.title.isEmpty
                        ? const VoidTextValue()
                        : Text(
                            cell.title,
                            style: textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                  if (cell.links.isNotEmpty)
                    Icon(
                      Icons.link,
                      color:
                          ThemeHelper.isDarkMode(context) ? kLightGray : kGray,
                    ),
                ],
              ),
              if (cell.description.isEmpty)
                const VoidTextValue()
              else
                LimitedBox(
                  maxHeight: 150,
                  child: Text(
                    cell.description,
                    style: textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckListTableCell extends StatelessWidget {
  final t.CheckListTableCell cell;
  final void Function()? onTap;

  const _CheckListTableCell(this.cell, {Key? key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

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
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cell.title,
                    style: textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Icon(
                    Icons.list_rounded,
                    color: theme.primaryColor,
                  ),
                ],
              ),
              ...cell.checkList.map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _Dot(),
                      const Gap(),
                      Text(
                        e.title,
                        style: theme.textTheme.bodyText2!.copyWith(
                          decoration: e.value
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      const Gap(),
                      if (e.value)
                        const Icon(
                          Icons.check,
                          color: kGreen,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationTableCellTile extends StatelessWidget {
  final t.NotificationTableCell cell;
  final void Function()? onTap;

  const _NotificationTableCellTile({
    Key? key,
    required this.cell,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

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
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimeWidget(
                    time: cell.time,
                  ),
                  if (cell.links.isNotEmpty)
                    Icon(
                      Icons.link,
                      color:
                          ThemeHelper.isDarkMode(context) ? kLightGray : kGray,
                    ),
                ],
              ),
              const Gap(),
              if (cell.title.isEmpty)
                const VoidTextValue()
              else
                Text(
                  cell.title,
                  style: textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              const Gap(),
              if (cell.description.isEmpty)
                const VoidTextValue()
              else
                LimitedBox(
                  maxHeight: 150,
                  child: Text(
                    cell.description,
                    style: textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: null,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

class VoidTextValue extends StatelessWidget {
  final TextStyle? style;

  const VoidTextValue({Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeHelper.getTextTheme(context);

    final intl = S.of(context);

    return Text(
      intl.voidValue,
      style: style?.copyWith(
            fontWeight: FontWeight.bold,
            color: ThemeHelper.isDarkMode(context) ? kLightGray : kGray,
          ) ??
          textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.bold,
            color: ThemeHelper.isDarkMode(context) ? kLightGray : kGray,
          ),
    );
  }
}
