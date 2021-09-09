import 'package:dartz/dartz.dart';
import 'package:producti/application/core/error/error_codes.dart';
import 'package:producti/application/core/error/failure.dart';
import 'package:producti/domain/core/value_object.dart';

class Password extends ValueObject<String> {
  Password(String value) : super(value);

  @override
  Either<Failure, String> get validatedValue => _validatePassword(currentValue);
}

Either<Failure, String> _validatePassword(String password) {
  if (password.length > 9) return right(password);

  return left(ValidationFailure(ErrorCode.invalidPassword));
}
