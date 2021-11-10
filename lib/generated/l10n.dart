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

  /// `Passwords are not equal!`
  String get passswordsNotMatch {
    return Intl.message(
      'Passwords are not equal!',
      name: 'passswordsNotMatch',
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

  /// `This is where the fun begins, boy.`
  String get funBegins {
    return Intl.message(
      'This is where the fun begins, boy.',
      name: 'funBegins',
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

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `LET ME IIIIN`
  String get signInLongButtonText {
    return Intl.message(
      'LET ME IIIIN',
      name: 'signInLongButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get repeatPassword {
    return Intl.message(
      'Repeat password',
      name: 'repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Still not part of our party?`
  String get notPartOfParty {
    return Intl.message(
      'Still not part of our party?',
      name: 'notPartOfParty',
      desc: '',
      args: [],
    );
  }

  /// `Just join it.`
  String get join {
    return Intl.message(
      'Just join it.',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `You hate people?`
  String get hatePeople {
    return Intl.message(
      'You hate people?',
      name: 'hatePeople',
      desc: '',
      args: [],
    );
  }

  /// `Sign in anonimously.`
  String get signInAnonim {
    return Intl.message(
      'Sign in anonimously.',
      name: 'signInAnonim',
      desc: '',
      args: [],
    );
  }

  /// `Already in cool boys club?`
  String get alreadyCoolGuy {
    return Intl.message(
      'Already in cool boys club?',
      name: 'alreadyCoolGuy',
      desc: '',
      args: [],
    );
  }

  /// `Let him in, boys.`
  String get letHim {
    return Intl.message(
      'Let him in, boys.',
      name: 'letHim',
      desc: '',
      args: [],
    );
  }

  /// `Field is empty`
  String get voidValue {
    return Intl.message(
      'Field is empty',
      name: 'voidValue',
      desc: '',
      args: [],
    );
  }

  /// `Invalid link!`
  String get invalidLink {
    return Intl.message(
      'Invalid link!',
      name: 'invalidLink',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch your data, something went wrong!`
  String get failedToFetchUserData {
    return Intl.message(
      'Failed to fetch your data, something went wrong!',
      name: 'failedToFetchUserData',
      desc: '',
      args: [],
    );
  }

  /// `You are connected to the internet!`
  String get connected {
    return Intl.message(
      'You are connected to the internet!',
      name: 'connected',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Looks like you are out of interntet...`
  String get disconnected {
    return Intl.message(
      'Oops! Looks like you are out of interntet...',
      name: 'disconnected',
      desc: '',
      args: [],
    );
  }

  /// `You have no connection to internet!`
  String get notConnectedToInternet {
    return Intl.message(
      'You have no connection to internet!',
      name: 'notConnectedToInternet',
      desc: '',
      args: [],
    );
  }

  /// `You are not logged in!`
  String get doNotLoggedIn {
    return Intl.message(
      'You are not logged in!',
      name: 'doNotLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Create account.`
  String get createAccount {
    return Intl.message(
      'Create account.',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Add one`
  String get addOne {
    return Intl.message(
      'Add one',
      name: 'addOne',
      desc: '',
      args: [],
    );
  }

  /// `Nothing to see here...`
  String get nothingToSee {
    return Intl.message(
      'Nothing to see here...',
      name: 'nothingToSee',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `This table already created!`
  String get tableAlreadyExists {
    return Intl.message(
      'This table already created!',
      name: 'tableAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Table name`
  String get tableName {
    return Intl.message(
      'Table name',
      name: 'tableName',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get group {
    return Intl.message(
      'Group',
      name: 'group',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `This group already exists!`
  String get groupAlreadyExists {
    return Intl.message(
      'This group already exists!',
      name: 'groupAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Group name`
  String get groupName {
    return Intl.message(
      'Group name',
      name: 'groupName',
      desc: '',
      args: [],
    );
  }

  /// `Too big, sempai...`
  String get tooBigValue {
    return Intl.message(
      'Too big, sempai...',
      name: 'tooBigValue',
      desc: '',
      args: [],
    );
  }

  /// `Note creation`
  String get noteCreation {
    return Intl.message(
      'Note creation',
      name: 'noteCreation',
      desc: '',
      args: [],
    );
  }

  /// `Note details`
  String get noteDetails {
    return Intl.message(
      'Note details',
      name: 'noteDetails',
      desc: '',
      args: [],
    );
  }

  /// `Type title here...`
  String get typeTitle {
    return Intl.message(
      'Type title here...',
      name: 'typeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Type description here...`
  String get typeDescription {
    return Intl.message(
      'Type description here...',
      name: 'typeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Type link here...`
  String get typeLink {
    return Intl.message(
      'Type link here...',
      name: 'typeLink',
      desc: '',
      args: [],
    );
  }

  /// `Another one...`
  String get anotherOne {
    return Intl.message(
      'Another one...',
      name: 'anotherOne',
      desc: '',
      args: [],
    );
  }

  /// `Add link`
  String get addLink {
    return Intl.message(
      'Add link',
      name: 'addLink',
      desc: '',
      args: [],
    );
  }

  /// `For what reason you creating notifications and not let me show them to you??`
  String get notificationsInitializationFailure {
    return Intl.message(
      'For what reason you creating notifications and not let me show them to you??',
      name: 'notificationsInitializationFailure',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Rename`
  String get rename {
    return Intl.message(
      'Rename',
      name: 'rename',
      desc: '',
      args: [],
    );
  }

  /// `Yes.`
  String get yes {
    return Intl.message(
      'Yes.',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No.`
  String get no {
    return Intl.message(
      'No.',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete that element? All their children would be deleted also.`
  String get youSureToDelete {
    return Intl.message(
      'Are you sure you want to delete that element? All their children would be deleted also.',
      name: 'youSureToDelete',
      desc: '',
      args: [],
    );
  }

  /// `You cannot remind something to yourself in past. :)`
  String get notificationInPast {
    return Intl.message(
      'You cannot remind something to yourself in past. :)',
      name: 'notificationInPast',
      desc: '',
      args: [],
    );
  }

  /// `Pick date here...`
  String get pickDate {
    return Intl.message(
      'Pick date here...',
      name: 'pickDate',
      desc: '',
      args: [],
    );
  }

  /// `You cannot delete your single table left!`
  String get cannotDeleteSingle {
    return Intl.message(
      'You cannot delete your single table left!',
      name: 'cannotDeleteSingle',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Accent color`
  String get color {
    return Intl.message(
      'Accent color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get russian {
    return Intl.message(
      'Russian',
      name: 'russian',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Notification creation`
  String get notificationCreation {
    return Intl.message(
      'Notification creation',
      name: 'notificationCreation',
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
