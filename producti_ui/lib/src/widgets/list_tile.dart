import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final bool selected;
  final void Function()? onTap;

  const DrawerListTile({
    Key? key,
    this.icon,
    this.text,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        width: double.maxFinite,
        color: selected ? theme.primaryColor : theme.backgroundColor,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Icon(
                icon,
                size: 18,
                color: selected ? theme.backgroundColor : theme.primaryColor,
              ),
            ),
            if (text != null)
              Padding(
                padding: const EdgeInsets.only(left: 44),
                child: Text(
                  text!,
                  style: textTheme.bodyText2!.copyWith(
                    color: selected
                        ? theme.backgroundColor
                        : textTheme.bodyText2!.color,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
