import 'package:equatable/equatable.dart';

import 'error_codes.dart';

abstract class Failure extends Equatable {
  final ErrorCode messageCode;

  const Failure(this.messageCode);

  @override
  List<Object?> get props => [messageCode];
}

class AuthFailure extends Failure {
  const AuthFailure(ErrorCode messageCode) : super(messageCode);
}

class TableFailure extends Failure {
  const TableFailure(ErrorCode messageCode) : super(messageCode);
}

class ValidationFailure extends Failure {
  const ValidationFailure(ErrorCode messageCode) : super(messageCode);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(ErrorCode messageCode) : super(messageCode);
}
