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
    final textTheme = ThemeHelper.getTextTheme(context);

    final navigator = Navigator.of(context);

    return Column(
      children: [
        Expanded(
          child: Text(
            title,
            style: textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w500,
            ),
            maxLines: null,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  onSelect(true);

                  navigator.pop();
                },
                child: Text(
                  options[0],
                  style: textTheme.bodyText1!.copyWith(color: kGreen),
                ),
              ),
              InkWell(
                onTap: () {
                  onSelect(false);

                  navigator.pop();
                },
                child: Text(
                  options[1],
                  style: textTheme.bodyText1!.copyWith(
                    color: kRed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
