import 'package:flutter/material.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/application/tables/pages/note_validation/note_validation_cubit.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/table_link.dart';
import 'package:producti/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/presentation/table/widgets/table_cell_tile.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import 'note_cell_create_page.dart';

class NoteCellViewPage extends StatefulWidget {
  final NoteTableCell cell;
  final TableLink pathToNote;
  final int tableIndex;

  const NoteCellViewPage({
    Key? key,
    required this.cell,
    required this.pathToNote,
    required this.tableIndex,
  }) : super(key: key);

  @override
  State<NoteCellViewPage> createState() => _NoteCellViewPageState();
}

class _NoteCellViewPageState extends State<NoteCellViewPage> {
  late NoteTableCell _cell;

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
              final noteValidationCubit = NoteValidationCubit(_cell);

              final result = await Navigator.of(context).push<NoteTableCell>(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: noteValidationCubit,
                    child: const NoteCellCreatePage(),
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
