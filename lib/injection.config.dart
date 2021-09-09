// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_analytics/firebase_analytics.dart' as _i3;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i5;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/core/app_module.dart' as _i11;
import 'application/launch/bloc/launch_bloc.dart' as _i8;
import 'data/auth/auth_repository_impl.dart' as _i10;
import 'domain/auth/auth_repository.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt initDependecies(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseModule = _$FirebaseModule();
  gh.factory<_i3.FirebaseAnalytics>(() => firebaseModule.analytics);
  gh.factory<_i4.FirebaseAuth>(() => firebaseModule.authentication);
  gh.factory<_i5.FirebaseCrashlytics>(() => firebaseModule.crashlytics);
  gh.factory<_i6.FirebaseFirestore>(() => firebaseModule.store);
  gh.factory<_i7.FlutterSecureStorage>(() => firebaseModule.secureStorage);
  gh.factory<_i8.LaunchBloc>(() => _i8.LaunchBloc());
  gh.factory<_i9.AuthRepository>(() => _i10.AuthRepositoryImpl(
      get<_i7.FlutterSecureStorage>(), get<_i4.FirebaseAuth>()));
  return get;
}

class _$FirebaseModule extends _i11.FirebaseModule {}
