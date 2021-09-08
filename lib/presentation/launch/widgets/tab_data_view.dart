import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:producti/presentation/launch/pages/onboarding_page.dart';
import 'package:producti_ui/producti_ui.dart';

class TabDataView extends StatelessWidget {
  final TabData data;

  const TabDataView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Gap(
          size: size.height * .2,
        ),
        Text(
          data.title,
          style: textTheme.headline1!.copyWith(
            color: theme.primaryColor,
          ),
        ),
        const Gap(size: 30),
        SvgPicture.asset(
          data.imagePath,
          height: 115,
        ),
        const Gap(size: 30),
        Text(
          data.description,
          style: textTheme.bodyText1!.copyWith(
            color: theme.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
