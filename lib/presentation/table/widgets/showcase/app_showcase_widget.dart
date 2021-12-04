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
      child: child,
      title: title,
      description: description,
      showArrow: false,
      animationDuration: const Duration(milliseconds: 1500),
      overlayPadding: const EdgeInsets.all(5),
      titleTextStyle: textTheme.bodyText1!.copyWith(
        color: ThemeHelper.isDarkMode(context) ? kWhite : kBlack,
      ),
      descTextStyle: textTheme.bodyText2,
      showcaseBackgroundColor:
          (ThemeHelper.isDarkMode(context) ? kMainDarkColor : kMainLightColor)
              .withAlpha(200),
    );
  }
}
