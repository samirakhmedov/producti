import 'package:dartz/dartz.dart';
import 'package:producti/application/core/error/failure.dart';
import 'package:producti/domain/core/value_object.dart';
import 'package:producti/presentation/core/constants/constants.dart';
import 'package:producti/application/core/error/error_codes.dart';

class Email extends ValueObject<String> {
  const Email(String value) : super(value);

  @override
  Either<Failure, String> get validatedValue => _validateEmail(currentValue);
}

Either<Failure, String> _validateEmail(String email) {
  if (kEmailRegexp.hasMatch(email)) return right(email);

  return left(ValidationFailure(ErrorCode.invalidEmail));
}
