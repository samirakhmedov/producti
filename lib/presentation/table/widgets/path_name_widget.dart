import 'package:flutter/material.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/application/tables/pages/group_create/group_create_cubit.dart';
import 'package:producti/application/tables/pages/table_create/table_create_cubit.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/table_link.dart';
import 'package:producti/domain/table/table.dart' as t;
import 'package:producti_ui/producti_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/presentation/core/errors/error_code_ext.dart';

class PathNameWidget extends StatefulWidget {
  final TableLink path;
  final t.Table table;
  final int tableIndex;

  const PathNameWidget({
    Key? key,
    required this.path,
    required this.table,
    required this.tableIndex,
  }) : super(key: key);

  @override
  State<PathNameWidget> createState() => _PathNameWidgetState();
}

class _PathNameWidgetState extends State<PathNameWidget> {
  bool _editTableName = false;
  bool _editGroupName = false;

  @override
  Widget build(BuildContext context) {
    String title = widget.table.title;
    String? subTitle;

    final textTheme = ThemeHelper.getTextTheme(context);

    if (!widget.path.isEmpty) {
      subTitle = widget.path.getParticle(widget.table).title;
    }

    if (_editTableName) {
      return _TableNameEdit(
        title: title,
        tableIndex: widget.tableIndex,
        onComplete: () {
          setState(() {
            _editTableName = false;
          });
        },
      );
    }

    if (_editGroupName) {
      return _GroupNameEdit(
        table: widget.table,
        path: widget.path,
        tableIndex: widget.tableIndex,
        onComplete: () {
          setState(() {
            _editGroupName = false;
          });
        },
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: GestureDetector(
            onDoubleTap: () {
              setState(() {
                _editTableName = true;
              });
            },
            child: Center(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        if (!widget.path.isEmpty) ...[
          Text(
            " > ",
            style: textTheme.headline3!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (widget.path.path.length >= 2)
            Text(
              "... > ",
              style: textTheme.headline3!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
        if (subTitle != null)
          Flexible(
            child: GestureDetector(
              onDoubleTap: () {
                setState(() {
                  _editGroupName = true;
                });
              },
              child: Center(
                child: Text(
                  subTitle,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _GroupNameEdit extends StatelessWidget {
  final t.Table table;
  final TableLink path;
  final int tableIndex;

  final void Function()? onComplete;

  const _GroupNameEdit({
    Key? key,
    required this.table,
    required this.path,
    this.onComplete,
    required this.tableIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final textTheme = ThemeHelper.getTextTheme(context);

    final tableBloc = context.read<AnonymousTableBloc>();

    final cubit = GroupCreateCubit(
      path
          .getParticles(
            table,
          )
          .whereType<GroupTableCell>()
          .toList(),
    );

    final focus = FocusNode();

    return SizedBox(
      width: size.width * .86,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 26,
            child: InlineTextField(
              focusNode: focus,
              autofocus: true,
              onChange: (value) {
                cubit.mutate(groupName: value);

                cubit.mutate(showErrors: cubit.state.error != null);
              },
              onSubmit: (value) {
                cubit.mutate(groupName: value);

                if (cubit.state.error != null) {
                  cubit.mutate(showErrors: true);

                  return focus.requestFocus();
                }

                tableBloc.add(
                  AnonymousTableRenameCell(
                    path,
                    cubit.state.groupName,
                    tableIndex,
                  ),
                );

                cubit.close();

                onComplete?.call();
              },
              initialValue: path.getParticle(table).title,
              textStyle: textTheme.headline3!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              suffixWidget: InkWell(
                onTap: () {
                  if (cubit.state.error == null &&
                      cubit.state.groupName.isNotEmpty) {
                    tableBloc.add(
                      AnonymousTableRenameCell(
                        path,
                        cubit.state.groupName,
                        tableIndex,
                      ),
                    );
                  }

                  cubit.close();

                  onComplete?.call();
                },
                child: const Icon(
                  Icons.check,
                ),
              ),
            ),
          ),
          BlocBuilder<GroupCreateCubit, GroupCreateState>(
            bloc: cubit,
            builder: (context, state) {
              if (state.showErrors && state.error != null) {
                return FieldErrorIndicator(
                  message: state.error!.translate(context),
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class _TableNameEdit extends StatelessWidget {
  final String title;
  final int tableIndex;

  final void Function()? onComplete;

  const _TableNameEdit({
    Key? key,
    required this.title,
    required this.tableIndex,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final textTheme = ThemeHelper.getTextTheme(context);

    final tableBloc = context.read<AnonymousTableBloc>();

    final tableState = tableBloc.state as AnonymousTableLoaded;

    final cubit = TableCreateCubit(tableState.tables);

    final focus = FocusNode();

    return SizedBox(
      width: size.width * .86,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 26,
            child: InlineTextField(
              focusNode: focus,
              autofocus: true,
              onChange: (value) {
                cubit.mutate(tableName: value);

                cubit.mutate(showErrors: cubit.state.error != null);
              },
              onSubmit: (value) {
                cubit.mutate(tableName: value);

                if (cubit.state.error != null) {
                  cubit.mutate(showErrors: true);

                  return focus.requestFocus();
                }

                tableBloc.add(
                  AnonymousTableRenameTable(
                    tableIndex,
                    cubit.state.tableName,
                  ),
                );

                onComplete?.call();
              },
              initialValue: title,
              textStyle: textTheme.headline3!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              suffixWidget: GestureDetector(
                onTap: () {
                  if (cubit.state.error == null &&
                      cubit.state.tableName.isNotEmpty) {
                    tableBloc.add(
                      AnonymousTableRenameTable(
                        tableIndex,
                        cubit.state.tableName,
                      ),
                    );
                  }

                  onComplete?.call();
                },
                child: const Icon(
                  Icons.check,
                ),
              ),
            ),
          ),
          BlocBuilder<TableCreateCubit, TableCreateState>(
            bloc: cubit,
            builder: (context, state) {
              if (state.showErrors && state.error != null) {
                return FieldErrorIndicator(
                  message: state.error!.translate(context),
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
