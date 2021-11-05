import 'package:flutter/material.dart';
import 'package:producti/application/auth/logic/auth_bloc.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotSignedInDrawerHeader extends StatelessWidget {
  const NotSignedInDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final size = query.size;

    final intl = S.of(context);

    final theme = ThemeHelper.getTheme(context);

    return Container(
      height: size.height * 0.13,
      width: double.maxFinite,
      color: theme.backgroundColor,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const UserAvatar(),
              const Gap(),
              Expanded(
                child: OptionText(
                  textAlign: TextAlign.left,
                  start: intl.doNotLoggedIn + ' ',
                  end: intl.createAccount,
                  onTap: () {
                    final authBloc = context.read<AuthBloc>();

                    authBloc.add(AuthSignOut());

                    final navigator = Navigator.of(context);

                    navigator.pushNamedAndRemoveUntil(
                      AppRoutes.auth,
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
