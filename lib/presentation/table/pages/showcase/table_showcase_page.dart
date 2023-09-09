import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:producti/application/launch/logic/launch_bloc.dart';
import 'package:producti/domain/table/cells/table_cell.dart' as c;
import 'package:producti/domain/table/table.dart' as t;
import 'package:producti/domain/table/table_link.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti/presentation/table/widgets/showcase/app_showcase_widget.dart';
import 'package:producti/presentation/table/widgets/create_popup_tile.dart';
import 'package:producti/presentation/table/widgets/path_name_widget.dart';
import 'package:producti/presentation/table/widgets/showcase/empty_showcase_widget.dart';
import 'package:producti/presentation/table/widgets/table_cell_tile.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:rxdart/rxdart.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  t.Table? _showcaseTable;

  TableLink _tableLink = const TableLink([]);

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
  final GlobalKey _twelve = GlobalKey();
  final GlobalKey _thirteen = GlobalKey();
  final GlobalKey _fourteen = GlobalKey();
  final GlobalKey _fiveteen = GlobalKey();
  final GlobalKey _sixteen = GlobalKey();
  final GlobalKey _seventeen = GlobalKey();
  final GlobalKey _eighteen = GlobalKey();
  final GlobalKey _nineteen = GlobalKey();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isBottomSheetOpened = false;
  bool _isDrawerOpened = false;

  void _openBottomSheet() {
    setState(() {
      _isBottomSheetOpened = !_isBottomSheetOpened;
    });
  }

  void _openDrawer() {
    setState(() {
      _isDrawerOpened = !_isDrawerOpened;
    });
  }

  @override
  void didChangeDependencies() {
    final intl = S.of(context);

    if (_showcaseTable == null) {
      _showcaseTable = t.Table(
        title: 'Main',
        cells: [
          c.NoteTableCell(
            title: intl.doSomething,
            description: intl.youAwesome,
          ),
          c.NoteTableCell(
            title: intl.anotherNote,
            links: const ['https://pub.dev/packages/showcaseview'],
          ),
          c.GroupTableCell(
            title: intl.anotherGroup,
          ),
          c.NotificationTableCell(
            time: DateTime.now(),
            description: intl.wow,
          ),
          c.CheckListTableCell(
            title: intl.checkList,
            checkList: [
              c.CheckTileTableCell(
                title: intl.wow,
              ),
              c.CheckTileTableCell(
                title: intl.ok,
                value: true,
              ),
            ],
          ),
        ],
      );

      final theme = ThemeHelper.getTheme(context);

      final query = MediaQuery.of(context);

      widget.completeStream.listen((index) {
        switch (index) {
          case 0:
            _openBottomSheet();

            Future.delayed(const Duration(seconds: 1)).then(
              (value) => ShowCaseWidget.of(context).startShowCase([_two]),
            );
            break;
          case 1:
            ShowCaseWidget.of(context).startShowCase([_three, _four, _five, _six]);
            break;
          case 2:
            _openBottomSheet();

            Future.delayed(const Duration(seconds: 1)).then(
              (value) => ShowCaseWidget.of(context).startShowCase([_seven]),
            );
            break;
          case 3:
            setState(() {
              _showcaseTable!.cells = [_showcaseTable!.cells.first];
            });

            ShowCaseWidget.of(context).startShowCase([_eight, _nine, _ten]);
            break;
          case 4:
            setState(() {
              _showcaseTable!.addCell(
                c.GroupTableCell(
                  title: intl.anotherGroup,
                ),
                _tableLink,
              );
            });

            ShowCaseWidget.of(context).startShowCase([_eleven, _twelve]);
            break;
          case 5:
            ShowCaseWidget.of(context).startShowCase([_thirteen]);
            break;
          case 6:
            setState(() {
              _tableLink = _tableLink.addPath(1);
            });

            ShowCaseWidget.of(context).startShowCase([_fourteen, _fiveteen]);
            break;

          case 7:
            _openDrawer();

            Future.delayed(const Duration(seconds: 1)).then(
              (value) => ShowCaseWidget.of(context).startShowCase([_sixteen, _seventeen, _eighteen, _nineteen]),
            );

            break;

          case 8:
            _openDrawer();

            Future.delayed(const Duration(seconds: 1)).then(
              (value) => showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(.7),
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
                          intl.youAreReady,
                          style: theme.textTheme.bodyText2!.copyWith(
                            color: kWhite,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ).then(
                (value) {
                  final launch = context.read<LaunchBloc>();

                  launch.mutate(showcaseShown: true);

                  Navigator.of(context).pushReplacementNamed(AppRoutes.tables);
                },
              ),
            );

            break;
        }
      });

      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          final result = await showDialog<bool>(
            context: context,
            barrierColor: Colors.black.withOpacity(.7),
            builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: Material(
                color: Colors.transparent,
                child: SizedBox.fromSize(
                  size: query.size,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Center(
                            child: Text(
                              intl.welcome,
                              style: theme.textTheme.bodyText2!.copyWith(
                                color: kWhite,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClickableText(
                          text: intl.goThroughShowcase,
                          color: theme.primaryColor,
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: ClickableText(
                          text: intl.skipShowcase,
                          textStyle: theme.textTheme.bodyText2!.copyWith(
                            color: kRed,
                          ),
                          onTap: () {
                            final launch = context.read<LaunchBloc>();

                            launch.mutate(showcaseShown: true);

                            Navigator.of(context).popAndPushNamed(AppRoutes.tables, result: false);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

          if (result ?? true) ShowCaseWidget.of(context).startShowCase([_one]);
        },
      );
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final intl = S.of(context);

    final theme = ThemeHelper.getTheme(context);

    final query = MediaQuery.of(context);

    return Scaffold(
      key: _scaffoldKey,
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
                    cells: _tableLink.getParticles(_showcaseTable!),
                    allCellsKey: _seven,
                    noteCellKey: _eight,
                    firstSlideActionKey: _nine,
                    secondSlideActionKey: _ten,
                    groupCellKey: _eleven,
                    groupSlideActionKey: _twelve,
                  ),
                ),
              ),
              Positioned(
                left: 15,
                bottom: 15,
                child: AppShowcaseWidget(
                  title: intl.addButtonTitle,
                  description: intl.addButtonDescription,
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
                  child: StreamBuilder<int>(
                      stream: widget.completeStream,
                      builder: (context, snapshot) {
                        if ((snapshot.data ?? -1) > 5) {
                          return AppShowcaseWidget(
                            title: intl.complexPathNameTitle,
                            description: intl.complexPathNameDescription,
                            globalKey: _fourteen,
                            child: PathNameWidget(
                              table: _showcaseTable!,
                              tableIndex: 0,
                              path: _tableLink,
                            ),
                          );
                        }

                        return AppShowcaseWidget(
                          title: intl.simplePathNameTitle,
                          description: intl.simplePathNameDescription,
                          globalKey: _thirteen,
                          child: PathNameWidget(
                            table: _showcaseTable!,
                            tableIndex: 0,
                            path: _tableLink,
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: AppShowcaseWidget(
                    title: intl.drawerOpenButtonTitle,
                    description: intl.drawerOpenButtonDescription,
                    globalKey: _fiveteen,
                    child: const Icon(Icons.menu),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 750),
                curve: Curves.easeIn,
                bottom: _isBottomSheetOpened ? 0 : -query.size.height * 0.37,
                child: AppBottomSheet(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                    ).copyWith(top: 42.sp),
                    child: EmptyShowcaseWidget(
                      globalKey: _two,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppShowcaseWidget(
                            globalKey: _three,
                            title: intl.group,
                            description: intl.bottomSheetGroupDescription,
                            child: CreatePopupTile(
                              icon: Icons.menu,
                              title: intl.group,
                            ),
                          ),
                          Gap(size: 12.sp),
                          AppShowcaseWidget(
                            globalKey: _four,
                            title: intl.note,
                            description: intl.bottomSheetNoteDescription,
                            child: CreatePopupTile(
                              icon: Icons.edit,
                              title: intl.note,
                            ),
                          ),
                          Gap(size: 12.sp),
                          AppShowcaseWidget(
                            globalKey: _five,
                            title: intl.notification,
                            description: intl.bottomSheetNotificationDescription,
                            child: CreatePopupTile(
                              icon: Icons.access_time,
                              title: intl.notification,
                            ),
                          ),
                          Gap(size: 12.sp),
                          AppShowcaseWidget(
                            globalKey: _six,
                            title: intl.checkList,
                            description: intl.bottomSheetCheckListDescription,
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
              AnimatedPositioned(
                duration: const Duration(milliseconds: 750),
                curve: Curves.easeIn,
                right: _isDrawerOpened ? 0 : -query.size.width * .8,
                child: EmptyShowcaseWidget(
                  globalKey: _sixteen,
                  child: SizedBox(
                    width: query.size.width * 0.8,
                    height: query.size.height * .95,
                    child: Drawer(
                      elevation: 10.0,
                      child: Container(
                        color: theme.backgroundColor,
                        child: Column(
                          children: [
                            SizedBox(
                              height: query.padding.top + 15,
                            ),
                            const Gap(),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: AppShowcaseWidget(
                                  globalKey: _seventeen,
                                  description: intl.tablesListDescription,
                                  title: intl.tablesListTitle,
                                  child: DrawerListTile(
                                    text: _showcaseTable!.title,
                                    icon: Icons.grid_view_outlined,
                                    selected: true,
                                  ),
                                ),
                              ),
                            ),
                            AppShowcaseWidget(
                              globalKey: _eighteen,
                              description: intl.addTableDescription,
                              title: intl.addTableTitle,
                              child: DrawerListTile(
                                text: intl.addOne,
                                icon: Icons.add,
                              ),
                            ),
                            const AppDivider(),
                            AppShowcaseWidget(
                              globalKey: _nineteen,
                              description: intl.settingsDescription,
                              title: intl.settingsTitle,
                              child: DrawerListTile(
                                text: intl.settings,
                                icon: Icons.settings,
                              ),
                            ),
                          ],
                        ),
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
  final GlobalKey noteCellKey;
  final GlobalKey firstSlideActionKey;
  final GlobalKey secondSlideActionKey;
  final GlobalKey groupCellKey;
  final GlobalKey groupSlideActionKey;

  const _TableShowcaseBody({
    Key? key,
    required this.cells,
    required this.firstSlideActionKey,
    required this.secondSlideActionKey,
    required this.allCellsKey,
    required this.noteCellKey,
    required this.groupCellKey,
    required this.groupSlideActionKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intl = S.of(context);

    final theme = ThemeHelper.getTheme(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: AppShowcaseWidget(
        globalKey: allCellsKey,
        title: intl.allCellsTitle,
        description: intl.allCellsDescription,
        child: cells.length == 1
            ? AppShowcaseWidget(
                globalKey: noteCellKey,
                title: intl.cellSwipeRightTitle,
                description: intl.cellSwipeRightDescription,
                child: SizedBox(
                  height: 64,
                  child: Row(
                    children: [
                      Flexible(
                        child: AppShowcaseWidget(
                          globalKey: firstSlideActionKey,
                          title: intl.firstSlideActionTitle,
                          description: intl.firstSlideActionDescription,
                          child: SlidableAction(
                            onPressed: (ctx) {},
                            label: intl.edit,
                            backgroundColor: Colors.blue,
                            icon: Icons.edit,
                            foregroundColor: theme.backgroundColor,
                          ),
                        ),
                      ),
                      Flexible(
                        child: AppShowcaseWidget(
                          globalKey: secondSlideActionKey,
                          title: intl.secondSlideActionTitle,
                          description: intl.secondSlideActionDescription,
                          child: SlidableAction(
                            onPressed: (ctx) {},
                            label: intl.delete,
                            backgroundColor: kRed,
                            icon: Icons.delete,
                            foregroundColor: theme.backgroundColor,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: TableCellTile(
                          cell: cells.single,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : cells.length == 2
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TableCellTile(
                        cell: cells[0],
                      ),
                      AppShowcaseWidget(
                        globalKey: groupCellKey,
                        title: intl.groupCellRightSwipeTitle,
                        description: intl.groupCellRightSwipeDescription,
                        child: SizedBox(
                          height: 45,
                          child: Row(
                            children: [
                              Flexible(
                                child: AppShowcaseWidget(
                                  globalKey: groupSlideActionKey,
                                  title: intl.groupFirstActionTitle,
                                  description: intl.groupFirstActionDescription,
                                  child: SlidableAction(
                                    onPressed: (ctx) {},
                                    label: intl.rename,
                                    backgroundColor: Colors.blue,
                                    icon: Icons.edit,
                                    foregroundColor: theme.backgroundColor,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: SlidableAction(
                                  onPressed: (ctx) {},
                                  label: intl.delete,
                                  backgroundColor: kRed,
                                  icon: Icons.delete,
                                  foregroundColor: theme.backgroundColor,
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: TableCellTile(
                                  cell: cells[1],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      cells.length,
                      (index) {
                        final cell = cells[index];

                        return TableCellTile(
                          cell: cell,
                          key: Key(index.toString()),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
