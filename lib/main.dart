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
import 'package:producti/application/core/cubit/connection_cubit.dart';
import 'package:producti/application/launch/logic/launch_bloc.dart';
import 'package:producti/application/notifications/notifications_bloc.dart';
import 'package:producti/application/settings/settings_cubit.dart';
import 'package:producti/application/tables/logic/anonymous/anonymous_table_bloc.dart';
import 'package:producti/application/tables/logic/user/table_bloc.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/table.dart';
import 'package:producti/presentation/core/widgets/app_widget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'injection.dart';

/// Welcome to `producti` project!
///
/// This project is summary to my skills. All my
/// earned XP from clients, on job - is this project.
///
/// There I will make all my dreams and thoughts come true.
/// Also, there will be new cool things I learned recently, so...
///
/// Yeah.
///
/// List of learned things:
/// 1. [WidgetsBinding].instance!.scheduleWarmUpFrame()
/// 2. [PointerSignalResolver].register
/// 3. [RawAutocomplete]
/// 4. [ObserverList]
/// 5. [Feedback]

Future<void> main() async {
  /// Initialises and connects all [BindingBase] instances to Flutter Engine.
  ///
  /// It makes possible to initialise all other dependecies and
  /// use them before `runApp` started.
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialises new [FirebaseApp] instance according to
  /// configs dependant on platform.
  await Firebase.initializeApp();

  /// Secondary, initialising [Hive] local database.
  ///
  /// It automatically use platform-specific path
  /// to directories for user files, and places all
  /// records there.
  await Hive.initFlutter();

  /// `Type adapters can be implemented to support non primitive values.`
  /// ...like some models, you know.
  Hive.registerAdapter(TableAdapter());
  Hive.registerAdapter(NoteTableCellAdapter());
  Hive.registerAdapter(NotificationTableCellAdapter());
  Hive.registerAdapter(GroupTableCellAdapter());

  /// Afterwards, creates [Storage] instance for
  /// [HydratedBloc], where all [Bloc] states will
  /// be saved.
  ///
  /// Saves are made on specified directory, based on [Hive] storage.
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  /// Creates singletons, factories, etc. of all project's
  /// dependecies.
  ///
  /// `sl` after that contains all instances
  /// to most efficient and proper way to run app.
  await configureDependecies();

  /// Set ups [FirebaseCrashlytics] avaliability.
  ///
  /// It means that next 3 lines of code makes
  /// [FirebaseCrashlytics] send crash reports
  /// depending what run config is current (release or other)
  final crashlytics = sl.get<FirebaseCrashlytics>();

  await crashlytics.setCrashlyticsCollectionEnabled(kReleaseMode);

  runZonedGuarded(
    () {
      /// Yeah, I did that. Complain.
      ///
      ///
      ///
      /// Set ups and configures current widget, render
      /// and element tree.
      ///
      /// After that adds some more time to frame for
      /// warming up and preparing for next frame.
      WidgetsBinding.instance!
        // ignore: invalid_use_of_protected_member
        ..scheduleAttachRootWidget(
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
                BlocProvider<TableBloc>(
                  create: (context) => sl.get<TableBloc>(),
                ),
                BlocProvider<AnonymousTableBloc>(
                  create: (context) => sl.get<AnonymousTableBloc>(),
                ),
                BlocProvider<ConnectionCubit>(
                  create: (context) => sl.get<ConnectionCubit>(),
                ),
                BlocProvider<SettingsCubit>(
                  create: (context) => sl.get<SettingsCubit>(),
                ),
                BlocProvider<LocalNotificationsBloc>(
                  create: (context) => sl.get<LocalNotificationsBloc>()
                    ..add(
                      LocalNotificationsInitialise(),
                    ),
                ),
              ],
              child: const AppWidget(),
            ),
          ),
        )
        ..scheduleWarmUpFrame();

      /// I think, this thing must be
      /// used a lot often.
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
