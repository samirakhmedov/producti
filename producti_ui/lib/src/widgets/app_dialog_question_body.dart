import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class AppDialogQuestionBody extends StatelessWidget {
  final String title;
  final List<String> options;
  final void Function(bool answer) onSelect;

  const AppDialogQuestionBody({
    Key? key,
    required this.title,
    required this.onSelect,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    final textTheme = theme.textTheme;

    final navigator = Navigator.of(context);

    return Column(
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.primaryColor,
            ),
            textAlign: TextAlign.center,
            maxLines: null,
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClickableText(
                onTap: () {
                  onSelect(true);

                  navigator.pop();
                },
                text: options[0],
                textStyle: textTheme.bodyText1!.copyWith(
                  color: kGreen,
                ),
              ),
              ClickableText(
                onTap: () {
                  onSelect(false);

                  navigator.pop();
                },
                text: options[1],
                textStyle: textTheme.bodyText1!.copyWith(
                  color: kRed,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
