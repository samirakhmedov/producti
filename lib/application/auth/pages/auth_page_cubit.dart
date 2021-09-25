import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:producti/domain/auth/values/email.dart';
import 'package:producti/domain/auth/values/password.dart';

part 'auth_page_state.dart';

class AuthPageCubit extends Cubit<AuthPageState> {
  AuthPageCubit() : super(AuthPageState());

  void _refreshState() => emit(
        state.copyWith(
          enableValidation: false,
          email: const Email(''),
          password: const Password(''),
          repeatPassword: const Password(''),
        ),
      );

  void togglePage() {
    _refreshState();

    emit(
      AuthPageState(
        page: !state.page,
      ),
    );
  }

  void mutate({
    Email? email,
    Password? password,
    Password? repeatPassword,
    bool? enableValidation,
  }) =>
      emit(
        state.copyWith(
          email: email,
          password: password,
          repeatPassword: repeatPassword,
          enableValidation: enableValidation != null ? enableValidation : false,
        ),
      );
}
