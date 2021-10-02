import 'package:flutter/material.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
import 'package:producti/application/auth/pages/auth_page_cubit.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/auth/pages/sign_in_page.dart';
import 'package:producti/presentation/auth/pages/sign_up_page.dart';
import 'package:producti/presentation/core/constants/constants.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti/presentation/core/widgets/connection/connectivity_listener.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/presentation/core/errors/error_code_ext.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = AuthPageCubit();

    final intl = S.of(context);

    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    return BlocProvider<AuthPageCubit>.value(
      value: cubit,
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40)
              .copyWith(bottom: 25, top: 25),
          child: ConnectivityListener(
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthAnonymousState) {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.launch);
                }
                if (state is AuthLoggedIn) {
                  final navigator = Navigator.of(context);

                  navigator.pop();

                  cubit.close();

                  navigator.pushReplacementNamed(AppRoutes.launch);
                } else if (state is AuthErrorState) {
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kRed,
                      content: Text(
                        state.failure.messageCode.translate(context),
                        style: textTheme.caption!.copyWith(
                          color: theme.backgroundColor,
                        ),
                      ),
                    ),
                  );
                }
              },
              child: LongButton(
                onTap: () {
                  final valid = cubit.state.isValid;

                  if (!valid) {
                    return cubit.mutate(enableValidation: true);
                  }

                  final currentState = cubit.state;

                  showDialog(
                    context: context,
                    builder: (context) => WillPopScope(
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      onWillPop: () => Future.value(false),
                    ),
                  );

                  context.read<AuthBloc>().add(
                        currentState.page
                            ? AuthSignIn(
                                currentState.email,
                                currentState.password,
                              )
                            : AuthSignUp(
                                currentState.email,
                                currentState.password,
                                currentState.repeatPassword,
                              ),
                      );
                },
                text: intl.signInLongButtonText,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                const Gap(size: 16),
                Align(
                  child: Text(
                    kAppName,
                    style: textTheme.headline1!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                BlocBuilder<AuthPageCubit, AuthPageState>(
                  buildWhen: (previous, current) =>
                      previous.page != current.page,
                  builder: (context, state) =>
                      state.page ? SignInPage() : SignUpPage(),
                ),
                const Gap(size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
