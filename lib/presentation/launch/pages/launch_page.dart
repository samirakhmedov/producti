import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
import 'package:producti/application/launch/logic/launch_bloc.dart';
import 'package:producti/application/settings/settings_cubit.dart';
import 'package:producti/presentation/core/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti_ui/producti_ui.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    final textTheme = theme.textTheme;

    final settings = context.read<SettingsCubit>();

    final authBloc = context.read<AuthBloc>();

    /// I JUST DO NOT HAVE ENOUGH TIME
    authBloc.add(AuthAnonymousEvent());

    settings.initialize(
      Localizations.localeOf(context),
      theme.primaryColor,
      Theme.of(context).brightness == Brightness.light
          ? ThemeMode.light
          : ThemeMode.dark,
    );

    Future.delayed(
      const Duration(seconds: 2),
      () {
        final launchBloc = context.read<LaunchBloc>();

        final state = launchBloc.state;

        final authState = authBloc.state;

        Navigator.of(context).pushReplacementNamed(
          state.onboardingPassed
              ? authState is AuthLoggedIn || authState is AuthAnonymousState
                  ? AppRoutes.tables
                  : AppRoutes.auth
              : AppRoutes.onboarding,
        );
      },
    );

    return Scaffold(
      body: Center(
        child: Text(
          kAppName,
          style: GoogleFonts.tajawal().merge(
            textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
