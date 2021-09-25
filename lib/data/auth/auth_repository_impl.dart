import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:producti/application/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:producti/domain/auth/auth_repository.dart';
import 'package:producti/domain/auth/values/password.dart';
import 'package:producti/domain/auth/values/email.dart';
import 'package:producti/domain/auth/user.dart';
import 'package:producti/data/core/extensions/firebase_user_ext.dart';
import 'package:producti/application/core/error/error_codes.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final FlutterSecureStorage _storage;
  final auth.FirebaseAuth _auth;

  AuthRepositoryImpl(this._storage, this._auth);

  String _getPasswordKey(String uid) => 'USER_PASSWORD_$uid';

  Future<void> _savePassword(String uid, String password) async {
    final key = _getPasswordKey(uid);

    await _storage.write(key: key, value: password);
  }

  Future<String> _getPassword(String uid) async {
    final key = _getPasswordKey(uid);

    return _storage.read(key: key) as Future<String>;
  }

  @override
  Future<Either<Failure, User>> register({
    required Email email,
    required Password password,
  }) async {
    final emailStr = email.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );

      _savePassword(result.user!.uid, passwordStr);

      return right(result.user!.toDomain());
    } on auth.FirebaseAuthException catch (e) {
      late ErrorCode messageCode;

      switch (e.code) {
        case 'email-already-in-use':
          messageCode = ErrorCode.emailAlreadyInUse;
          break;
      }

      return left(AuthFailure(messageCode));
    }
  }

  @override
  Future<Either<Failure, User>> signIn({
    required Email email,
    required Password password,
  }) async {
    final emailStr = email.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );

      _savePassword(result.user!.uid, passwordStr);

      return right(result.user!.toDomain());
    } on auth.FirebaseAuthException catch (e) {
      late ErrorCode messageCode;

      switch (e.code) {
        case 'user-disabled':
          messageCode = ErrorCode.userRemoved;
          break;
        case 'user-not-found':
          messageCode = ErrorCode.userNotExists;
          break;
        case 'wrong-password':
          messageCode = ErrorCode.wrongPassword;
      }

      return left(AuthFailure(messageCode));
    }
  }
}