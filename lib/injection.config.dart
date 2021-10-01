// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i7;
import 'package:connectivity/connectivity.dart' as _i3;
import 'package:firebase_analytics/firebase_analytics.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i6;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth/logic/auth_bloc.dart' as _i13;
import 'application/core/app_module.dart' as _i14;
import 'application/core/cubit/connection_cubit.dart' as _i12;
import 'application/launch/logic/launch_bloc.dart' as _i9;
import 'data/auth/auth_repository_impl.dart' as _i11;
import 'domain/auth/auth_repository.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt initDependecies(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseModule = _$FirebaseModule();
  gh.factory<_i3.Connectivity>(() => firebaseModule.connectivity);
  gh.factory<_i4.FirebaseAnalytics>(() => firebaseModule.analytics);
  gh.factory<_i5.FirebaseAuth>(() => firebaseModule.authentication);
  gh.factory<_i6.FirebaseCrashlytics>(() => firebaseModule.crashlytics);
  gh.factory<_i7.FirebaseFirestore>(() => firebaseModule.store);
  gh.factory<_i8.FlutterSecureStorage>(() => firebaseModule.secureStorage);
  gh.factory<_i9.LaunchBloc>(() => _i9.LaunchBloc());
  gh.factory<_i10.AuthRepository>(() => _i11.AuthRepositoryImpl(
      get<_i8.FlutterSecureStorage>(), get<_i5.FirebaseAuth>()));
  gh.factory<_i12.ConnectionCubit>(
      () => _i12.ConnectionCubit(get<_i3.Connectivity>()));
  gh.factory<_i13.AuthBloc>(() => _i13.AuthBloc(get<_i10.AuthRepository>()));
  return get;
}

class _$FirebaseModule extends _i14.FirebaseModule {}
