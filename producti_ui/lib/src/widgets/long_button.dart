import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final void Function() onTap;
  final String text;

  const LongButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17.5),
      child: Container(
        width: double.infinity,
        height: 35,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(17.5),
        ),
        child: Center(
          child: Text(
            text,
            style: textTheme.bodyText2,
          ),
        ),
      ),
    );
  }
}
