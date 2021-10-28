import 'package:flutter/material.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/domain/table/cells/table_cell.dart' as c;
import 'package:producti/domain/table/table.dart' as t;
import 'package:producti/domain/table/table_link.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti/presentation/table/core/table_helper.dart';
import 'package:producti/presentation/table/pages/cells/note_cell_page.dart';
import 'package:producti/presentation/table/pages/tables_page.dart';
import 'package:producti/presentation/table/widgets/anonymous/create_group_body.dart';
import 'package:producti/presentation/table/widgets/anonymous/create_table_body.dart';
import 'package:producti/presentation/table/widgets/create_popup_tile.dart';
import 'package:producti/presentation/table/widgets/path_name_widget.dart';
import 'package:producti/presentation/table/widgets/table_cell_tile.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnonymousTablesPage extends StatelessWidget {
  final TableLink? path;
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

    return WillPopScope(
      onWillPop: () async {
        if (path != null) {
          final newPath = path!.popPath();

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
                      (context) => AppBottomSheet(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                          ).copyWith(top: 46),
                          child: Column(
                            children: [
                              CreatePopupTile(
                                icon: Icons.menu,
                                title: intl.group,
                                onTap: () {
                                  navigator.pop();

                                  showBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return AppBottomSheet(
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
                                      );
                                    },
                                  );
                                },
                              ),
                              const Gap(size: 12),
                              CreatePopupTile(
                                icon: Icons.edit,
                                title: intl.note,
                                onTap: () async {
                                  navigator.pop();

                                  final result = await navigator.push(
                                    MaterialPageRoute(
                                      builder: (context) => NoteCellPage(
                                        title: intl.noteCreation,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const Gap(size: 12),
                              CreatePopupTile(
                                icon: Icons.access_time,
                                title: intl.notification,
                                onTap: () {
                                  navigator.pop();
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
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  icon: const Icon(Icons.menu),
                ),
              ),
            ],
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
    final query = MediaQuery.of(context);

    final size = query.size;

    final intl = S.of(context);

    final theme = Theme.of(context);

    return Drawer(
      elevation: 0.0,
      child: Container(
        color: theme.backgroundColor,
        child: Column(
          children: [
            Container(
              height: size.height * 0.13,
              width: double.maxFinite,
              color: theme.backgroundColor,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const UserAvatar(),
                      const Gap(),
                      Expanded(
                        child: OptionText(
                          textAlign: TextAlign.left,
                          start: intl.doNotLoggedIn + ' ',
                          end: intl.createAccount,
                          onTap: () {
                            final authBloc = context.read<AuthBloc>();

                            authBloc.add(AuthSignOut());

                            final navigator = Navigator.of(context);

                            navigator.pushNamedAndRemoveUntil(
                              AppRoutes.auth,
                              (route) => false,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}

class _TablesBody extends StatelessWidget {
  final TableLink? path;
  final t.Table table;
  final int tableIndex;

  const _TablesBody({
    Key? key,
    this.path,
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
            top: 12,
            left: 12,
            child: PathNameWidget(
              table: table,
              tableIndex: tableIndex,
              path: path,
            ),
          ),
          Builder(
            builder: (context) {
              if (path != null && !path!.isEmpty) {
                final group = path!.getParticle(table) as c.GroupTableCell;

                if (group.children.isEmpty) {
                  return Center(
                    child: EmptyWidget(
                      description: intl.nothingToSee,
                    ),
                  );
                }

                return _TableCellsList(
                  cells: group.children,
                  path: path,
                  tableIndex: tableIndex,
                );
              }

              if (table.cells.isEmpty) {
                return Center(
                  child: EmptyWidget(
                    description: intl.nothingToSee,
                  ),
                );
              }

              return _TableCellsList(
                cells: table.cells,
                path: path,
                tableIndex: tableIndex,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TableCellsList extends StatelessWidget {
  final List<c.TableCell> cells;
  final TableLink? path;
  final int tableIndex;

  const _TableCellsList({
    Key? key,
    required this.cells,
    this.path,
    required this.tableIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(
        top: 45,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final cell = cells[index];

        final navigator = Navigator.of(context);

        return TableCellTile(
          key: Key(index.toString()),
          cell: cell,
          onTap: () {
            if (cell is c.GroupTableCell) {
              navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => TablesPage(
                    tableIndex: tableIndex,
                    path: path?.addPath(index) ?? TableLink([index]),
                  ),
                ),
              );
            }
          },
        );
      },
      itemCount: cells.length,
      onReorder: (oldIndex, newIndex) => context.read<AnonymousTableBloc>().add(
            AnonymousTableReorderCells(
              oldIndex,
              newIndex,
              tableIndex,
              path: path,
            ),
          ),
    );
  }
}
