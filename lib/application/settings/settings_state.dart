part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final ThemeMode? themeMode;
  final bool allowNotifications;
  final Color? accentColor;
  final Locale? language;

  const SettingsState({
    this.themeMode,
    this.allowNotifications = true,
    this.accentColor,
    this.language,
  });

  @override
  List<Object> get props => [
        themeMode ?? 0,
        allowNotifications,
        accentColor?.alpha ?? 0,
        accentColor?.green ?? 0,
        accentColor?.blue ?? 0,
        language?.languageCode ?? 0,
      ];

  factory SettingsState.fromJson(Map<String, dynamic> json) {
    final color = (json['accentColor'] as List).cast<num>();

    return SettingsState(
      accentColor: color.isEmpty
          ? null
          : Color.fromRGBO(
              color[0].toInt(),
              color[1].toInt(),
              color[2].toInt(),
              color[3].toDouble(),
            ),
      language:
          json['language'] == null ? null : Locale(json['language'] as String),
      allowNotifications: json['allowNotifications'] as bool,
      themeMode: _parseThemeModeFromString(
        json['themeMode'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'themeMode': themeMode?.toDataString(),
        'allowNotifications': allowNotifications,
        'accentColor': accentColor == null
            ? []
            : [
                accentColor!.red,
                accentColor!.green,
                accentColor!.blue,
                accentColor!.opacity,
              ],
        'language': language?.languageCode,
      };

  SettingsState copyWith({
    ThemeMode? themeMode,
    bool? allowNotifications,
    Color? accentColor,
    Locale? language,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      allowNotifications: allowNotifications ?? this.allowNotifications,
      accentColor: accentColor ?? this.accentColor,
      language: language ?? this.language,
    );
  }
}

ThemeMode _parseThemeModeFromString(String value) {
  switch (value) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
  }

  return ThemeMode.light;
}
