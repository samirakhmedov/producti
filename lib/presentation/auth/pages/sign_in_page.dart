import 'package:flutter/material.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
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
    final textTheme = ThemeHelper.getTextTheme(context);

    final intl = S.of(context);

    final cubit = context.read<AuthPageCubit>();

    final auth = context.read<AuthBloc>();

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
        TextInputWidget(
          prefixIcon: Icons.email,
          hintText: intl.email,
          controller: _email,
        ),
        const Gap(size: 7),
        BlocBuilder<AuthPageCubit, AuthPageState>(
          buildWhen: (previous, current) =>
              previous.password == current.password,
          builder: (context, state) {
            return state.enableValidation
                ? state.email.validatedValue.fold(
                    (failure) => Align(
                      alignment: Alignment.centerLeft,
                      child: FieldErrorIndicator(
                        message: failure.messageCode.translate(context),
                      ),
                    ),
                    (r) => const SizedBox(),
                  )
                : const SizedBox();
          },
        ),
        const Gap(size: 14),
        PasswordTextField(
          controller: _password,
          hintText: intl.password,
        ),
        const Gap(size: 7),
        BlocBuilder<AuthPageCubit, AuthPageState>(
          buildWhen: (previous, current) => previous.email == current.email,
          builder: (context, state) {
            return state.enableValidation
                ? state.password.validatedValue.fold(
                    (failure) => Align(
                      alignment: Alignment.centerLeft,
                      child: FieldErrorIndicator(
                        message: failure.messageCode.translate(context),
                      ),
                    ),
                    (r) => const SizedBox(),
                  )
                : const SizedBox();
          },
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
          onTap: () {
            auth.add(AuthAnonymousEvent());
          },
        ),
      ],
    );
  }
}
