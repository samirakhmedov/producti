import 'package:flutter/material.dart';
import 'package:producti/application/notifications/notifications_bloc.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/application/tables/pages/notification_validation/notification_validation_cubit.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/table_link.dart';
import 'package:producti/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/presentation/table/pages/cells/notifications/notification_cell_create_page.dart';
import 'package:producti/presentation/table/widgets/table_cell_tile.dart';
import 'package:producti/presentation/table/widgets/time_widget.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:producti/domain/notifications/notification.dart' as t;

class NotificationCellViewPage extends StatefulWidget {
  final NotificationTableCell cell;
  final TableLink pathToNote;
  final int tableIndex;

  const NotificationCellViewPage({
    Key? key,
    required this.cell,
    required this.pathToNote,
    required this.tableIndex,
  }) : super(key: key);

  @override
  State<NotificationCellViewPage> createState() =>
      _NotificationCellViewPageState();
}

class _NotificationCellViewPageState extends State<NotificationCellViewPage> {
  late NotificationTableCell _cell;

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
          intl.noteDetails,
          style: textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final noteValidationCubit = NotificationValidationCubit(_cell);

              final result =
                  await Navigator.of(context).push<NotificationTableCell>(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: noteValidationCubit,
                    child: const NotificationCellCreatePage(),
                  ),
                ),
              );

              if (result != null) {
                final bloc = context.read<AnonymousTableBloc>();

                bloc.add(
                  AnonymousTableChangeCell(
                    tableIndex: widget.tableIndex,
                    pathToNote: widget.pathToNote,
                    newCell: result,
                  ),
                );

                if (!result.time.isAtSameMomentAs(_cell.time)) {
                  final notificationsBloc =
                      context.read<LocalNotificationsBloc>();

                  final state = bloc.state as AnonymousTableLoaded;

                  final currentTable = state.tables[widget.tableIndex];

                  notificationsBloc.add(
                    LocalNotificationsCellDelete(
                      currentTable,
                      widget.pathToNote,
                      widget.tableIndex,
                    ),
                  );

                  notificationsBloc.add(
                    LocalNotificationsAddNotification(
                      t.Notification(
                        body: result.description.isEmpty
                            ? intl.voidValue
                            : result.description,
                        title: result.title.isEmpty
                            ? intl.voidValue
                            : result.title,
                        id: widget.pathToNote.getId(widget.tableIndex),
                        pathToNotification: widget.pathToNote,
                        time: result.time,
                      ),
                      widget.tableIndex,
                    ),
                  );
                }
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
              padding: const EdgeInsets.only(bottom: 15),
              sliver: SliverToBoxAdapter(
                child: TimeWidget(
                  time: _cell.time,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 7),
              sliver: SliverToBoxAdapter(
                child: _cell.title.isNotEmpty
                    ? SelectableText(
                        _cell.title,
                        style: textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : VoidTextValue(
                        style: textTheme.headline3,
                      ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 7),
              sliver: SliverToBoxAdapter(
                child: _cell.description.isNotEmpty
                    ? SelectableText(
                        _cell.description,
                        style: textTheme.caption!,
                        maxLines: null,
                      )
                    : VoidTextValue(
                        style: textTheme.caption,
                      ),
              ),
            ),
            if (_cell.links.isNotEmpty) ...[
              const SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.link),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final link = _cell.links[index];

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(),
                        InkWell(
                          onTap: () {
                            launch(link);
                          },
                          child: Text(
                            link,
                            style: textTheme.caption!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    );
                  },
                  childCount: _cell.links.length,
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
