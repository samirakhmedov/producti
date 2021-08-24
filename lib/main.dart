import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:producti/presentation/core/widgets/app_widget.dart';

import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependecies();

  final crashlytics = sl.get<FirebaseCrashlytics>();

  await crashlytics.setCrashlyticsCollectionEnabled(kReleaseMode);

  runZonedGuarded(
    () {
      runApp(
        const AppWidget(),
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
