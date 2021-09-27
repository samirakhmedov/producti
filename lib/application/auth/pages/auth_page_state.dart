part of 'auth_page_cubit.dart';

class AuthPageState extends Equatable {
  final bool page;
  final bool enableValidation;
  final Email email;
  final Password password;
  final Password repeatPassword;

  const AuthPageState({
    this.page = true,
    this.enableValidation = false,
    this.email = const Email(''),
    this.password = const Password(''),
    this.repeatPassword = const Password(''),
  });

  @override
  List<Object> get props => [
        page,
        enableValidation,
        email,
        password,
        repeatPassword,
      ];

  AuthPageState copyWith({
    bool? page,
    bool? enableValidation,
    Email? email,
    Password? password,
    Password? repeatPassword,
  }) {
    return AuthPageState(
      page: page ?? this.page,
      enableValidation: enableValidation ?? this.enableValidation,
      email: email ?? this.email,
      password: password ?? this.password,
      repeatPassword: repeatPassword ?? this.repeatPassword,
    );
  }

  bool get isValid {
    final email = this.email.validatedValue;
    final password = this.password.validatedValue;
    final repeatPassword = this.repeatPassword.validatedValue;

    bool? additional;

    if (!page) {
      additional = repeatPassword.isRight();
    }

    additional ??= true;

    return email.isRight() && password.isRight() && additional;
  }

  @override
  String toString() =>
      'AuthPageState(email: ${email.validatedValue}, password: ${password.validatedValue}, repeat: ${repeatPassword.validatedValue}, enableValidation: $enableValidation, page: $page)';
}
