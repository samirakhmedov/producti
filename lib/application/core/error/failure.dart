import 'package:equatable/equatable.dart';
import 'package:producti/application/core/error/error_codes.dart';

abstract class Failure extends Equatable {
  final ErrorCode messageCode;

  const Failure(this.messageCode);
}

class AuthFailure extends Failure {
  const AuthFailure(ErrorCode messageCode) : super(messageCode);

  @override
  List<Object?> get props => [messageCode];
}

class ValidationFailure extends Failure {
  const ValidationFailure(ErrorCode messageCode) : super(messageCode);

  @override
  List<Object?> get props => [messageCode];
}
