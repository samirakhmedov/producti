import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
import 'package:producti/application/core/simple_bloc_observer.dart';
import 'package:producti/application/launch/logic/launch_bloc.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/presentation/core/widgets/app_widget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'injection.dart';

Future<void> main() async {
  await Hive.initFlutter();

  <TypeAdapter>[
    NoteTableCellAdapter(),
    NotificationTableCellAdapter(),
    GroupTableCellAdapter()
  ].map((e) => Hive.registerAdapter(e));

  Hive.registerAdapter(NoteTableCellAdapter());

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  configureDependecies();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  final crashlytics = sl.get<FirebaseCrashlytics>();

  await crashlytics.setCrashlyticsCollectionEnabled(kReleaseMode);

  Bloc.observer = SimpleBlocObserver();

  runZonedGuarded(
    () {
      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<FirebaseAnalytics>(
              create: (context) => sl.get<FirebaseAnalytics>(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<LaunchBloc>(
                create: (context) => sl.get<LaunchBloc>(),
              ),
              BlocProvider<AuthBloc>(
                create: (context) => sl.get<AuthBloc>(),
              ),
            ],
            child: const AppWidget(),
          ),
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
