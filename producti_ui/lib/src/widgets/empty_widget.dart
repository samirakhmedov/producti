import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:producti_ui/producti_ui.dart';

class EmptyWidget extends StatelessWidget {
  final String? description;

  const EmptyWidget({Key? key, this.description}) : super(key: key);

  String _getImagePath(BuildContext context) {
    final isDarkTheme = ThemeHelper.isDarkMode(context);

    return "assets/empty${isDarkTheme ? '' : '_dark'}.svg";
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeHelper.getTextTheme(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          _getImagePath(context),
          height: 115,
        ),
        if (description != null) ...[
          const Gap(size: 12),
          Text(
            description!,
            style: textTheme.bodyText2,
          ),
        ],
      ],
    );
  }
}
