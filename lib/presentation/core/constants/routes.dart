import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:producti/presentation/auth/pages/auth_page.dart';
import 'package:producti/presentation/launch/pages/launch_page.dart';
import 'package:producti/presentation/launch/pages/onboarding_page.dart';
import 'package:producti/presentation/table/pages/tables_page.dart';

/// Helper, that holds
/// all named routes.
class AppRoutes {
  static const launch = '/launch';
  static const onboarding = '/onboarding';
  static const auth = '/auth';
  static const tables = '/tables';
}

final routes = <String, WidgetBuilder>{
  AppRoutes.launch: (BuildContext context) => const LaunchPage(),
  AppRoutes.onboarding: (BuildContext context) => const OnboardingPage(),
  AppRoutes.auth: (BuildContext context) => const AuthPage(),
  AppRoutes.tables: (BuildContext context) => const TablesPage(),
};
