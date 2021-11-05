import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:producti/application/settings/settings_cubit.dart';
import 'package:producti/application/tables/pages/notification_validation/notification_validation_cubit.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/values/link.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:producti/presentation/core/errors/error_code_ext.dart';
import 'package:producti/application/settings/settings_ext.dart';

class NotificationCellCreatePage extends StatelessWidget {
  final NoteTableCell? cell;

  const NotificationCellCreatePage({
    Key? key,
    this.cell,
  }) : super(key: key);

  Future<bool> _onPop(BuildContext context,
      NotificationValidationCubit notificationValidationCubit) async {
    final intl = S.of(context);

    if (notificationValidationCubit.state.error != null) {
      if (!notificationValidationCubit.state.showErrors) {
        notificationValidationCubit.mutate(
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
      Navigator.of(context).pop<NotificationTableCell>(
        notificationValidationCubit.state.toNoteCell(),
      );
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final notificationValidationCubit =
        context.read<NotificationValidationCubit>();

    final theme = ThemeHelper.getTheme(context);

    final textTheme = theme.textTheme;

    final intl = S.of(context);

    return WillPopScope(
      onWillPop: () async => _onPop(context, notificationValidationCubit),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            intl.noteCreation,
            style: textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: InkWell(
            onTap: () => _onPop(context, notificationValidationCubit),
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
                padding: const EdgeInsets.only(bottom: 16),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 24,
                    child: BlocBuilder<NotificationValidationCubit,
                        NotificationValidationState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            DatePicker.showDateTimePicker(
                              context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime.now().add(
                                const Duration(days: 3650),
                              ),
                              locale: context
                                  .read<SettingsCubit>()
                                  .state
                                  .language!
                                  .toLocaleType(),
                              theme: DatePickerTheme(
                                backgroundColor: theme.backgroundColor,
                                cancelStyle: textTheme.caption!.copyWith(
                                  color: kRed,
                                ),
                                doneStyle: textTheme.caption!.copyWith(
                                  color: theme.primaryColor,
                                ),
                                itemStyle: textTheme.bodyText1!.copyWith(
                                  color: theme.primaryColor,
                                ),
                              ),
                              onChanged: (date) {
                                notificationValidationCubit.mutate(
                                  dateTime: date,
                                );
                              },
                              currentTime:
                                  notificationValidationCubit.state.dateTime ??
                                      DateTime.now(),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.access_time),
                              const Gap(),
                              if (state.dateTime == null)
                                Expanded(
                                  child: Text(
                                    intl.pickDate,
                                    style: textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ThemeHelper.isDarkMode(context)
                                          ? kLightGray
                                          : kGray,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              else
                                Text(
                                  DateFormat('dd.MM.yyyy, kk:mm')
                                      .format(state.dateTime!),
                                  style: textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ThemeHelper.isDarkMode(context)
                                        ? kLightGray
                                        : kGray,
                                  ),
                                )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 7),
                sliver: SliverToBoxAdapter(
                  child: BlocBuilder<NotificationValidationCubit,
                      NotificationValidationState>(
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
                      initialValue: notificationValidationCubit.state.title,
                      onChange: (value) => notificationValidationCubit.mutate(
                        title: value,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: InlineTextField(
                  textStyle: textTheme.caption!,
                  hintStyle: textTheme.caption!.copyWith(
                    color: ThemeHelper.isDarkMode(context) ? kLightGray : kGray,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: intl.typeDescription,
                  multiline: true,
                  initialValue: notificationValidationCubit.state.description,
                  onChange: (value) => notificationValidationCubit.mutate(
                    description: value,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 7),
                sliver: SliverToBoxAdapter(
                  child: BlocBuilder<NotificationValidationCubit,
                      NotificationValidationState>(
                    builder: (context, state) {
                      if (state.showErrors &&
                          state.error != null &&
                          ![
                            ErrorCode.voidLinkValue,
                            ErrorCode.notificationInPast
                          ].contains(state.error)) {
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
              BlocBuilder<NotificationValidationCubit,
                  NotificationValidationState>(
                builder: (context, state) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final link = state.links[index];

                        return Dismissible(
                          key: Key(index.toString()),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            final links = List.of(
                                notificationValidationCubit.state.links);

                            links.removeAt(index);

                            notificationValidationCubit.mutate(
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
                                  initialValue: state.links[index].currentValue,
                                  onChange: (value) =>
                                      notificationValidationCubit.mutate(
                                    links: state.links..[index] = Link(value),
                                  ),
                                ),
                              ),
                              if (state.showErrors) ...[
                                link.validatedValue.fold(
                                  (failure) => FieldErrorIndicator(
                                    message:
                                        failure.messageCode.translate(context),
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
                            List.of(notificationValidationCubit.state.links);

                        links.add(const Link(''));

                        notificationValidationCubit.mutate(
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
    );
  }
}
