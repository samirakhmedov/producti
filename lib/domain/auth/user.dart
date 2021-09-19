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

  Map<String, dynamic> toJson() => {
        'email': email,
        'id': id,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'] as String,
        id: json['id'] as String,
      );
}
