import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/application/tables/logic/user/table_bloc.dart';
import 'package:producti/domain/table/table_link.dart';
import 'package:producti/injection.dart';
import 'package:producti/presentation/table/pages/anonymous/anonymous_tables_page.dart';
import 'package:producti/presentation/table/pages/user/user_tables_page.dart';
import 'package:producti_ui/producti_ui.dart';

class TablesPage extends StatelessWidget {
  final int tableIndex;
  final TableLink? path;

  const TablesPage({
    Key? key,
    this.tableIndex = 0,
    this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => state is AuthLoggedIn
          ? BlocProvider<TableBloc>(
              create: (context) => sl.get<TableBloc>(),
              child: UserTablesPage(),
            )
          : BlocProvider<AnonymousTableBloc>(
              create: (context) => sl.get<AnonymousTableBloc>(),
              child: BlocBuilder<AnonymousTableBloc, AnonymousTableState>(
                builder: (context, state) {
                  if (state is AnonymousTableLoaded)
                    return AnonymousTablesPage(
                      table: state.tables[tableIndex],
                      path: path,
                    );

                  return const PlaceholderPage();
                },
              ),
            ),
    );
  }
}
