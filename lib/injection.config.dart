// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i9;
import 'package:connectivity/connectivity.dart' as _i5;
import 'package:firebase_analytics/firebase_analytics.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i7;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i8;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth/logic/auth_bloc.dart' as _i21;
import 'application/core/app_module.dart' as _i22;
import 'application/core/cubit/connection_cubit.dart' as _i20;
import 'application/launch/logic/launch_bloc.dart' as _i11;
import 'application/tables/logic/anonymous/anonymous_table_bloc.dart' as _i17;
import 'application/tables/logic/user/table_bloc.dart' as _i16;
import 'data/auth/auth_repository_impl.dart' as _i19;
import 'data/table/local_table_repository.dart' as _i13;
import 'data/table/remote_table_repository_impl.dart' as _i15;
import 'domain/auth/auth_repository.dart' as _i18;
import 'domain/table/local_table_repository.dart' as _i12;
import 'domain/table/remote_table_repository.dart' as _i14;
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
  gh.factory<_i5.Connectivity>(() => appModule.connectivity);
  gh.factory<_i6.FirebaseAnalytics>(() => appModule.analytics);
  gh.factory<_i7.FirebaseAuth>(() => appModule.authentication);
  gh.factory<_i8.FirebaseCrashlytics>(() => appModule.crashlytics);
  gh.factory<_i9.FirebaseFirestore>(() => appModule.store);
  gh.factory<_i10.FlutterSecureStorage>(() => appModule.secureStorage);
  gh.factory<_i11.LaunchBloc>(() => _i11.LaunchBloc());
  gh.factory<_i12.LocalTableRepository>(() => _i13.LocalTableRepositoryImpl(
      get<_i3.Box<_i4.Table>>(), get<_i3.Box<List<String>>>()));
  gh.factory<_i14.RemoteTableRepository>(
      () => _i15.RemoteTableRepositoryImpl(get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i16.TableBloc>(() => _i16.TableBloc(
      get<_i14.RemoteTableRepository>(), get<_i12.LocalTableRepository>()));
  gh.lazySingleton<_i17.AnonymousTableBloc>(
      () => _i17.AnonymousTableBloc(get<_i12.LocalTableRepository>()));
  gh.factory<_i18.AuthRepository>(() => _i19.AuthRepositoryImpl(
      get<_i10.FlutterSecureStorage>(), get<_i7.FirebaseAuth>()));
  gh.factory<_i20.ConnectionCubit>(
      () => _i20.ConnectionCubit(get<_i5.Connectivity>()));
  gh.factory<_i21.AuthBloc>(() =>
      _i21.AuthBloc(get<_i18.AuthRepository>(), get<_i20.ConnectionCubit>()));
  return get;
}

class _$AppModule extends _i22.AppModule {}
