import 'package:flutter/material.dart';

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
