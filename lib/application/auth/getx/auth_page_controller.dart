import 'package:get/get.dart';
import 'package:producti/domain/auth/values/email.dart';
import 'package:producti/domain/auth/values/password.dart';

class AuthPageController extends GetxController {
  final _page = RxBool(true);

  bool get page => _page.value;

  set page(bool newValue) {
    _page.value = newValue;

    refreshState();
  }

  void refreshState() {
    _enableValidation.value = false;
    _email.value = Email('');
    _password.value = Password('');
    _passwordRepeat.value = Password('');
  }

  bool isValid() {
    final email = _email.value.validatedValue;
    final password = _password.value.validatedValue;
    final repeatPassword = _passwordRepeat.value.validatedValue;

    bool? additional;

    if (!_page.value) {
      additional = repeatPassword.isRight();
    }

    additional ??= true;

    return email.isRight() && password.isRight() && additional;
  }

  final _enableValidation = RxBool(false);

  bool get enableValidation => _enableValidation.value;

  set enableValidation(bool newValue) => _enableValidation.value = newValue;

  final _email = Rx<Email>(Email(''));

  Email get email => _email.value;

  set email(Email newValue) {
    _email.value = newValue;

    _enableValidation.value = false;
  }

  final _password = Rx<Password>(Password(''));

  Password get password => _password.value;

  set password(Password newValue) {
    _password.value = newValue;

    _enableValidation.value = false;
  }

  final _passwordRepeat = Rx<Password>(Password(''));

  Password get passwordRepeat => _passwordRepeat.value;

  set passwordRepeat(Password newValue) {
    _passwordRepeat.value = newValue;

    _enableValidation.value = false;
  }
}
