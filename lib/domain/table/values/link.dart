import 'package:producti/application/core/error/error_codes.dart';
import 'package:producti/application/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:producti/domain/core/value_object.dart';
import 'package:producti/presentation/core/constants/constants.dart';

class Link extends ValueObject<String> {
  Link(String value) : super(value);

  @override
  Either<Failure, String> get validatedValue => throw UnimplementedError();
}

Either<Failure, String> _validateLink(String link) {
  if (kLinkRegexp.hasMatch(link)) return right(link);

  if (link.isEmpty) return left(ValidationFailure(ErrorCode.voidValue));

  return left(ValidationFailure(ErrorCode.invalidLink));
}
