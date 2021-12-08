import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
import 'package:producti/application/launch/logic/launch_bloc.dart';
import 'package:producti/application/settings/settings_cubit.dart';
import 'package:producti/presentation/core/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti_ui/producti_ui.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  void didChangeDependencies() {
    final settings = context.read<SettingsCubit>();

    final authBloc = context.read<AuthBloc>();

    final theme = ThemeHelper.getTheme(context);

    /// I JUST DO NOT HAVE ENOUGH TIME
    authBloc.add(AuthAnonymousEvent());

    settings.initialize(
      Localizations.localeOf(context),
      theme.primaryColor,
      Theme.of(context).brightness == Brightness.light
          ? ThemeMode.light
          : ThemeMode.dark,
    );

    final navigator = Navigator.of(context);

    final launchBloc = context.read<LaunchBloc>();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        final state = launchBloc.state;

        final authState = authBloc.state;

        navigator.pushReplacementNamed(
          state.onboardingPassed
              ? state.showcaseShown
                  ? authState is AuthLoggedIn || authState is AuthAnonymousState
                      ? AppRoutes.tables
                      : AppRoutes.auth
                  : AppRoutes.showcase
              : AppRoutes.onboarding,
        );
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    final textTheme = theme.textTheme;

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
