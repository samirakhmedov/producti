import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:producti/application/settings/settings_cubit.dart';
import 'package:producti/generated/l10n.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti/presentation/settings/widgets/color_picker.dart';
import 'package:producti_ui/producti_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intl = S.of(context);

    final textTheme = ThemeHelper.getTextTheme(context);

    final settings = context.read<SettingsCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          intl.settings,
          style: textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: ListView(
              children: [
                const Gap(),
                Text(
                  intl.color,
                  style: textTheme.bodyText2,
                ),
                const Gap(),
                ColorPicker(
                  onSelect: (color) {
                    settings.mutate(
                      accentColor: color,
                    );
                  },
                ),
                const Gap(),
                AppListTile(
                  title: intl.language,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.settingsLanguage);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      intl.theme,
                      style: textTheme.bodyText2,
                    ),
                    AppThemeSwitcher(
                      value: state.themeMode!,
                      onTap: (themeMode) {
                        settings.mutate(
                          themeMode: themeMode,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
