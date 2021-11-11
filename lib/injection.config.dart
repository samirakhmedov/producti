// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i11;
import 'package:connectivity/connectivity.dart' as _i19;
import 'package:firebase_analytics/firebase_analytics.dart' as _i22;
import 'package:firebase_auth/firebase_auth.dart' as _i17;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i23;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i6;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i16;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth/logic/auth_bloc.dart' as _i21;
import 'application/core/app_module.dart' as _i26;
import 'application/core/cubit/connection_cubit.dart' as _i18;
import 'application/launch/logic/launch_bloc.dart' as _i24;
import 'application/notifications/notifications_bloc.dart' as _i25;
import 'application/settings/settings_cubit.dart' as _i12;
import 'application/tables/logic/anonymous/anonymous_table_bloc.dart' as _i13;
import 'application/tables/logic/user/table_bloc.dart' as _i20;
import 'data/auth/auth_repository_impl.dart' as _i15;
import 'data/notifications/local_notification_repository.dart' as _i5;
import 'data/table/local_table_repository.dart' as _i8;
import 'data/table/remote_table_repository_impl.dart' as _i10;
import 'domain/auth/auth_repository.dart' as _i14;
import 'domain/table/local_table_repository.dart' as _i7;
import 'domain/table/remote_table_repository.dart' as _i9;
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
  gh.lazySingleton<_i5.LocalNotificationRepository>(() =>
      _i5.LocalNotificationRepository(
          get<_i6.FlutterLocalNotificationsPlugin>(),
          get<_i6.IOSFlutterLocalNotificationsPlugin>()));
  gh.factory<_i7.LocalTableRepository>(() => _i8.LocalTableRepositoryImpl(
      get<_i3.Box<_i4.Table>>(), get<_i3.Box<List<String>>>()));
  gh.factory<_i9.RemoteTableRepository>(
      () => _i10.RemoteTableRepositoryImpl(get<_i11.FirebaseFirestore>()));
  gh.lazySingleton<_i12.SettingsCubit>(() => _i12.SettingsCubit());
  gh.lazySingleton<_i13.AnonymousTableBloc>(
      () => _i13.AnonymousTableBloc(get<_i7.LocalTableRepository>()));
  gh.lazySingleton<_i14.AuthRepository>(() => _i15.AuthRepositoryImpl(
      get<_i16.FlutterSecureStorage>(), get<_i17.FirebaseAuth>()));
  gh.lazySingleton<_i18.ConnectionCubit>(
      () => _i18.ConnectionCubit(get<_i19.Connectivity>()));
  gh.lazySingleton<_i20.TableBloc>(() => _i20.TableBloc(
      get<_i9.RemoteTableRepository>(),
      get<_i7.LocalTableRepository>(),
      get<_i18.ConnectionCubit>()));
  gh.lazySingleton<_i21.AuthBloc>(() =>
      _i21.AuthBloc(get<_i14.AuthRepository>(), get<_i18.ConnectionCubit>()));
  gh.singleton<_i19.Connectivity>(appModule.connectivity);
  gh.singleton<_i22.FirebaseAnalytics>(appModule.analytics);
  gh.singleton<_i17.FirebaseAuth>(appModule.authentication);
  gh.singleton<_i23.FirebaseCrashlytics>(appModule.crashlytics);
  gh.singleton<_i11.FirebaseFirestore>(appModule.store);
  gh.singleton<_i6.FlutterLocalNotificationsPlugin>(
      appModule.localNotifications);
  gh.singleton<_i16.FlutterSecureStorage>(appModule.secureStorage);
  gh.singleton<_i6.IOSFlutterLocalNotificationsPlugin>(
      appModule.localNotificationsIOS);
  gh.singleton<_i24.LaunchBloc>(_i24.LaunchBloc());
  gh.singleton<_i25.LocalNotificationsBloc>(
      _i25.LocalNotificationsBloc(get<_i5.LocalNotificationRepository>()));
  return get;
}

class _$AppModule extends _i26.AppModule {}
