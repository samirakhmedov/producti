import 'package:flutter/material.dart';
import 'package:producti/application/tables/pages/group_create/group_create_cubit.dart';
import 'package:producti/domain/table/table_link.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:producti/presentation/core/errors/error_code_ext.dart';

class CreateGroupBody extends StatelessWidget {
  final TableLink path;
  final int tableIndex;

  const CreateGroupBody({
    Key? key,
    required this.path,
    required this.tableIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intl = S.of(context);

    return Column(
      children: [
        TextInputWidget(
          onChange: (value) =>
              context.read<GroupCreateCubit>().mutate(groupName: value),
          hintText: intl.groupName,
          prefixIcon: Icons.grid_view_outlined,
          controller: TextEditingController(
            text: context.read<GroupCreateCubit>().state.groupName,
          ),
        ),
        const Gap(
          size: 20,
        ),
        BlocBuilder<GroupCreateCubit, GroupCreateState>(
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
            final cubit = context.read<GroupCreateCubit>();

            final createState = cubit.state;

            if (createState.error != null && !createState.showErrors) {
              return cubit.mutate(
                showErrors: true,
              );
            }

            cubit.close();

            Navigator.of(context).pop<String>();
          },
          text: intl.create,
        ),
      ],
    );
  }
}
