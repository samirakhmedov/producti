import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/application/tables/pages/cubit/check_list_validation_cell_cubit.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/values/check_tile.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:producti/presentation/core/errors/error_code_ext.dart';

class CheckListCellCreatePage extends StatelessWidget {
  const CheckListCellCreatePage({
    Key? key,
  }) : super(key: key);

  Future<bool> _onPop(BuildContext context, CheckListValidationCubit checkListValidationCubit) async {
    final intl = S.of(context);

    if (checkListValidationCubit.state.error != null) {
      if (!checkListValidationCubit.state.showErrors) {
        checkListValidationCubit.mutate(
          showErrors: true,
        );
      } else {
        bool? agreement;

        await showDialog(
          context: context,
          builder: (context) => AppDialog(
            child: AppDialogQuestionBody(
              onSelect: (answer) => agreement = answer,
              options: [
                intl.yes,
                intl.no,
              ],
              title: intl.youSureToDelete,
            ),
          ),
        );

        if (agreement != null && agreement!) {
          Navigator.of(context).pop<NoteTableCell?>(null);
        }
      }
    } else {
      Navigator.of(context).pop<CheckListTableCell>(
        checkListValidationCubit.state.toCell(),
      );
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    final textTheme = theme.textTheme;

    final intl = S.of(context);

    return WillPopScope(
      onWillPop: () async => _onPop(
        context,
        context.read<CheckListValidationCubit>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            intl.checkListCreate,
            style: textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: InkWell(
            onTap: () => _onPop(
              context,
              context.read<CheckListValidationCubit>(),
            ),
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
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
                  child: SizedBox(
                    height: 35,
                    child: InlineTextField(
                      textStyle: textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      hintStyle: textTheme.headline3!.copyWith(
                        color: ThemeHelper.isDarkMode(context) ? kLightGray : kGray,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: intl.typeTitle,
                      autofocus: true,
                      initialValue: context.select<CheckListValidationCubit, String>((value) => value.state.title),
                      onChange: (value) => context.read<CheckListValidationCubit>().mutate(
                            title: value,
                          ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 7),
                sliver: SliverToBoxAdapter(
                  child: BlocBuilder<CheckListValidationCubit, CheckListValidationState>(
                    builder: (context, state) {
                      if (state.showErrors && state.error != null && state.error != ErrorCode.voidLinkValue) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(),
                            FieldErrorIndicator(
                              message: state.error!.translate(
                                context,
                              ),
                            ),
                          ],
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.list_rounded,
                  ),
                ),
              ),
              BlocBuilder<CheckListValidationCubit, CheckListValidationState>(
                buildWhen: (previous, current) => true,
                builder: (context, state) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final tile = state.tiles[index];

                        return Dismissible(
                          key: Key(index.toString()),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            final noteValidationCubit = context.read<CheckListValidationCubit>();

                            final links = List.of(noteValidationCubit.state.tiles);

                            links.removeAt(index);

                            noteValidationCubit.mutate(
                              tiles: links,
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(),
                              SizedBox(
                                height: 18,
                                child: InlineTextField(
                                  textStyle: textTheme.caption!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  hintStyle: textTheme.caption!.copyWith(
                                    color: ThemeHelper.isDarkMode(context) ? kLightGray : kGray,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textInputType: TextInputType.url,
                                  hintText: index == 0 ? intl.typeCheck : intl.anotherOne,
                                  initialValue: state.tiles[index].currentValue,
                                  onChange: (value) {
                                    final list = List.of(state.tiles);

                                    list[index] = CheckTile(value, tile.initialValue);

                                    context.read<CheckListValidationCubit>().mutate(
                                          tiles: list,
                                        );
                                  },
                                ),
                              ),
                              if (state.showErrors) ...[
                                tile.validatedValue.fold(
                                  (failure) => FieldErrorIndicator(
                                    message: failure.messageCode.translate(context),
                                  ),
                                  (_) => const SizedBox(),
                                ),
                                const Gap(),
                              ],
                            ],
                          ),
                        );
                      },
                      childCount: state.tiles.length,
                    ),
                  );
                },
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 10),
                sliver: SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        final noteValidationCubit = context.read<CheckListValidationCubit>();

                        final links = List.of(noteValidationCubit.state.tiles);

                        links.add(
                          const CheckTile(
                            '',
                            false,
                          ),
                        );

                        noteValidationCubit.mutate(
                          tiles: links,
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                          ),
                          const Gap(size: 7),
                          Text(
                            intl.addCheck,
                            style: textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Gap(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
