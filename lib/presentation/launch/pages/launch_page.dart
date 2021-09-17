import 'package:flutter/material.dart';
import 'package:producti/application/launch/bloc/launch_bloc.dart';
import 'package:producti/presentation/core/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    Future.delayed(
      const Duration(seconds: 2),
      () {
        final launchBloc = context.read<LaunchBloc>();

        final state = launchBloc.state;

        Navigator.of(context).pushReplacementNamed(
          state.onboardingPassed ? AppRoutes.auth : AppRoutes.onboarding,
        );
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
