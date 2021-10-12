import 'package:flutter/material.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/domain/table/table_link.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnonymousTablesPage extends StatelessWidget {
  final TableLink? path;
  final Table table;

  const AnonymousTablesPage({
    Key? key,
    this.path,
    required this.table,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _TablesDrawer(),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                icon: Icon(Icons.menu),
              ),
            ),
            _TablesBody(
              path: path,
            ),
          ],
        ),
      ),
    );
  }
}

class _TablesBody extends StatelessWidget {
  final TableLink? path;

  const _TablesBody({Key? key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    return SizedBox.fromSize(
      size: query.size,
      child: BlocBuilder<AnonymousTableBloc, AnonymousTableState>(
        builder: (context, state) {
          return Stack(
            children: [],
          );
        },
      ),
    );
  }
}

class _TablesDrawer extends StatelessWidget {
  const _TablesDrawer({Key? key}) : super(key: key);

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

                            navigator
                                .popUntil((route) => route != AppRoutes.tables);

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
                      itemBuilder: (context, index) =>
                          index + 1 == state.tables.length
                              ? DrawerListTile(
                                  text: state.tables[index].title,
                                  icon: Icons.grid_view_outlined,
                                  selected: true,
                                )
                              : DrawerListTile(
                                  text: intl.addOne,
                                  icon: Icons.add,
                                ),
                      separatorBuilder: (context, index) => const AppDivider(),
                      itemCount: state.tables.length + 1,
                    );
                  }

                  return const SizedBox();
                },
              ),
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
