import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/application/settings/settings_cubit.dart';
import 'dart:ui' as ui;

import 'package:producti_ui/producti_ui.dart';

/// Widget, that propogates [ThemeData] of app
/// throughout the widget tree. Also listens
/// to [SettingsCubit] and changes theme.
class AppThemeWidget extends StatelessWidget {
  final Widget child;

  const AppThemeWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness platformBrightness =
        MediaQuery.platformBrightnessOf(context);
    final bool useDarkTheme = platformBrightness == ui.Brightness.dark;

    ThemeData? theme;

    if (useDarkTheme) {
      theme = kDarkTheme;
    }

    theme ??= kLightTheme;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Theme(
          data: theme!.copyWith(
            primaryColor: state.accentColor,
            iconTheme: kLightTheme.iconTheme.copyWith(
              color: state.accentColor,
            ),
            appBarTheme: kLightTheme.appBarTheme.copyWith(
              iconTheme: kLightTheme.appBarTheme.iconTheme!.copyWith(
                color: state.accentColor,
              ),
            ),
          ),
          child: child,
        );
      },
    );
  }
}
