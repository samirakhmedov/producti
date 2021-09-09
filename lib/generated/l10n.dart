// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Incredible every day tool with incredible performance.`
  String get onboardingDesc1 {
    return Intl.message(
      'Incredible every day tool with incredible performance.',
      name: 'onboardingDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Managable and custom view of app. \n Be the boss, bruh.`
  String get onboardingDesc2 {
    return Intl.message(
      'Managable and custom view of app. \n Be the boss, bruh.',
      name: 'onboardingDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Create group with todos, then create reminder, add all this to new table and share with your freinds (if you have). \n \n Wooaah. Pretty effective tool.`
  String get onboardingDesc3 {
    return Intl.message(
      'Create group with todos, then create reminder, add all this to new table and share with your freinds (if you have). \n \n Wooaah. Pretty effective tool.',
      name: 'onboardingDesc3',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Fast`
  String get fast {
    return Intl.message(
      'Fast',
      name: 'fast',
      desc: '',
      args: [],
    );
  }

  /// `Comfortable`
  String get comfortable {
    return Intl.message(
      'Comfortable',
      name: 'comfortable',
      desc: '',
      args: [],
    );
  }

  /// `Effective`
  String get effective {
    return Intl.message(
      'Effective',
      name: 'effective',
      desc: '',
      args: [],
    );
  }

  /// `Email was already used by other greedy user!`
  String get emailAlreadyInUse {
    return Intl.message(
      'Email was already used by other greedy user!',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `This user was removed from system. Create new one.`
  String get userRemoved {
    return Intl.message(
      'This user was removed from system. Create new one.',
      name: 'userRemoved',
      desc: '',
      args: [],
    );
  }

  /// `You are trying to sign in to not existing account. Create one firstly. :)`
  String get userNotExists {
    return Intl.message(
      'You are trying to sign in to not existing account. Create one firstly. :)',
      name: 'userNotExists',
      desc: '',
      args: [],
    );
  }

  /// `Not correct password for this account!`
  String get wrongPassword {
    return Intl.message(
      'Not correct password for this account!',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `No local account to sign in automatically!`
  String get userNotLoggedIn {
    return Intl.message(
      'No local account to sign in automatically!',
      name: 'userNotLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Not valid email was typed!`
  String get invalidEmail {
    return Intl.message(
      'Not valid email was typed!',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Too short password!`
  String get invalidPassword {
    return Intl.message(
      'Too short password!',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `This is where the fun continues, boy.`
  String get funContinues {
    return Intl.message(
      'This is where the fun continues, boy.',
      name: 'funContinues',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
