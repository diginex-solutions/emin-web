import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData appThemeData() {
  return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      accentColorBrightness: Brightness.light,
      colorScheme: ColorScheme(
          primary: Color(0xff0D7EE6),
          // used
          primaryVariant: Color(0xffF5ECDB),
          // used
          secondary: Colors.black,
          // used
          secondaryVariant: Color(0xffF5ECDB),
          // used
          surface: Color(0xFFD1DFFF),
          // used
          background: Color(0xffDBF4FF),
          // Used
          error: Color(0xff29292C),
          onPrimary: Color(0xffF2F6FF),
          // used
          onSecondary: Color(0xffD1DFFF),
          // used
          onSurface: Color(0xff29292C),
          onBackground: Color(0xffE8EFFF),
          // used
          onError: Color(0xff29292C),
          brightness: Brightness.light),
      accentColor: Colors.white,
      buttonColor: Color(0xffFEEBEE),
      selectedRowColor: Color(0xffDBF4FF),
      cardColor: Colors.white,
      toggleButtonsTheme: ToggleButtonsThemeData(fillColor: Color(0xffCBDAFF)),
      fontFamily: 'Inter',
      backgroundColor: Colors.white);
}
