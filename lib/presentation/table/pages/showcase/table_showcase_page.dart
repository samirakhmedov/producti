import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:producti/domain/table/cells/table_cell.dart' as c;
import 'package:producti/domain/table/table.dart' as t;
import 'package:producti/domain/table/table_link.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/table/widgets/app_showcase_widget.dart';
import 'package:producti/presentation/table/widgets/create_popup_tile.dart';
import 'package:producti/presentation/table/widgets/path_name_widget.dart';
import 'package:producti/presentation/table/widgets/table_cell_tile.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:rxdart/rxdart.dart';
import 'package:showcaseview/showcaseview.dart';

/// TODO: Implement after s h o w c a s e
class TableShowcasePage extends StatelessWidget {
  const TableShowcasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stream = BehaviorSubject<int>.seeded(-1);

    return ShowCaseWidget(
      onFinish: () => stream.add(stream.value + 1),
      builder: Builder(
        builder: (context) => _TableShowcaseContent(
          completeStream: stream,
        ),
      ),
    );
  }
}

class _TableShowcaseContent extends StatefulWidget {
  final BehaviorSubject<int> completeStream;

  const _TableShowcaseContent({
    Key? key,
    required this.completeStream,
  }) : super(key: key);

  @override
  State<_TableShowcaseContent> createState() => _TableShowcaseContentState();
}

class _TableShowcaseContentState extends State<_TableShowcaseContent> {
  final t.Table _showcaseTable = t.Table(
    title: 'Main',
    cells: [
      c.NoteTableCell(title: 'Do something', description: 'you awesome'),
      c.NoteTableCell(
        title: 'Another note',
        links: const [
          'https://firebaselogging-pa.googleapis.com/v1/firelog/legacy/batchlog'
        ],
      ),
      c.GroupTableCell(
        title: 'Another note',
      ),
      c.NotificationTableCell(
        time: DateTime.now(),
        description: 'Wow',
      ),
    ],
  );

  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  final GlobalKey _four = GlobalKey();
  final GlobalKey _five = GlobalKey();
  final GlobalKey _six = GlobalKey();
  final GlobalKey _seven = GlobalKey();
  final GlobalKey _eight = GlobalKey();
  final GlobalKey _nine = GlobalKey();
  final GlobalKey _ten = GlobalKey();
  final GlobalKey _eleven = GlobalKey();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isOpened = false;

  final _slidableController = SlidableController();

  void _openDrawer() {
    setState(() {
      _isOpened = !_isOpened;
    });
  }

  @override
  void didChangeDependencies() {
    final theme = ThemeHelper.getTheme(context);

    final query = MediaQuery.of(context);

    widget.completeStream.listen((index) {
      if (index == 0) {
        _openDrawer();

        Future.delayed(const Duration(seconds: 1)).then(
          (value) => ShowCaseWidget.of(context)!.startShowCase([_two]),
        );
      } else if (index == 1) {
        ShowCaseWidget.of(context)!.startShowCase([_three, _four, _five, _six]);
      } else if (index == 2) {
        _openDrawer();

        Future.delayed(const Duration(seconds: 1)).then(
          (value) => ShowCaseWidget.of(context)!.startShowCase([_seven]),
        );
      } else if (index == 3) {
        setState(() {
          _showcaseTable.cells = [_showcaseTable.cells.first];
        });

        _slidableController.activeState?.open();

        Future.delayed(const Duration(seconds: 1)).then(
          (value) => ShowCaseWidget.of(context)!
              .startShowCase([_eight, _nine, _ten, _eleven]),
        );
      }
    });

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        await showDialog(
          context: context,
          builder: (context) => Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SizedBox.fromSize(
                size: query.size,
                child: Center(
                  child: Text(
                    'intl.welcome',
                    style: theme.textTheme.bodyText2!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        ShowCaseWidget.of(context)!.startShowCase([_one]);
      },
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final intl = S.of(context);

    final theme = ThemeHelper.getTheme(context);

    final query = MediaQuery.of(context);

    return Scaffold(
      key: _scaffoldKey,
      // endDrawer: _TablesDrawer(
      //   tableIndex: tableIndex,
      // ),
      body: SafeArea(
        child: SizedBox(
          width: query.size.width,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 50,
                child: SizedBox(
                  width: query.size.width,
                  child: _TableShowcaseBody(
                    cells: _showcaseTable.cells,
                    allCellsKey: _seven,
                    firstCellKey: _eight,
                    firstSlideActionKey: _nine,
                    secondSlideActionKey: _ten,
                    thirdSlideActionKey: _eleven,
                    controller: _slidableController,
                  ),
                ),
              ),
              Positioned(
                left: 15,
                bottom: 15,
                child: AppShowcaseWidget(
                  title: 'one',
                  description: 'one',
                  globalKey: _one,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.add,
                      color: theme.backgroundColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: PathNameWidget(
                    table: _showcaseTable,
                    tableIndex: 0,
                    path: const TableLink([]),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.menu),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 750),
                curve: Curves.easeIn,
                bottom: _isOpened ? 0 : -query.size.height * 0.37,
                child: AppBottomSheet(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                    ).copyWith(top: 46.sp),
                    child: AppShowcaseWidget(
                      globalKey: _two,
                      title: 'Two',
                      description: 'Two',
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppShowcaseWidget(
                            globalKey: _three,
                            title: 'Three',
                            description: 'Three',
                            child: CreatePopupTile(
                              icon: Icons.menu,
                              title: intl.group,
                            ),
                          ),
                          const Gap(size: 12),
                          AppShowcaseWidget(
                            globalKey: _four,
                            title: 'Three',
                            description: 'Three',
                            child: CreatePopupTile(
                              icon: Icons.edit,
                              title: intl.note,
                            ),
                          ),
                          const Gap(size: 12),
                          AppShowcaseWidget(
                            globalKey: _five,
                            title: 'Three',
                            description: 'Three',
                            child: CreatePopupTile(
                              icon: Icons.access_time,
                              title: intl.notification,
                            ),
                          ),
                          const Gap(size: 12),
                          AppShowcaseWidget(
                            globalKey: _six,
                            title: 'Three',
                            description: 'Three',
                            child: CreatePopupTile(
                              icon: Icons.list_rounded,
                              title: intl.checkList,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TableShowcaseBody extends StatelessWidget {
  final List<c.TableCell> cells;

  final GlobalKey allCellsKey;
  final GlobalKey firstCellKey;
  final GlobalKey firstSlideActionKey;
  final GlobalKey secondSlideActionKey;
  final GlobalKey thirdSlideActionKey;

  final SlidableController controller;

  const _TableShowcaseBody({
    Key? key,
    required this.cells,
    required this.controller,
    required this.firstCellKey,
    required this.firstSlideActionKey,
    required this.secondSlideActionKey,
    required this.thirdSlideActionKey,
    required this.allCellsKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intl = S.of(context);

    final theme = ThemeHelper.getTheme(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: AppShowcaseWidget(
        globalKey: allCellsKey,
        title: 'Title',
        description: 'Description',
        child: cells.length == 1
            ? Slidable(
                actionPane: const SlidableDrawerActionPane(),
                controller: controller,
                actions: [
                  IconSlideAction(
                    key: firstSlideActionKey,
                    caption: intl.rename,
                    color: Colors.blue,
                    icon: Icons.edit,
                    foregroundColor: theme.backgroundColor,
                    onTap: () async {},
                  ),
                  IconSlideAction(
                    key: secondSlideActionKey,
                    caption: intl.edit,
                    color: Colors.blue,
                    icon: Icons.edit,
                    foregroundColor: theme.backgroundColor,
                    onTap: () async {},
                  ),
                  IconSlideAction(
                    key: thirdSlideActionKey,
                    caption: intl.delete,
                    color: kRed,
                    icon: Icons.delete,
                    foregroundColor: theme.backgroundColor,
                    onTap: () async {},
                  ),
                ],
                child: TableCellTile(
                  cell: cells.single,
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  cells.length,
                  (index) {
                    final cell = cells[index];

                    return Slidable(
                      key: Key(index.toString()),
                      actionPane: const SlidableDrawerActionPane(),
                      controller: index == 0 ? controller : null,
                      actions: [
                        if (cell is c.GroupTableCell)
                          IconSlideAction(
                            key: index == 0 ? firstSlideActionKey : null,
                            caption: intl.rename,
                            color: Colors.blue,
                            icon: Icons.edit,
                            foregroundColor: theme.backgroundColor,
                            onTap: () async {},
                          )
                        else
                          IconSlideAction(
                            key: index == 0 ? secondSlideActionKey : null,
                            caption: intl.edit,
                            color: Colors.blue,
                            icon: Icons.edit,
                            foregroundColor: theme.backgroundColor,
                            onTap: () async {},
                          ),
                        IconSlideAction(
                          key: index == 0 ? thirdSlideActionKey : null,
                          caption: intl.delete,
                          color: kRed,
                          icon: Icons.delete,
                          foregroundColor: theme.backgroundColor,
                          onTap: () async {},
                        ),
                      ],
                      child: TableCellTile(
                        cell: cell,
                        key: Key(index.toString()),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
