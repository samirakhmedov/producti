import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String id;

  const User({
    required this.email,
    required this.id,
  });

  @override
  List<Object?> get props => [email, id];
}
