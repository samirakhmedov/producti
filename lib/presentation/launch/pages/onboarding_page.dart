import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:producti/application/launch/bloc/launch_bloc.dart';
import 'package:producti/application/launch/getx/onboarding_page_controller.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/core/constants/constants.dart';
import 'package:producti/presentation/launch/widgets/tab_data_view.dart';
import 'package:producti/presentation/launch/widgets/tab_index_view.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabData {
  final String imagePath;
  final String title;
  final String description;

  const TabData({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  final OnboardingPageController _controller = OnboardingPageController();

  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      _controller.currentIndex = _tabController.index;
    });

    super.initState();
  }

  String _getImagePath(int index) {
    final isDarkTheme = ThemeHelper.isDarkMode(context);

    return "assets/onboarding_${isDarkTheme ? 'dark_' : ''}${index + 1}.svg";
  }

  void _next() {
    context.read<LaunchBloc>().add(const LaunchSwitchOnboardingStatus());

    Navigator.of(context).pushReplacementNamed(AppRoutes.launch);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TabData(
                      imagePath: _getImagePath(0),
                      title: S.of(context).fast,
                      description: S.of(context).onboardingDesc1,
                    ),
                    TabData(
                      imagePath: _getImagePath(1),
                      title: S.of(context).comfortable,
                      description: S.of(context).onboardingDesc2,
                    ),
                    TabData(
                      imagePath: _getImagePath(2),
                      title: S.of(context).effective,
                      description: S.of(context).onboardingDesc3,
                    ),
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TabDataView(data: e),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                width: size.width,
                height: 50,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClickableText(
                          text: S.of(context).skip,
                          color: kLightGray,
                          onTap: () {
                            _next();
                          },
                        ),
                        Obx(
                          () => TabIndexView(
                            length: 3,
                            current: _controller.currentIndex,
                          ),
                        ),
                        ClickableText(
                          text: S.of(context).next,
                          onTap: () {
                            if (_tabController.index == 2) {
                              _next();
                            } else {
                              _tabController
                                  .animateTo(_tabController.index + 1);
                            }
                          },
                        ),
                      ],
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
