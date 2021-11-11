import 'package:dartz/dartz.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/data/core/error/failure.dart';
import 'package:producti/domain/core/value_object.dart';
import 'package:producti/domain/table/cells/table_cell.dart';

class CheckTile extends ValueObject<String> {
  final bool? initialValue;

  const CheckTile(String value, this.initialValue) : super(value);

  @override
  Either<Failure, String> get validatedValue => _validateLink(currentValue);

  CheckListTableCell toCell() => CheckListTableCell(title: currentValue);
}

Either<Failure, String> _validateLink(String link) {
  if (link.isEmpty) return left(const ValidationFailure(ErrorCode.voidValue));

  return right(link);
}
