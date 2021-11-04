import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:producti_ui/src/theme.dart';

class AppThemeSwitcher extends StatelessWidget {
  final ThemeMode value;
  final void Function(ThemeMode themeMode)? onTap;

  const AppThemeSwitcher({
    Key? key,
    required this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    return FlutterSwitch(
      value: value == ThemeMode.light,
      onToggle: (_) => onTap?.call(
        value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
      ),
      height: 30,
      width: 60,
      duration: const Duration(milliseconds: 100),
      borderRadius: 15,
      toggleSize: 27,
      padding: 2,
      toggleColor: theme.backgroundColor,
      activeColor: const Color(0xFF1E91D1),
      activeIcon: const Icon(
        Icons.light_mode,
        color: Color(0xFFEEF146),
      ),
      inactiveColor: const Color(0xFF0A39B2),
      inactiveIcon: const Icon(
        Icons.dark_mode,
        color: Color(0xFFBFD4E7),
      ),
    );
  }
}
