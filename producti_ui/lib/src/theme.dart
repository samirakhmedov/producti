import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeHelper {
  static bool isDarkMode(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return brightness == Brightness.dark;
  }

  static ThemeData getTheme(BuildContext context) => Theme.of(context);

  static TextTheme getTextTheme(BuildContext context) =>
      Theme.of(context).textTheme;
}

const _kBackgroundDark = Color(0xFF151414);
const _kBackgroundLight = Color(0xFFFAFAFA);

const kBlack = Color(0xFF000000);
const kWhite = Color(0xFFFFFFFF);

const kMainDarkColor = Color(0xFFE8AC13);
const kMainLightColor = Color(0xFF3889E8);

const kDarkerGray = Color(0xFF666666);
const kGray = Color(0xFFCCCCCC);
const kLightGray = Color(0xFFC4C4C4);
const kLighterGray = Color(0xFFEBEBEB);

const kRed = Color(0xFFDF2C2C);
const kGreen = Color(0xFF2CAE17);

const colorList = [
  Color(0xFFCE1515),
  Color(0xFFF1D74C),
  Color(0xFFA308CA),
  Color(0xFF30F1AC),
  Color(0xFF13C5BF),
  kMainDarkColor,
  kMainLightColor
];

final _kBiggerHeaderTextStyle = TextStyle(
  fontSize: 50.sp,
);

final _kPinCodeTextStyle = TextStyle(
  fontSize: 48.sp,
);

final _kHeaderTextStyle = TextStyle(
  fontSize: 35.sp,
);

final _kSubheadTextStyle = TextStyle(
  fontSize: 24.sp,
);

final _kBodyText1TextStyle = TextStyle(
  fontSize: 18.sp,
);

final _kBodyText2TextStyle = TextStyle(
  fontSize: 16.sp,
);

final _kCaptionTextStyle = TextStyle(
  fontSize: 14.sp,
);

final _kSettingsOptionTextStyle = TextStyle(
  fontSize: 13.sp,
);

final _kSubtitleTextStyle = TextStyle(
  fontSize: 12.sp,
);

final _kSettingsOptionDescriptionTextStyle = TextStyle(
  fontSize: 11.sp,
);

final _kSmallTextStyle = TextStyle(
  fontSize: 10.sp,
);

const _kInputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    borderSide: BorderSide.none,
  ),
  fillColor: kLighterGray,
  filled: true,
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    borderSide: BorderSide.none,
  ),
);

final kDarkTheme = ThemeData(
  backgroundColor: _kBackgroundDark,
  scaffoldBackgroundColor: _kBackgroundDark,
  iconTheme: const IconThemeData(
    color: kMainDarkColor,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    color: Colors.transparent,
    iconTheme: IconThemeData(
      color: kWhite,
    ),
  ),
  brightness: Brightness.dark,
  primaryColor: kMainDarkColor,
  primaryColorDark: kMainDarkColor,
  textTheme: GoogleFonts.robotoTextTheme(
    TextTheme(
      /// Onboarding text, subhead text

      bodyText1: _kBodyText1TextStyle.copyWith(
        color: kMainDarkColor,
      ),

      /// Subhead text 2, group header
      bodyText2: _kBodyText2TextStyle.copyWith(
        color: kWhite,
      ),

      /// Text on main screen

      caption: _kCaptionTextStyle.copyWith(
        color: kWhite,
      ),

      /// On launch text

      headline1: _kBiggerHeaderTextStyle.copyWith(
        color: kWhite,
      ),

      /// Header on log in screens

      headline2: _kHeaderTextStyle.copyWith(
        color: kMainDarkColor,
      ),

      /// Same, but even board name

      headline3: _kSubheadTextStyle.copyWith(
        color: kWhite,
      ),

      /// Text under inputs.

      subtitle1: _kSubtitleTextStyle.copyWith(
        color: kWhite,
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
        color: kBlack,
      ),
    ),
  ),
  inputDecorationTheme: _kInputDecorationTheme,
);

final kLightTheme = ThemeData(
  backgroundColor: _kBackgroundLight,
  scaffoldBackgroundColor: _kBackgroundLight,
  iconTheme: const IconThemeData(
    color: kMainLightColor,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    color: Colors.transparent,
    iconTheme: IconThemeData(
      color: kBlack,
    ),
  ),
  primaryColor: kMainLightColor,
  primaryColorDark: kMainLightColor,
  brightness: Brightness.light,
  textTheme: GoogleFonts.robotoTextTheme(
    TextTheme(
      bodyText1: _kBodyText1TextStyle.copyWith(
        color: kMainLightColor,
      ),
      bodyText2: _kBodyText2TextStyle.copyWith(
        color: kBlack,
      ),
      caption: _kCaptionTextStyle.copyWith(
        color: kBlack,
      ),
      headline1: _kBiggerHeaderTextStyle.copyWith(
        color: kDarkerGray,
      ),
      headline2: _kHeaderTextStyle.copyWith(
        color: kMainLightColor,
      ),
      headline3: _kSubheadTextStyle.copyWith(
        color: kBlack,
      ),
      subtitle1: _kSubtitleTextStyle.copyWith(
        color: kBlack,
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
        color: kWhite,
      ),
    ),
  ),
  inputDecorationTheme: _kInputDecorationTheme,
);
