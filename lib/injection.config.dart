// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i10;
import 'package:connectivity/connectivity.dart' as _i17;
import 'package:firebase_analytics/firebase_analytics.dart' as _i20;
import 'package:firebase_auth/firebase_auth.dart' as _i15;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i21;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i14;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth/logic/auth_bloc.dart' as _i19;
import 'application/core/app_module.dart' as _i22;
import 'application/core/cubit/connection_cubit.dart' as _i16;
import 'application/launch/logic/launch_bloc.dart' as _i5;
import 'application/tables/logic/anonymous/anonymous_table_bloc.dart' as _i11;
import 'application/tables/logic/user/table_bloc.dart' as _i18;
import 'data/auth/auth_repository_impl.dart' as _i13;
import 'data/table/local_table_repository.dart' as _i7;
import 'data/table/remote_table_repository_impl.dart' as _i9;
import 'domain/auth/auth_repository.dart' as _i12;
import 'domain/table/local_table_repository.dart' as _i6;
import 'domain/table/remote_table_repository.dart' as _i8;
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
  gh.factory<_i6.LocalTableRepository>(() => _i7.LocalTableRepositoryImpl(
      get<_i3.Box<_i4.Table>>(), get<_i3.Box<List<String>>>()));
  gh.factory<_i8.RemoteTableRepository>(
      () => _i9.RemoteTableRepositoryImpl(get<_i10.FirebaseFirestore>()));
  gh.factory<_i11.AnonymousTableBloc>(
      () => _i11.AnonymousTableBloc(get<_i6.LocalTableRepository>()));
  gh.factory<_i12.AuthRepository>(() => _i13.AuthRepositoryImpl(
      get<_i14.FlutterSecureStorage>(), get<_i15.FirebaseAuth>()));
  gh.lazySingleton<_i16.ConnectionCubit>(
      () => _i16.ConnectionCubit(get<_i17.Connectivity>()));
  gh.factory<_i18.TableBloc>(() => _i18.TableBloc(
      get<_i8.RemoteTableRepository>(),
      get<_i6.LocalTableRepository>(),
      get<_i16.ConnectionCubit>()));
  gh.lazySingleton<_i19.AuthBloc>(() =>
      _i19.AuthBloc(get<_i12.AuthRepository>(), get<_i16.ConnectionCubit>()));
  gh.singleton<_i17.Connectivity>(appModule.connectivity);
  gh.singleton<_i20.FirebaseAnalytics>(appModule.analytics);
  gh.singleton<_i15.FirebaseAuth>(appModule.authentication);
  gh.singleton<_i21.FirebaseCrashlytics>(appModule.crashlytics);
  gh.singleton<_i10.FirebaseFirestore>(appModule.store);
  gh.singleton<_i14.FlutterSecureStorage>(appModule.secureStorage);
  return get;
}

class _$AppModule extends _i22.AppModule {}
