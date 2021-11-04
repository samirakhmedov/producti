// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i12;
import 'package:connectivity/connectivity.dart' as _i20;
import 'package:firebase_analytics/firebase_analytics.dart' as _i23;
import 'package:firebase_auth/firebase_auth.dart' as _i18;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i24;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i17;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth/logic/auth_bloc.dart' as _i22;
import 'application/core/app_module.dart' as _i26;
import 'application/core/cubit/connection_cubit.dart' as _i19;
import 'application/launch/logic/launch_bloc.dart' as _i5;
import 'application/notifications/notifications_bloc.dart' as _i25;
import 'application/settings/settings_cubit.dart' as _i13;
import 'application/tables/logic/anonymous/anonymous_table_bloc.dart' as _i14;
import 'application/tables/logic/user/table_bloc.dart' as _i21;
import 'data/auth/auth_repository_impl.dart' as _i16;
import 'data/notifications/local_notification_repository.dart' as _i6;
import 'data/table/local_table_repository.dart' as _i9;
import 'data/table/remote_table_repository_impl.dart' as _i11;
import 'domain/auth/auth_repository.dart' as _i15;
import 'domain/table/local_table_repository.dart' as _i8;
import 'domain/table/remote_table_repository.dart' as _i10;
import 'domain/table/table.dart' as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> initDependecies(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  await gh.factoryAsync<_i3.Box<_i4.Table>>(() => appModule.tablesBox,
      preResolve: true);
  await gh.factoryAsync<_i3.Box<List<String>>>(() => appModule.constantsBox,
      preResolve: true);
  gh.factory<_i5.LaunchBloc>(() => _i5.LaunchBloc());
  gh.lazySingleton<_i6.LocalNotificationRepository>(() =>
      _i6.LocalNotificationRepository(
          get<_i7.FlutterLocalNotificationsPlugin>(),
          get<_i7.IOSFlutterLocalNotificationsPlugin>()));
  gh.factory<_i8.LocalTableRepository>(() => _i9.LocalTableRepositoryImpl(
      get<_i3.Box<_i4.Table>>(), get<_i3.Box<List<String>>>()));
  gh.factory<_i10.RemoteTableRepository>(
      () => _i11.RemoteTableRepositoryImpl(get<_i12.FirebaseFirestore>()));
  gh.lazySingleton<_i13.SettingsCubit>(() => _i13.SettingsCubit());
  gh.lazySingleton<_i14.AnonymousTableBloc>(
      () => _i14.AnonymousTableBloc(get<_i8.LocalTableRepository>()));
  gh.lazySingleton<_i15.AuthRepository>(() => _i16.AuthRepositoryImpl(
      get<_i17.FlutterSecureStorage>(), get<_i18.FirebaseAuth>()));
  gh.lazySingleton<_i19.ConnectionCubit>(
      () => _i19.ConnectionCubit(get<_i20.Connectivity>()));
  gh.lazySingleton<_i21.TableBloc>(() => _i21.TableBloc(
      get<_i10.RemoteTableRepository>(),
      get<_i8.LocalTableRepository>(),
      get<_i19.ConnectionCubit>()));
  gh.lazySingleton<_i22.AuthBloc>(() =>
      _i22.AuthBloc(get<_i15.AuthRepository>(), get<_i19.ConnectionCubit>()));
  gh.singleton<_i20.Connectivity>(appModule.connectivity);
  gh.singleton<_i23.FirebaseAnalytics>(appModule.analytics);
  gh.singleton<_i18.FirebaseAuth>(appModule.authentication);
  gh.singleton<_i24.FirebaseCrashlytics>(appModule.crashlytics);
  gh.singleton<_i12.FirebaseFirestore>(appModule.store);
  gh.singleton<_i7.FlutterLocalNotificationsPlugin>(
      appModule.localNotifications);
  gh.singleton<_i17.FlutterSecureStorage>(appModule.secureStorage);
  gh.singleton<_i7.IOSFlutterLocalNotificationsPlugin>(
      appModule.localNotificationsIOS);
  gh.singleton<_i25.LocalNotificationsBloc>(
      _i25.LocalNotificationsBloc(get<_i6.LocalNotificationRepository>()));
  return get;
}

class _$AppModule extends _i26.AppModule {}
