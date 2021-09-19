import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:producti/application/auth/getx/auth_page_controller.dart';
import 'package:producti/domain/auth/values/email.dart';
import 'package:producti/domain/auth/values/password.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/auth/widgets/password_text_field.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:producti/presentation/core/errors/error_code_ext.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final intl = S.of(context);

    final authController = Get.find<AuthPageController>();

    final _email = TextEditingController();
    final _password = TextEditingController();
    final _repeatPassword = TextEditingController();

    _email.addListener(() {
      authController.email = Email(_email.text);
    });

    _password.addListener(() {
      authController.password = Password(_password.text);
    });

    _repeatPassword.addListener(() {
      authController.passwordRepeat = Password(_repeatPassword.text);
    });

    return Column(
      children: [
        Text(
          intl.funBegins,
          style: textTheme.subtitle1,
        ),
        const Gap(size: 12),
        Text(
          intl.signUp,
          style: textTheme.headline3,
        ),
        const Gap(size: 14),
        Obx(
          () => TextInputWidget(
            prefixIcon: Icons.email,
            hintText: intl.email,
            controller: _email,
            errorText: authController.enableValidation
                ? authController.email.validatedValue.fold(
                    (failure) => failure.messageCode.translate(context),
                    (r) => null,
                  )
                : null,
          ),
        ),
        const Gap(size: 14),
        Obx(
          () => PasswordTextField(
            controller: _password,
            hintText: intl.password,
            errorText: authController.enableValidation
                ? authController.password.validatedValue.fold(
                    (failure) => failure.messageCode.translate(context),
                    (r) => null,
                  )
                : null,
          ),
        ),
        const Gap(size: 14),
        Obx(
          () => PasswordTextField(
            controller: _repeatPassword,
            hintText: intl.repeatPassword,
            errorText: authController.enableValidation
                ? authController.passwordRepeat.validatedValue.fold(
                    (failure) => failure.messageCode.translate(context),
                    (r) => null,
                  )
                : null,
          ),
        ),
        const Gap(size: 14),
        OptionText(
          start: intl.alreadyCoolGuy,
          end: ' ${intl.letHim}',
          onTap: () => authController.page = !authController.page,
        ),
        const Gap(size: 6),
        OptionText(
          start: intl.hatePeople,
          end: ' ${intl.signInAnonim}',
          onTap: () {},
        ),
      ],
    );
  }
}
