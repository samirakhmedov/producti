import 'package:flutter/material.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/core/constants/constants.dart';
import 'package:producti_ui/producti_ui.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final intl = S.of(context);

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(
          bottom: 25,
        ),
        child: LongButton(
          onTap: () {},
          text: intl.signInLongButtonText,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
              ),
              const Gap(size: 16),
              Text(
                kAppName,
                style: textTheme.headline1!.copyWith(
                  color: theme.primaryColor,
                ),
              ),
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
              ),
              const Gap(size: 14),
              TextInputWidget(
                prefixIcon: Icons.vpn_key,
                hintText: intl.password,
              ),
              const Gap(size: 14),
              OptionText(
                start: 'wow ',
                end: 'WOW',
                onTap: () {},
              ),
              const Gap(size: 6),
              OptionText(
                start: 'wow ',
                end: 'WOW',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
