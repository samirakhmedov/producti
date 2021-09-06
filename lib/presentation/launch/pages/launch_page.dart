import 'package:flutter/material.dart';
import 'package:producti/presentation/core/constants/constants.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacementNamed('/onboarding');
      },
    );

    return Scaffold(
      body: Center(
        child: Text(
          kAppName,
          style: textTheme.headline1,
        ),
      ),
    );
  }
}
