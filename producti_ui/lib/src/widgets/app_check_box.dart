import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class AppCheckBox extends StatefulWidget {
  final bool value;
  final void Function(bool? value)? onTap;

  const AppCheckBox({
    Key? key,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  _AppCheckBoxState createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    return Checkbox(
      value: widget.value,
      onChanged: widget.onTap,
      activeColor: theme.primaryColor,
      checkColor: ThemeHelper.isDarkMode(context) ? kBlack : kWhite,
    );
  }
}
