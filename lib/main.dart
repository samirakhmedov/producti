import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/presentation/core/widgets/app_widget.dart';

import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  configureDependecies();

  final crashlytics = sl.get<FirebaseCrashlytics>();

  await crashlytics.setCrashlyticsCollectionEnabled(kReleaseMode);

  runZonedGuarded(
    () {
      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => sl.get<FirebaseAnalytics>(),
            ),
          ],
          child: const AppWidget(),
          // child: MultiBlocProvider(
          //   providers: const [],
          //   child: const AppWidget(),
          // ),
        ),
      );
    },
    (error, stack) {
      crashlytics.recordFlutterError(
        FlutterErrorDetails(
          exception: error,
          stack: stack,
        ),
      );
    },
  );
}
