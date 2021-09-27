import 'package:dartz/dartz.dart';
import 'package:producti/application/core/error/failure.dart';
import 'package:producti/domain/core/value_object.dart';
import 'package:producti/application/core/error/error_codes.dart';
import 'package:producti/presentation/core/constants/regular_expressions.dart';

class Email extends ValueObject<String> {
  const Email(String value) : super(value);

  @override
  Either<Failure, String> get validatedValue => _validateEmail(currentValue);
}

Either<Failure, String> _validateEmail(String email) {
  if (kEmailRegexp.hasMatch(email)) return right(email);

  if (email.isEmpty) return left(ValidationFailure(ErrorCode.voidValue));

  return left(ValidationFailure(ErrorCode.invalidEmail));
}
