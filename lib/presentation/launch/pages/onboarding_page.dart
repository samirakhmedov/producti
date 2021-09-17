import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  String _getImagePath(BuildContext context, int index) {
    final isDarkTheme = ThemeHelper.isDarkMode(context);

    return "assets/onboarding_${isDarkTheme ? 'dark_' : ''}${index + 1}.svg";
  }

  void _next(BuildContext context) {
    context.read<LaunchBloc>().add(const LaunchSwitchOnboardingStatus());

    Navigator.of(context).pushReplacementNamed(AppRoutes.auth);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final OnboardingPageController _controller = OnboardingPageController();

    final PageController _pageController = PageController();

    final _tabDataList = [
      TabData(
        imagePath: _getImagePath(context, 0),
        title: S.of(context).fast,
        description: S.of(context).onboardingDesc1,
      ),
      TabData(
        imagePath: _getImagePath(context, 1),
        title: S.of(context).comfortable,
        description: S.of(context).onboardingDesc2,
      ),
      TabData(
        imagePath: _getImagePath(context, 2),
        title: S.of(context).effective,
        description: S.of(context).onboardingDesc3,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is UserScrollNotification &&
                        notification.direction != ScrollDirection.idle) {
                      final change =
                          notification.direction == ScrollDirection.reverse
                              ? 1
                              : -1;

                      _controller.currentIndex =
                          _controller.currentIndex + change;
                    }

                    return false;
                  },
                  child: PageView.builder(
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TabDataView(
                          data: _tabDataList[index],
                        ),
                      );
                    },
                    itemCount: 3,
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        child: ClickableText(
                          text: S.of(context).skip,
                          color: kLightGray,
                          onTap: () {
                            _next(context);
                          },
                        ),
                      ),
                      Obx(
                        () => TabIndexView(
                          length: 3,
                          current: _controller.currentIndex,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: ClickableText(
                          text: S.of(context).next,
                          onTap: () {
                            final page = _controller.currentIndex;

                            if (page == 2) {
                              return _next(context);
                            }

                            _pageController.animateToPage(
                              page + 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );

                            _controller.currentIndex =
                                _controller.currentIndex + 1;
                          },
                        ),
                      ),
                    ],
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
