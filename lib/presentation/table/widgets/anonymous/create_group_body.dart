import 'package:flutter/material.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/application/tables/pages/group_create/group_create_cubit.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/table_link.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/table/pages/tables_page.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:producti/presentation/core/errors/error_code_ext.dart';

class CreateGroupBody extends StatelessWidget {
  final TableLink? path;
  final int tableIndex;

  void _moveToPage(BuildContext context, TableLink path) {
    final navigator = Navigator.of(context);

    navigator.push(
      MaterialPageRoute(
        builder: (context) => TablesPage(
          tableIndex: tableIndex,
          path: path,
        ),
      ),
    );
  }

  const CreateGroupBody({Key? key, this.path, required this.tableIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GroupTableCell>? cells;

    final tableBloc = context.read<AnonymousTableBloc>();

    final tableState = tableBloc.state as AnonymousTableLoaded;

    final table = tableState.tables[tableIndex];

    if (path != null) {
      final groupCell = path!.getParticle(table) as GroupTableCell;

      cells = groupCell.children.whereType<GroupTableCell>().toList();
    }

    cells ??= table.cells.whereType<GroupTableCell>().toList();

    final cubit = GroupCreateCubit(cells);
    final intl = S.of(context);

    return Column(
      children: [
        TextInputWidget(
          onChange: (value) => cubit.mutate(groupName: value),
          hintText: intl.groupName,
          prefixIcon: Icons.grid_view_outlined,
        ),
        const Gap(
          size: 20,
        ),
        BlocBuilder<GroupCreateCubit, GroupCreateState>(
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

            final cellsLength = cells!.length + 1;

            tableBloc.add(
              AnonymousTableGroupCreate(
                name: createState.groupName,
                tableIndex: tableIndex,
                path: path,
              ),
            );

            await tableBloc.stream.first;

            final newPath =
                path?.addPath(cellsLength) ?? TableLink([cellsLength]);

            _moveToPage(context, newPath);
          },
          text: intl.create,
        ),
      ],
    );
  }
}
