import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class CreatePopupTile extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;
  final String title;

  const CreatePopupTile({
    Key? key,
    this.onTap,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    final textTheme = theme.textTheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ThemeHelper.isDarkMode(context) ? kBlack : kWhite,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 25,
                    color: theme.primaryColor,
                  ),
                  const Gap(size: 18),
                  Text(
                    title,
                    style: textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.chevron_right,
                color: ThemeHelper.isDarkMode(context)
                    ? kDarkerGray
                    : kLighterGray,
                size: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
