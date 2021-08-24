// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_analytics/firebase_analytics.dart' as _i3;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/core/firebase_module.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

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
  return get;
}

class _$FirebaseModule extends _i7.FirebaseModule {}
