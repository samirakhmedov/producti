import 'package:dartz/dartz.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/data/core/error/failure.dart';
import 'package:producti/domain/core/value_object.dart';
import 'package:producti/presentation/core/constants/regular_expressions.dart';

class Link extends ValueObject<String> {
  Link(String value) : super(value);

  @override
  Either<Failure, String> get validatedValue => _validateLink(currentValue);
}

Either<Failure, String> _validateLink(String link) {
  if (kLinkRegexp.hasMatch(link)) return right(link);

  if (link.isEmpty) return left(ValidationFailure(ErrorCode.voidValue));

  return left(ValidationFailure(ErrorCode.invalidLink));
}
