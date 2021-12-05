import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
import 'package:producti/application/settings/settings_cubit.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/core/constants/constants.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti_ui/producti_ui.dart';

/// Root app widget.
///
/// Responsible for [AppLifeCycle], setting up
/// theme, locales, creating [WidgetsApp] instance.
class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

/// Adds bindings callbacks to specific [Widget] instance.
///
/// For example, [Navigator] moves or [Locale] change.
class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    /// Registeres this widget in [WidgetsBinding], that calls callbacks
    /// of that specific [BaseBinding].
    WidgetsBinding.instance!.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    /// Removes this widget from list of registeted
    /// widgets in [WidgetsBinding].
    ///
    /// No longer reacts on binding callbacks.
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// The application is not currently visible to the user, not responding to
    /// user input, and running in the background.
    if (state == AppLifecycleState.paused) {
      final authBloc = context.read<AuthBloc>();

      if (authBloc.state is AuthLoggedIn) {
      } else {
        final anonymous = context.read<AnonymousTableBloc>();

        if (anonymous.state is AnonymousTableLoaded) {
          anonymous.add(AnonymousTableSave());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final analytics = RepositoryProvider.of<FirebaseAnalytics>(
      context,
      listen: false,
    );

    if (Platform.isAndroid) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.init(
          constraints,
          orientation: Orientation.portrait,
          designSize: const Size(375, 667),
        );

        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return MaterialApp(
              routes: routes,
              title: kAppName,
              navigatorObservers: [
                FirebaseAnalyticsObserver(analytics: analytics),
              ],
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('ru', ''),
              ],
              locale: state.language,
              themeMode: state.themeMode,
              initialRoute: AppRoutes.launch,
              theme: kLightTheme.copyWith(
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
              darkTheme: kDarkTheme.copyWith(
                primaryColor: state.accentColor,
                iconTheme: kDarkTheme.iconTheme.copyWith(
                  color: state.accentColor,
                ),
                appBarTheme: kDarkTheme.appBarTheme.copyWith(
                  iconTheme: kDarkTheme.appBarTheme.iconTheme!.copyWith(
                    color: state.accentColor,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
