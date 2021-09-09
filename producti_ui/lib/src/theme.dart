import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeHelper {
  static bool isDarkMode(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;

    return brightness == Brightness.dark;
  }
}

const _kBackgroundDark = Color(0xFF151414);
const _kBackgroundLight = Color(0xFFFAFAFA);

const _kBlack = Color(0xFF000000);
const _kWhite = Color(0xFFFFFFFF);

const _kMainDarkColor = Color(0xFFE8AC13);
const _kMainLightColor = Color(0xFF3889E8);

const kDarkerGray = Color(0xFF666666);
const kGray = Color(0xFFCCCCCC);
const kLightGray = Color(0xFFC4C4C4);

const kRed = Color(0xFFDF2C2C);

const _kBiggerHeaderTextStyle = TextStyle(
  fontSize: 50,
);

const _kPinCodeTextStyle = TextStyle(
  fontSize: 48,
);

const _kHeaderTextStyle = TextStyle(
  fontSize: 35,
);

const _kSubheadTextStyle = TextStyle(
  fontSize: 24,
);

const _kBodyText1TextStyle = TextStyle(
  fontSize: 18,
);

const _kBodyText2TextStyle = TextStyle(
  fontSize: 16,
);

const _kCaptionTextStyle = TextStyle(
  fontSize: 14,
);

const _kSettingsOptionTextStyle = TextStyle(
  fontSize: 13,
);

const _kSubtitleTextStyle = TextStyle(
  fontSize: 12,
);

const _kSettingsOptionDescriptionTextStyle = TextStyle(
  fontSize: 11,
);

const _kSmallTextStyle = TextStyle(
  fontSize: 10,
);

const _kInputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    borderSide: BorderSide.none,
  ),
  filled: true,
);

final kDarkTheme = ThemeData(
  backgroundColor: _kBackgroundDark,
  scaffoldBackgroundColor: _kBackgroundDark,
  iconTheme: const IconThemeData(
    color: _kMainDarkColor,
  ),
  primaryColor: _kMainDarkColor,
  primaryColorDark: _kMainDarkColor,
  textTheme: GoogleFonts.tajawalTextTheme(
    TextTheme(
      /// Onboarding text, subhead text

      bodyText1: _kBodyText1TextStyle.copyWith(
        color: _kMainDarkColor,
      ),

      /// Subhead text 2, group header
      bodyText2: _kBodyText2TextStyle.copyWith(
        color: _kWhite,
      ),

      /// Text on main screen

      caption: _kCaptionTextStyle.copyWith(
        color: _kWhite,
      ),

      /// On launch text

      headline1: _kBiggerHeaderTextStyle.copyWith(
        color: _kWhite,
      ),

      /// Header on log in screens

      headline2: _kHeaderTextStyle.copyWith(
        color: _kMainDarkColor,
      ),

      /// Same, but even board name

      headline3: _kSubheadTextStyle.copyWith(
        color: _kWhite,
      ),

      /// Text under inputs.

      subtitle1: _kSubtitleTextStyle.copyWith(
        color: _kWhite,
      ),

      /// New text mark
      overline: _kSmallTextStyle.copyWith(
        color: kRed,
      ),

      /// Settings option
      button: _kSettingsOptionTextStyle.copyWith(
        color: kLightGray,
      ),

      /// Settings option desciption
      headline5: _kSettingsOptionDescriptionTextStyle.copyWith(
        color: kDarkerGray,
      ),

      /// Pin code button text
      headline4: _kPinCodeTextStyle.copyWith(
        color: _kBlack,
      ),
    ),
  ),
  inputDecorationTheme: _kInputDecorationTheme,
);

final kLightTheme = ThemeData(
  backgroundColor: _kBackgroundLight,
  scaffoldBackgroundColor: _kBackgroundLight,
  iconTheme: const IconThemeData(
    color: _kMainLightColor,
  ),
  primaryColor: _kMainLightColor,
  primaryColorDark: _kMainLightColor,
  textTheme: GoogleFonts.tajawalTextTheme(
    TextTheme(
      bodyText1: _kBodyText1TextStyle.copyWith(
        color: _kMainLightColor,
      ),
      bodyText2: _kBodyText2TextStyle.copyWith(
        color: _kBlack,
      ),
      caption: _kCaptionTextStyle.copyWith(
        color: _kBlack,
      ),
      headline1: _kBiggerHeaderTextStyle.copyWith(
        color: kDarkerGray,
      ),
      headline2: _kHeaderTextStyle.copyWith(
        color: _kMainLightColor,
      ),
      headline3: _kSubheadTextStyle.copyWith(
        color: _kBlack,
      ),
      subtitle1: _kSubtitleTextStyle.copyWith(
        color: _kBlack,
      ),
      overline: _kSmallTextStyle.copyWith(
        color: kRed,
      ),
      button: _kSettingsOptionTextStyle.copyWith(
        color: kDarkerGray,
      ),
      headline5: _kSettingsOptionDescriptionTextStyle.copyWith(
        color: kGray,
      ),
      headline4: _kPinCodeTextStyle.copyWith(
        color: _kWhite,
      ),
    ),
  ),
);
