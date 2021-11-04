import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:producti_ui/producti_ui.dart';

class AppSwitcher extends StatefulWidget {
  final void Function()? onTap;
  final bool value;

  const AppSwitcher({
    Key? key,
    this.onTap,
    required this.value,
  }) : super(key: key);

  @override
  _AppSwitcherState createState() => _AppSwitcherState();
}

class _AppSwitcherState extends State<AppSwitcher> {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    return FlutterSwitch(
      value: widget.value,
      onToggle: (value) => widget.onTap?.call(),
      height: 30,
      width: 60,
      duration: const Duration(milliseconds: 100),
      borderRadius: 15,
      toggleSize: 27,
      padding: 2,
      activeColor: theme.primaryColor,
    );
  }
}
