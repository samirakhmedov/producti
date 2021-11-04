import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

extension ThemeModeExt on ThemeMode {
  String toDataString() {
    switch (this) {
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
    }
  }
}

extension LocaleExt on Locale {
  LocaleType toLocaleType() {
    switch (languageCode) {
      case 'ru':
        return LocaleType.ru;
      case 'en':
        return LocaleType.en;
    }

    return LocaleType.en;
  }
}
