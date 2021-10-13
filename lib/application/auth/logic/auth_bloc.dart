import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:producti/application/core/cubit/connection_cubit.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/data/core/error/failure.dart';
import 'package:producti/domain/auth/auth_repository.dart';
import 'package:producti/domain/auth/user.dart';
import 'package:producti/domain/auth/values/email.dart';
import 'package:producti/domain/auth/values/password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final ConnectionCubit _connection;

  AuthBloc(this._authRepository, this._connection) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (!_connection.connected &&
        (event is AuthSignIn || event is AuthSignUp)) {
      yield AuthErrorState(ConnectionFailure(ErrorCode.notConnectedToInternet));

      return;
    }

    if (event is AuthSignOut) {
      yield AuthInitial();
    }

    if (event is AuthSignIn) {
      yield AuthLoadingState();

      final result = await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );

      yield result.fold(
        (failure) => AuthErrorState(failure),
        (user) => AuthLoggedIn(user),
      );
    } else if (event is AuthAnonymousEvent)
      yield AuthAnonymousState();
    else if (event is AuthSignUp) {
      final password = event.password.getOrCrash();
      final repeatPassword = event.repeatPassword.getOrCrash();

      if (password == repeatPassword) {
        yield AuthLoadingState();

        final result = await _authRepository.register(
          email: event.email,
          password: event.password,
        );

        yield result.fold(
          (failure) => AuthErrorState(failure),
          (user) => AuthLoggedIn(user),
        );
      } else {
        yield AuthErrorState(
          ValidationFailure(
            ErrorCode.passwordsNotMatch,
          ),
        );
      }
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
