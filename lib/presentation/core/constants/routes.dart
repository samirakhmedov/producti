import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:producti/presentation/launch/pages/launch_page.dart';
import 'package:producti/presentation/launch/pages/onboarding_page.dart';

final routes = <String, WidgetBuilder>{
  '/launch': (BuildContext context) => const LaunchPage(),
  '/onboarding': (BuildContext context) => const OnboardingPage(),
};
