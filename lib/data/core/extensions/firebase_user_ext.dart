import 'package:firebase_auth/firebase_auth.dart';
import 'package:producti/domain/auth/user.dart' as c;

extension FirebaseUserExt on User {
  c.User toDomain() {
    return c.User(
      email: email!,
      id: uid,
    );
  }
}
