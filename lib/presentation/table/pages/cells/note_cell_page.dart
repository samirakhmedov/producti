import 'package:flutter/material.dart';
import 'package:producti/application/tables/pages/note_validation/note_validation_cubit.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti_ui/producti_ui.dart';

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
                        hintText: 'WOW',
                        autofocus: true,
                        initialValue: noteValidationCubit.state.title,
                        onChange: (value) => noteValidationCubit.mutate(
                          title: value,
                        ),
                      ),
                    ),
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
