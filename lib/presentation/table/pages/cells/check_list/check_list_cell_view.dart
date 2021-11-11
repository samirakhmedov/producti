import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/application/tables/pages/cubit/check_list_validation_cell_cubit.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/table_link.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/table/pages/cells/check_list/check_list_cell_create_page.dart';
import 'package:producti_ui/producti_ui.dart';

class CheckListCellView extends StatefulWidget {
  final CheckListTableCell cell;
  final TableLink pathToNote;
  final int tableIndex;

  const CheckListCellView({
    Key? key,
    required this.cell,
    required this.pathToNote,
    required this.tableIndex,
  }) : super(key: key);

  @override
  _CheckListCellViewState createState() => _CheckListCellViewState();
}

class _CheckListCellViewState extends State<CheckListCellView> {
  late CheckListTableCell _cell;

  @override
  void initState() {
    _cell = widget.cell;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final intl = S.of(context);

    final theme = ThemeHelper.getTheme(context);

    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          intl.checkListDetails,
          style: textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final noteValidationCubit = CheckListValidationCubit(_cell);

              final result =
                  await Navigator.of(context).push<CheckListTableCell>(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: noteValidationCubit,
                    child: const CheckListCellCreatePage(),
                  ),
                ),
              );

              if (result != null) {
                context.read<AnonymousTableBloc>().add(
                      AnonymousTableChangeCell(
                        tableIndex: widget.tableIndex,
                        pathToNote: widget.pathToNote,
                        newCell: result,
                      ),
                    );

                setState(() {
                  _cell = result;
                });
              }
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 45,
        ),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 7),
              sliver: SliverToBoxAdapter(
                child: SelectableText(
                  _cell.title,
                  style: textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (_cell.checkList.isNotEmpty) ...[
              const SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.list_rounded),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final check = _cell.checkList[index];

                    return Row(
                      children: [
                        Text(
                          check.title,
                          style: textTheme.caption!.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: check.value
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        AppCheckBox(
                          value: check.value,
                          onTap: (value) {
                            final newCheck = check.copyWith(
                              value: value,
                            );

                            final newList = List.of(_cell.checkList);

                            newList[index] = newCheck;

                            setState(() {
                              _cell = _cell.copyWith(
                                checkList: newList,
                              );
                            });

                            context.read<AnonymousTableBloc>().add(
                                  AnonymousTableChangeCell(
                                    tableIndex: widget.tableIndex,
                                    pathToNote: widget.pathToNote,
                                    newCell: _cell,
                                  ),
                                );
                          },
                        ),
                      ],
                    );
                  },
                  childCount: _cell.checkList.length,
                ),
              ),
              const SliverToBoxAdapter(
                child: Gap(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
