import 'package:flutter/material.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/domain/table/cells/table_cell.dart' as c;
import 'package:producti/domain/table/table.dart' as t;
import 'package:producti/domain/table/table_link.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti/presentation/table/pages/tables_page.dart';
import 'package:producti/presentation/table/widgets/anonymous/create_group_body.dart';
import 'package:producti/presentation/table/widgets/anonymous/create_table_body.dart';
import 'package:producti/presentation/table/widgets/create_popup_tile.dart';
import 'package:producti/presentation/table/widgets/table_cell_tile.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnonymousTablesPage extends StatelessWidget {
  final TableLink? path;
  final int tableIndex;
  final t.Table table;

  const AnonymousTablesPage({
    Key? key,
    this.path,
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
        if (path != null && !path!.isEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => TablesPage(
                tableIndex: tableIndex,
                path: path!.popPath(),
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
                                onTap: () {
                                  navigator.pop();
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
                  icon: Icon(Icons.menu),
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

  void _moveToPage(BuildContext context, int tableIndex) {
    final navigator = Navigator.of(context);

    navigator.popUntil((route) => route.settings.name == AppRoutes.tables);

    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => TablesPage(
          tableIndex: tableIndex,
        ),
        settings: RouteSettings(
          name: AppRoutes.tables,
        ),
      ),
    );
  }

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

                            navigator.popUntil((route) =>
                                route.settings.name == AppRoutes.tables);

                            navigator.pushReplacementNamed(AppRoutes.auth);
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
                          if (index == tableIndex)
                            return Navigator.of(context).pop();

                          _moveToPage(context, index);
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
                    return AppBottomSheet(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
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
            AppDivider(),
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

    final textTheme = ThemeHelper.getTextTheme(context);

    final intl = S.of(context);

    return SizedBox.fromSize(
      size: query.size,
      child: Stack(
        children: [
          Positioned(
            top: 12,
            left: 12,
            child: Builder(
              builder: (context) {
                String? title;

                if (path != null && !path!.isEmpty) {
                  title = '${table.title} > ${path!.getParticle(table).title}';
                }

                title ??= table.title;

                return Text(
                  title,
                  style: textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          Builder(
            builder: (context) {
              if (path != null && !path!.isEmpty) {
                final group = path!.getParticle(table) as c.GroupTableCell;

                if (group.children.isEmpty)
                  return Center(
                    child: EmptyWidget(
                      description: intl.nothingToSee,
                    ),
                  );

                return _TableCellsList(
                  cells: group.children,
                  path: path,
                  tableIndex: tableIndex,
                );
              }

              if (table.cells.isEmpty)
                return Center(
                  child: EmptyWidget(
                    description: intl.nothingToSee,
                  ),
                );

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
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ).copyWith(
        top: 40,
      ),
      itemCount: cells.length,
      itemBuilder: (context, index) {
        final cell = cells[index];

        final navigator = Navigator.of(context);

        return TableCellTile(
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
    );
  }
}
