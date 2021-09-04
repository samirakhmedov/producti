import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/core/constants/constants.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final analytics = RepositoryProvider.of<FirebaseAnalytics>(
      context,
      listen: false,
    );

    return MaterialApp(
      routes: routes,
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
        Locale('en', ''), // English, no country code
        Locale('ru', ''), // Spanish, no country code
      ],
      initialRoute: '/',
    );
  }
}
