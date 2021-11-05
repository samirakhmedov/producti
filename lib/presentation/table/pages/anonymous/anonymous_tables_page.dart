import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
import 'package:producti/application/notifications/notifications_bloc.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/application/tables/pages/group_create/group_create_cubit.dart';
import 'package:producti/application/tables/pages/note_validation/note_validation_cubit.dart';
import 'package:producti/application/tables/pages/notification_validation/notification_validation_cubit.dart';
import 'package:producti/domain/table/cells/table_cell.dart' as c;
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/table.dart' as t;
import 'package:producti/domain/table/table_link.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/core/constants/constants.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti/presentation/table/core/table_helper.dart';
import 'package:producti/presentation/table/pages/cells/note/note_cell_create_page.dart';
import 'package:producti/presentation/table/pages/cells/note/note_cell_view_page.dart';
import 'package:producti/presentation/table/pages/cells/notifications/notification_cell_create_page.dart';
import 'package:producti/presentation/table/pages/cells/notifications/notification_cell_view_page.dart';
import 'package:producti/presentation/table/pages/tables_page.dart';
import 'package:producti/presentation/table/widgets/anonymous/create_group_body.dart';
import 'package:producti/presentation/table/widgets/anonymous/create_table_body.dart';
import 'package:producti/presentation/table/widgets/anonymous/not_signed_in_drawer_header.dart';
import 'package:producti/presentation/table/widgets/create_popup_tile.dart';
import 'package:producti/presentation/table/widgets/path_name_widget.dart';
import 'package:producti/presentation/table/widgets/table_cell_tile.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:producti/domain/notifications/notification.dart' as t;
import 'package:flutter_bloc/flutter_bloc.dart';

class AnonymousTablesPage extends StatelessWidget {
  final TableLink path;
  final int tableIndex;
  final t.Table table;

  const AnonymousTablesPage({
    Key? key,
    required this.path,
    required this.table,
    required this.tableIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    final intl = S.of(context);

    final bloc = context.read<AnonymousTableBloc>();

    return WillPopScope(
      onWillPop: () async {
        if (!path.isEmpty) {
          final newPath = path.popPath();

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => TablesPage(
                tableIndex: tableIndex,
                path: newPath.isEmpty ? null : newPath,
              ),
            ),
          );

          return false;
        }

        return true;
      },
      child: BlocListener<LocalNotificationsBloc, LocalNotificationsState>(
        listener: (context, state) {
          if (state.pathToNotification != null && state.tableIndex != null) {
            final cell = state.pathToNotification!.getParticle(table)
                as c.NotificationTableCell;

            final navigator = Navigator.of(context);

            navigator.pushReplacement(
              MaterialPageRoute(
                builder: (context) => TablesPage(
                  tableIndex: state.tableIndex!,
                  path: state.pathToNotification!.popPath(),
                ),
              ),
            );

            navigator.push(
              MaterialPageRoute(
                builder: (context) => NotificationCellViewPage(
                  cell: cell,
                  pathToNote: state.pathToNotification!,
                  tableIndex: state.tableIndex!,
                ),
              ),
            );
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          endDrawer: _TablesDrawer(
            tableIndex: tableIndex,
          ),
          body: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                _TablesBody(
                  path: path,
                  table: table,
                  tableIndex: tableIndex,
                ),
                Positioned(
                  left: 15,
                  bottom: 15,
                  child: FloatingActionButton(
                    onPressed: () {
                      final navigator = Navigator.of(context);

                      _scaffoldKey.currentState!.showBottomSheet(
                        (_context) => AppBottomSheet(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                            ).copyWith(top: 46),
                            child: Column(
                              children: [
                                CreatePopupTile(
                                  icon: Icons.menu,
                                  title: intl.group,
                                  onTap: () async {
                                    navigator.pop();

                                    final tableBloc =
                                        context.read<AnonymousTableBloc>();

                                    final tableState =
                                        tableBloc.state as AnonymousTableLoaded;

                                    final table = tableState.tables[tableIndex];

                                    final cells = path
                                        .getParticles(table)
                                        .whereType<c.GroupTableCell>()
                                        .toList();

                                    final cubit = GroupCreateCubit(cells);

                                    final controller = _scaffoldKey
                                        .currentState!
                                        .showBottomSheet(
                                      (context) {
                                        return BlocProvider<
                                            GroupCreateCubit>.value(
                                          value: cubit,
                                          child: AppBottomSheet(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 40,
                                                vertical: 42,
                                              ),
                                              child: CreateGroupBody(
                                                tableIndex: tableIndex,
                                                path: path,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );

                                    await controller.closed;

                                    if (cubit.state.error == null) {
                                      tableBloc.add(
                                        AnonymousTableCellCreate(
                                          GroupTableCell(
                                            title: cubit.state.groupName,
                                          ),
                                          path,
                                          tableIndex,
                                        ),
                                      );
                                    }

                                    cubit.close();
                                  },
                                ),
                                const Gap(size: 12),
                                CreatePopupTile(
                                  icon: Icons.edit,
                                  title: intl.note,
                                  onTap: () async {
                                    navigator.pop();

                                    final noteValidationCubit =
                                        NoteValidationCubit(null);

                                    final result =
                                        await navigator.push<c.NoteTableCell>(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: noteValidationCubit,
                                          child: const NoteCellCreatePage(),
                                        ),
                                      ),
                                    );

                                    if (result != null) {
                                      bloc.add(
                                        AnonymousTableCellCreate(
                                          result,
                                          path,
                                          tableIndex,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const Gap(size: 12),
                                CreatePopupTile(
                                  icon: Icons.access_time,
                                  title: intl.notification,
                                  onTap: () async {
                                    navigator.pop();

                                    final notificationValidationCubit =
                                        NotificationValidationCubit(null);

                                    final result = await navigator
                                        .push<c.NotificationTableCell>(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: notificationValidationCubit,
                                          child:
                                              const NotificationCellCreatePage(),
                                        ),
                                      ),
                                    );

                                    if (result != null) {
                                      bloc.add(
                                        AnonymousTableCellCreate(
                                          result,
                                          path,
                                          tableIndex,
                                        ),
                                      );

                                      final cellPath = path.addPath(
                                          path.getParticles(table).length);

                                      context
                                          .read<LocalNotificationsBloc>()
                                          .add(
                                            LocalNotificationsAddNotification(
                                              t.Notification(
                                                time: result.time,
                                                body: result.description.isEmpty
                                                    ? intl.voidValue
                                                    : result.description,
                                                id: cellPath.getId(tableIndex),
                                                title: result.title.isEmpty
                                                    ? intl.voidValue
                                                    : result.title,
                                                pathToNotification: cellPath,
                                              ),
                                              tableIndex,
                                            ),
                                          );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    backgroundColor: theme.primaryColor,
                    child: Icon(
                      Icons.add,
                      color: theme.backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TablesDrawer extends StatelessWidget {
  final int tableIndex;

  const _TablesDrawer({Key? key, required this.tableIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intl = S.of(context);

    final theme = ThemeHelper.getTheme(context);

    final textTheme = theme.textTheme;

    final query = MediaQuery.of(context);

    return Drawer(
      elevation: 0.0,
      child: Container(
        color: theme.backgroundColor,
        child: Column(
          children: [
            if (kFinishedAuth)
              const NotSignedInDrawerHeader()
            else
              SizedBox(
                height: query.padding.top + 15,
              ),
            const Gap(),
            Expanded(
              child: BlocBuilder<AnonymousTableBloc, AnonymousTableState>(
                builder: (context, state) {
                  if (state is AnonymousTableLoaded) {
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                        onLongPress: () async {
                          if (state.tables.length == 1) {
                            return showDialog(
                              context: context,
                              builder: (context) => AppDialog(
                                child: Column(
                                  children: [
                                    const Expanded(
                                      child: SizedBox(),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        intl.cannotDeleteSingle,
                                        style: textTheme.bodyText1!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: theme.primaryColor,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: null,
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          intl.ok,
                                          style: textTheme.bodyText1!.copyWith(
                                            color: theme.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          bool? agreement;

                          await showDialog(
                            context: context,
                            builder: (context) => AppDialog(
                              child: AppDialogQuestionBody(
                                onSelect: (answer) => agreement = answer,
                                options: [
                                  intl.yes,
                                  intl.no,
                                ],
                                title: intl.youSureToDelete,
                              ),
                            ),
                          );

                          if (agreement == null) return;
                          if (!agreement!) return;

                          if (tableIndex == index) {
                            TableHelper.moveToTable(
                              context,
                              tableIndex + (tableIndex >= 1 ? -1 : 1),
                            );
                          }

                          context.read<AnonymousTableBloc>().add(
                                AnonymousTableDeleteTable(
                                  tableIndex,
                                ),
                              );
                        },
                        onTap: () {
                          Navigator.of(context).pop();

                          if (index != tableIndex) {
                            TableHelper.moveToTable(context, index);
                          }
                        },
                        child: DrawerListTile(
                          text: state.tables[index].title,
                          icon: Icons.grid_view_outlined,
                          selected: index == tableIndex,
                        ),
                      ),
                      separatorBuilder: (context, index) => const AppDivider(),
                      itemCount: state.tables.length,
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
            DrawerListTile(
              onTap: () {
                final navigator = Navigator.of(context);

                navigator.pop();

                showBottomSheet(
                  context: context,
                  builder: (context) {
                    return const AppBottomSheet(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 42,
                        ),
                        child: CreateTableBody(),
                      ),
                    );
                  },
                );
              },
              text: intl.addOne,
              icon: Icons.add,
            ),
            const AppDivider(),
            DrawerListTile(
              text: intl.settings,
              icon: Icons.settings,
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.settings);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TablesBody extends StatelessWidget {
  final TableLink path;
  final t.Table table;
  final int tableIndex;

  const _TablesBody({
    Key? key,
    required this.path,
    required this.table,
    required this.tableIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    final intl = S.of(context);

    return SizedBox.fromSize(
      size: query.size,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: PathNameWidget(
                table: table,
                tableIndex: tableIndex,
                path: path,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Builder(
              builder: (context) {
                final cells = path.getParticles(table);

                if (cells.isEmpty) {
                  return Center(
                    child: EmptyWidget(
                      description: intl.nothingToSee,
                    ),
                  );
                }

                return _TableCellsList(
                  cells: cells,
                  path: path,
                  tableIndex: tableIndex,
                  table: table,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TableCellsList extends StatelessWidget {
  final List<c.TableCell> cells;
  final TableLink path;
  final t.Table table;
  final int tableIndex;

  const _TableCellsList({
    Key? key,
    required this.cells,
    required this.path,
    required this.tableIndex,
    required this.table,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intl = S.of(context);
    final bloc = context.read<AnonymousTableBloc>();

    final theme = ThemeHelper.getTheme(context);

    return ReorderableListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final cell = cells[index];

        final navigator = Navigator.of(context);

        return Slidable(
          key: Key(index.toString()),
          actionPane: const SlidableDrawerActionPane(),
          actions: [
            IconSlideAction(
              caption: intl.delete,
              color: kRed,
              icon: Icons.delete,
              foregroundColor: theme.backgroundColor,
              onTap: () async {
                if (cell is c.GroupTableCell && cell.children.isNotEmpty) {
                  bool? agreement;

                  await showDialog(
                    context: context,
                    builder: (context) => AppDialog(
                      child: AppDialogQuestionBody(
                        onSelect: (answer) => agreement = answer,
                        options: [
                          intl.yes,
                          intl.no,
                        ],
                        title: intl.youSureToDelete,
                      ),
                    ),
                  );

                  if (agreement == null) return;
                  if (!agreement!) return;
                }

                bloc.add(
                  AnonymousTableDeleteCell(
                    tableIndex,
                    path.addPath(index),
                  ),
                );

                final notificationsBloc =
                    context.read<LocalNotificationsBloc>();

                notificationsBloc.add(
                  LocalNotificationsCellDelete(
                    table,
                    path.addPath(index),
                    tableIndex,
                  ),
                );
              },
            ),
            if (cell is c.GroupTableCell)
              IconSlideAction(
                caption: intl.rename,
                color: Colors.blue,
                icon: Icons.edit,
                foregroundColor: theme.backgroundColor,
                onTap: () async {
                  final tableBloc = context.read<AnonymousTableBloc>();

                  final tableState = tableBloc.state as AnonymousTableLoaded;

                  final table = tableState.tables[tableIndex];

                  final cells = path
                      .getParticles(table)
                      .whereType<c.GroupTableCell>()
                      .toList();

                  final cubit =
                      GroupCreateCubit(cells, initialName: cell.title);

                  final controller = showBottomSheet(
                    context: context,
                    builder: (context) {
                      return BlocProvider<GroupCreateCubit>.value(
                        value: cubit,
                        child: AppBottomSheet(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 42,
                            ),
                            child: CreateGroupBody(
                              tableIndex: tableIndex,
                              path: path,
                            ),
                          ),
                        ),
                      );
                    },
                  );

                  await controller.closed;

                  if (cubit.state.error == null) {
                    tableBloc.add(
                      AnonymousTableRenameCell(
                        path.addPath(index),
                        cubit.state.groupName,
                        tableIndex,
                      ),
                    );
                  }

                  cubit.close();
                },
              )
            else
              IconSlideAction(
                caption: intl.edit,
                color: Colors.blue,
                icon: Icons.edit,
                foregroundColor: theme.backgroundColor,
                onTap: () async {
                  c.TableCell? newCell;

                  if (cell is c.NoteTableCell) {
                    final noteValidationCubit = NoteValidationCubit(cell);

                    final result =
                        await Navigator.of(context).push<c.NoteTableCell>(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: noteValidationCubit,
                          child: const NoteCellCreatePage(),
                        ),
                      ),
                    );

                    newCell = result;
                  }

                  if (cell is c.NotificationTableCell) {
                    final noteValidationCubit =
                        NotificationValidationCubit(cell);

                    final result = await Navigator.of(context)
                        .push<c.NotificationTableCell>(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: noteValidationCubit,
                          child: const NotificationCellCreatePage(),
                        ),
                      ),
                    );

                    newCell = result;

                    if (result != null &&
                        !result.time.isAtSameMomentAs(cell.time)) {
                      final notificationsBloc =
                          context.read<LocalNotificationsBloc>();

                      notificationsBloc.add(
                        LocalNotificationsCellDelete(
                          table,
                          path.addPath(index),
                          tableIndex,
                        ),
                      );

                      notificationsBloc.add(
                        LocalNotificationsAddNotification(
                          t.Notification(
                            body: result.description.isEmpty
                                ? intl.voidValue
                                : result.description,
                            id: path.addPath(index).getId(tableIndex),
                            title: result.title.isEmpty
                                ? intl.voidValue
                                : result.title,
                            pathToNotification: path.addPath(index),
                            time: cell.time,
                          ),
                          tableIndex,
                        ),
                      );
                    }
                  }

                  if (newCell != null) {
                    context.read<AnonymousTableBloc>().add(
                          AnonymousTableChangeCell(
                            tableIndex: tableIndex,
                            pathToNote: path.addPath(index),
                            newCell: newCell,
                          ),
                        );
                  }
                },
              ),
          ],
          child: TableCellTile(
            cell: cell,
            onTap: () {
              if (cell is c.GroupTableCell) {
                navigator.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => TablesPage(
                      tableIndex: tableIndex,
                      path: path.addPath(index),
                    ),
                  ),
                );
              }
              if (cell is c.NoteTableCell) {
                navigator.push(
                  MaterialPageRoute(
                    builder: (context) => NoteCellViewPage(
                      cell: cell,
                      pathToNote: path.addPath(index),
                      tableIndex: tableIndex,
                    ),
                  ),
                );
              }
              if (cell is c.NotificationTableCell) {
                navigator.push(
                  MaterialPageRoute(
                    builder: (context) => NotificationCellViewPage(
                      cell: cell,
                      pathToNote: path.addPath(index),
                      tableIndex: tableIndex,
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
      itemCount: cells.length,
      onReorder: (oldIndex, newIndex) => context.read<AnonymousTableBloc>().add(
            AnonymousTableReorderCells(
              oldIndex,
              newIndex,
              tableIndex,
              path,
            ),
          ),
    );
  }
}
