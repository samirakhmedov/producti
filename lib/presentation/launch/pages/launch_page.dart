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
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final theme = ThemeHelper.getTheme(context);

      final navigator = Navigator.of(context);

      /// I JUST DO NOT HAVE ENOUGH TIME

      context.read<AuthBloc>().add(AuthAnonymousEvent());

      final settings = context.read<SettingsCubit>();

      if (settings.state.language == null) {
        settings.initialize(
          Localizations.localeOf(context),
          theme.primaryColor,
          Theme.of(context).brightness == Brightness.light
              ? ThemeMode.light
              : ThemeMode.dark,
        );
      }

      Future.delayed(
        const Duration(seconds: 2),
        () {
          final state = context.read<LaunchBloc>().state;

          final authState = context.read<AuthBloc>().state;

          navigator.pushReplacementNamed(
            state.onboardingPassed
                ? state.showcaseShown
                    ? authState is AuthLoggedIn ||
                            authState is AuthAnonymousState
                        ? AppRoutes.tables
                        : AppRoutes.auth
                    : AppRoutes.showcase
                : AppRoutes.onboarding,
          );
        },
      );
    });
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
