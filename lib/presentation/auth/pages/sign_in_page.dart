import 'package:flutter/material.dart';
import 'package:producti/application/auth/pages/auth_page_cubit.dart';
import 'package:producti/domain/auth/values/email.dart';
import 'package:producti/domain/auth/values/password.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/auth/widgets/password_text_field.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:producti/presentation/core/errors/error_code_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final intl = S.of(context);

    final cubit = context.read<AuthPageCubit>();

    final _email = TextEditingController();
    final _password = TextEditingController();

    _email.addListener(() {
      cubit.mutate(
        email: Email(_email.text),
      );
    });

    _password.addListener(() {
      cubit.mutate(
        password: Password(_password.text),
      );
    });

    return Column(
      children: [
        Text(
          intl.funContinues,
          style: textTheme.subtitle1,
        ),
        const Gap(size: 12),
        Text(
          intl.signIn,
          style: textTheme.headline3,
        ),
        const Gap(size: 14),
        BlocBuilder<AuthPageCubit, AuthPageState>(
          buildWhen: (previous, current) =>
              previous.enableValidation != current.enableValidation,
          builder: (context, state) => TextInputWidget(
            prefixIcon: Icons.email,
            hintText: intl.email,
            controller: _email,
            errorText: state.enableValidation
                ? state.email.validatedValue.fold(
                    (failure) => failure.messageCode.translate(context),
                    (r) => null,
                  )
                : null,
          ),
        ),
        const Gap(size: 14),
        BlocBuilder<AuthPageCubit, AuthPageState>(
          buildWhen: (previous, current) =>
              previous.enableValidation != current.enableValidation,
          builder: (context, state) => PasswordTextField(
            controller: _password,
            hintText: intl.password,
            errorText: state.enableValidation
                ? state.password.validatedValue.fold(
                    (failure) => failure.messageCode.translate(context),
                    (r) => null,
                  )
                : null,
          ),
        ),
        const Gap(size: 14),
        OptionText(
          start: intl.notPartOfParty,
          end: ' ${intl.join}',
          onTap: () => cubit.togglePage(),
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
