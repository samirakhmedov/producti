import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/application/tables/logic/user/table_bloc.dart';
import 'package:producti/injection.dart';
import 'package:producti/presentation/table/pages/anonymous/anonymous_tables_page.dart';
import 'package:producti/presentation/table/pages/user/user_tables_page.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({Key? key}) : super(key: key);

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
              child: AnonymousTablesPage(),
            ),
    );
  }
}
