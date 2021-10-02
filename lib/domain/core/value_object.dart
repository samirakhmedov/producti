import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:producti/data/core/error/failure.dart';

abstract class ValueObject<T> extends Equatable {
  final T _value;

  const ValueObject(this._value);

  @protected
  T get currentValue => _value;

  Either<Failure, T> get validatedValue;

  T getOrCrash() => validatedValue.fold(
        (_) => throw Error.safeToString('Unexpected failure value!'),
        (value) => value,
      );

  @override
  List<Object?> get props => [_value];
}
