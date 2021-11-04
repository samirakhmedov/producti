import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'settings_ext.dart';

part 'settings_state.dart';

@lazySingleton
class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit()
      : super(
          const SettingsState(),
        );

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toJson();
  }

  void initialize(Locale locale, Color primaryColor, ThemeMode themeMode) =>
      emit(
        state.copyWith(
          accentColor: state.accentColor ?? primaryColor,
          language: state.language ?? locale,
          themeMode: state.themeMode ?? themeMode,
        ),
      );

  void mutate({
    ThemeMode? themeMode,
    bool? allowNotifications,
    Color? accentColor,
    Locale? language,
  }) =>
      emit(
        state.copyWith(
          themeMode: themeMode ?? state.themeMode,
          allowNotifications: allowNotifications ?? state.allowNotifications,
          accentColor: accentColor ?? state.accentColor,
          language: language ?? state.language,
        ),
      );
}
