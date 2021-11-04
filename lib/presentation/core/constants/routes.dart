import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:producti/presentation/auth/pages/auth_page.dart';
import 'package:producti/presentation/launch/pages/launch_page.dart';
import 'package:producti/presentation/launch/pages/onboarding_page.dart';
import 'package:producti/presentation/settings/pages/settings_language_page.dart';
import 'package:producti/presentation/settings/pages/settings_page.dart';
import 'package:producti/presentation/table/pages/tables_page.dart';

/// Helper, that holds
/// all named routes.
class AppRoutes {
  static const launch = '/launch';
  static const onboarding = '/onboarding';
  static const auth = '/auth';
  static const tables = '/tables';
  static const settings = '/settings';
  static const settingsLanguage = '/settings/language';
}

final routes = <String, WidgetBuilder>{
  AppRoutes.launch: (BuildContext context) => const LaunchPage(),
  AppRoutes.onboarding: (BuildContext context) => const OnboardingPage(),
  AppRoutes.auth: (BuildContext context) => const AuthPage(),
  AppRoutes.tables: (BuildContext context) => const TablesPage(),
  AppRoutes.settings: (BuildContext context) => const SettingsPage(),
  AppRoutes.settingsLanguage: (BuildContext context) =>
      const SettingsLanguagePage(),
};
