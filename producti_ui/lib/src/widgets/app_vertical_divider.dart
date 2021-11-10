import 'package:flutter/material.dart';
import 'package:producti_ui/src/theme.dart';

class AppVerticalDivider extends StatelessWidget {
  final double height;

  const AppVerticalDivider({Key? key, this.height = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: height,
      color: ThemeHelper.getTheme(context).primaryColor,
    );
  }
}
