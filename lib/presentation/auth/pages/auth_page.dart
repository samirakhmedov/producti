import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:producti/application/auth/getx/auth_page_controller.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/auth/pages/sign_in_page.dart';
import 'package:producti/presentation/auth/pages/sign_up_page.dart';
import 'package:producti/presentation/core/constants/constants.dart';
import 'package:producti_ui/producti_ui.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authController = AuthPageController();

    Get.put<AuthPageController>(_authController);

    final intl = S.of(context);

    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(
          bottom: 25,
        ),
        child: LongButton(
          onTap: () {
            // Get.delete<AuthPageController>();
          },
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
              Obx(
                () {
                  return _authController.page ? SignInPage() : SignUpPage();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
