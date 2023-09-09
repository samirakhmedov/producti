import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:showcaseview/showcaseview.dart';

class AppShowcaseWidget extends StatelessWidget {
  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;

  const AppShowcaseWidget({
    Key? key,
    required this.globalKey,
    required this.title,
    required this.description,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeHelper.getTextTheme(context);

    return Showcase(
      key: globalKey,
      title: title,
      description: description,
      showArrow: false,
      movingAnimationDuration: const Duration(milliseconds: 1500),
      scaleAnimationDuration: const Duration(milliseconds: 1500),
      titlePadding: const EdgeInsets.all(5),
      targetPadding: const EdgeInsets.all(5),
      tooltipPadding: const EdgeInsets.all(5),
      descriptionPadding: const EdgeInsets.all(5),
      titleTextStyle: textTheme.bodyText1!.copyWith(
        color: ThemeHelper.isDarkMode(context) ? kWhite : kBlack,
      ),
      tooltipBackgroundColor: (ThemeHelper.isDarkMode(context) ? kMainDarkColor : kMainLightColor).withAlpha(200),
      descTextStyle: textTheme.bodyText2,
      child: child,
    );
  }
}
