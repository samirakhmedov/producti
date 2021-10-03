part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignIn extends AuthEvent {
  final Email email;
  final Password password;

  AuthSignIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthSignUp extends AuthEvent {
  final Email email;
  final Password password;
  final Password repeatPassword;

  AuthSignUp(this.email, this.password, this.repeatPassword);

  @override
  List<Object> get props => [email, password, repeatPassword];
}

class AuthAnonymousEvent extends AuthEvent {}

class AuthSignOut extends AuthEvent {}
