import 'package:get/get.dart';
import 'package:producti/domain/auth/values/email.dart';
import 'package:producti/domain/auth/values/password.dart';

class SignInPageController extends GetxController {
  final _enableValidation = RxBool(false);

  bool get enableValidation => _enableValidation.value;

  set enableValidation(bool newValue) => _enableValidation.value = newValue;

  final _email = Rx<Email>(Email(''));

  Email get email => _email.value;

  set email(Email newValue) => _email.value = newValue;

  final _password = Rx<Password>(Password(''));

  Password get password => _password.value;

  set password(Password newValue) => _password.value = newValue;
}
