import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/application/tables/pages/note_validation/note_validation_cubit.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:producti/presentation/core/errors/error_code_ext.dart';

class NoteCellPage extends StatelessWidget {
  final String title;

  final NoteTableCell? cell;

  const NoteCellPage({
    Key? key,
    required this.title,
    this.cell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteValidationCubit = NoteValidationCubit(cell);

    final theme = ThemeHelper.getTheme(context);

    final textTheme = theme.textTheme;

    final query = MediaQuery.of(context);

    final size = query.size;

    final intl = S.of(context);

    return WillPopScope(
      onWillPop: () async {
        if (noteValidationCubit.state.error != null) {
          noteValidationCubit.mutate(
            showErrors: true,
          );
        } else {
          Navigator.of(context).pop<NoteTableCell>(
            noteValidationCubit.state.toNoteCell(),
          );
        }

        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: 12,
              top: query.padding.top + 12,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (noteValidationCubit.state.error != null) {
                        return noteValidationCubit.mutate(
                          showErrors: true,
                        );
                      }

                      Navigator.of(context).pop<NoteTableCell>(
                        noteValidationCubit.state.toNoteCell(),
                      );
                    },
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  const Gap(size: 15),
                  Text(
                    title,
                    style: textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 43,
              top: query.padding.top + 45,
              child: SizedBox(
                width: size.width - 86,
                height: size.height - 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 35,
                      child: InlineTextField(
                        textStyle: textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: textTheme.headline3!.copyWith(
                          color: ThemeHelper.isDarkMode(context)
                              ? kLightGray
                              : kGray,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: intl.typeTitle,
                        autofocus: true,
                        initialValue: noteValidationCubit.state.title,
                        onChange: (value) => noteValidationCubit.mutate(
                          title: value,
                        ),
                      ),
                    ),
                    const Gap(size: 7),
                    SizedBox(
                      height: 18,
                      child: InlineTextField(
                        textStyle: textTheme.caption!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: textTheme.caption!.copyWith(
                          color: ThemeHelper.isDarkMode(context)
                              ? kLightGray
                              : kGray,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: intl.typeDescription,
                        autofocus: true,
                        initialValue: noteValidationCubit.state.title,
                        onChange: (value) => noteValidationCubit.mutate(
                          description: value,
                        ),
                      ),
                    ),
                    BlocBuilder<NoteValidationCubit, NoteValidationState>(
                      builder: (context, state) {
                        if (state.error == ErrorCode.voidValue) {
                          return FieldErrorIndicator(
                            message: state.error!.translate(
                              context,
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                    const Gap(size: 7),
                    BlocBuilder<NoteValidationCubit, NoteValidationState>(
                      bloc: noteValidationCubit,
                      builder: (context, state) {
                        final int count = state.links.length + 1;

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: count,
                          itemBuilder: (context, index) {
                            final link = state.links[index];

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 18,
                                  child: InlineTextField(
                                    textStyle: textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintStyle: textTheme.caption!.copyWith(
                                      color: ThemeHelper.isDarkMode(context)
                                          ? kLightGray
                                          : kGray,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText: intl.typeDescription,
                                    autofocus: true,
                                    initialValue:
                                        noteValidationCubit.state.title,
                                    onChange: (value) =>
                                        noteValidationCubit.mutate(
                                      description: value,
                                    ),
                                  ),
                                ),
                                link.validatedValue.fold(
                                  (failure) => FieldErrorIndicator(
                                      message: failure.messageCode
                                          .translate(context)),
                                  (_) => const SizedBox(),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
