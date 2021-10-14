import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/application/tables/pages/table_create/table_create_cubit.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti/presentation/table/pages/tables_page.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:producti/presentation/core/errors/error_code_ext.dart';

class CreateTableBody extends StatelessWidget {
  const CreateTableBody({Key? key}) : super(key: key);

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
    final tableBloc = context.read<AnonymousTableBloc>();

    final tableState = tableBloc.state as AnonymousTableLoaded;

    final cubit = TableCreateCubit(tableState.tables);
    final intl = S.of(context);

    return Column(
      children: [
        TextInputWidget(
          onChange: (value) => cubit.mutate(tableName: value),
          hintText: intl.tableName,
          prefixIcon: Icons.grid_view_outlined,
        ),
        const Gap(
          size: 20,
        ),
        BlocBuilder<TableCreateCubit, TableCreateState>(
          bloc: cubit,
          builder: (context, state) {
            if (state.showErrors && state.error != null) {
              return Column(
                children: [
                  FieldErrorIndicator(
                    message: state.error!.translate(context),
                  ),
                  const Gap(
                    size: 20,
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
        LongButton(
          onTap: () async {
            final createState = cubit.state;

            if (createState.error != null && !createState.showErrors) {
              return cubit.mutate(
                showErrors: true,
              );
            }

            cubit.close();

            tableBloc.add(
              AnonymousTableCreate(
                createState.tableName,
              ),
            );

            await tableBloc.stream.first;

            _moveToPage(context, tableState.tables.length);
          },
          text: intl.create,
        ),
      ],
    );
  }
}
