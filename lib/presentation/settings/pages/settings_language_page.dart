import 'package:flutter/material.dart';
import 'package:producti/application/settings/settings_cubit.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:provider/src/provider.dart';

class _LanguageSelection {
  final Locale locale;
  final String text;

  _LanguageSelection(this.locale, this.text);
}

class SettingsLanguagePage extends StatelessWidget {
  const SettingsLanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intl = S.of(context);

    final textTheme = ThemeHelper.getTextTheme(context);

    final list = [
      _LanguageSelection(
        const Locale('en', ''),
        intl.english,
      ),
      _LanguageSelection(
        const Locale('ru', ''),
        intl.russian,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          intl.language,
          style: textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        itemBuilder: (context, index) {
          final selection = list[index];

          return AppListTile(
            title: selection.text,
            onTap: () {
              context.read<SettingsCubit>().mutate(
                    language: selection.locale,
                  );
            },
          );
        },
        separatorBuilder: (context, index) => const Gap(),
        itemCount: list.length,
      ),
    );
  }
}
