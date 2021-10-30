import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/application/tables/pages/note_validation/note_validation_cubit.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/values/link.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:producti/presentation/core/errors/error_code_ext.dart';

class NoteCellCreatePage extends StatelessWidget {
  final NoteTableCell? cell;

  const NoteCellCreatePage({
    Key? key,
    this.cell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteValidationCubit = context.read<NoteValidationCubit>();

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
        appBar: AppBar(
          title: Text(
            intl.noteCreation,
            style: textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: InkWell(
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
        ),
        body: SizedBox.fromSize(
          size: size,
          child: Padding(
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
                  ),
                ),
                SliverToBoxAdapter(
                  child: InlineTextField(
                    textStyle: textTheme.caption!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    hintStyle: textTheme.caption!.copyWith(
                      color:
                          ThemeHelper.isDarkMode(context) ? kLightGray : kGray,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: intl.typeDescription,
                    multiline: true,
                    initialValue: noteValidationCubit.state.title,
                    onChange: (value) => noteValidationCubit.mutate(
                      description: value,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 7),
                  sliver: SliverToBoxAdapter(
                    child:
                        BlocBuilder<NoteValidationCubit, NoteValidationState>(
                      builder: (context, state) {
                        if (state.showErrors &&
                            state.error != null &&
                            state.error != ErrorCode.voidLinkValue) {
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
                    child: Icon(Icons.link),
                  ),
                ),
                BlocBuilder<NoteValidationCubit, NoteValidationState>(
                  builder: (context, state) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final link = state.links[index];

                          return Dismissible(
                            key: Key(index.toString()),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              final links =
                                  List.of(noteValidationCubit.state.links);

                              links.removeAt(index);

                              noteValidationCubit.mutate(
                                links: links,
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
                                      color: theme.primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                    hintStyle: textTheme.caption!.copyWith(
                                      color: ThemeHelper.isDarkMode(context)
                                          ? kLightGray
                                          : kGray,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textInputType: TextInputType.url,
                                    hintText: index == 0
                                        ? intl.typeLink
                                        : intl.anotherOne,
                                    initialValue:
                                        state.links[index].currentValue,
                                    onChange: (value) =>
                                        noteValidationCubit.mutate(
                                      links: state.links..[index] = Link(value),
                                    ),
                                  ),
                                ),
                                if (state.showErrors) ...[
                                  link.validatedValue.fold(
                                    (failure) => FieldErrorIndicator(
                                      message: failure.messageCode
                                          .translate(context),
                                    ),
                                    (_) => const SizedBox(),
                                  ),
                                  const Gap(),
                                ],
                              ],
                            ),
                          );
                        },
                        childCount: state.links.length,
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
                          final links =
                              List.of(noteValidationCubit.state.links);

                          links.add(const Link(''));

                          noteValidationCubit.mutate(
                            links: links,
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.add),
                            const Gap(size: 7),
                            Text(
                              intl.addLink,
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
      ),
    );
  }
}
