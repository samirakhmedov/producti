import 'package:dartz/dartz.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/data/core/error/failure.dart';
import 'package:producti/domain/core/value_object.dart';

class Password extends ValueObject<String> {
  const Password(String value) : super(value);

  @override
  Either<Failure, String> get validatedValue => _validatePassword(currentValue);
}

Either<Failure, String> _validatePassword(String password) {
  if (password.length > 9) return right(password);

  if (password.isEmpty) return left(ValidationFailure(ErrorCode.voidValue));

  return left(ValidationFailure(ErrorCode.invalidPassword));
}
