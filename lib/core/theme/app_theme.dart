import 'package:flutter/material.dart';
import 'package:tasbeeh_counter/core/theme/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness:  Brightness.light,

    scaffoldBackgroundColor: Colors.transparent,

    colorScheme: ColorScheme.light(
      primary: appcolor.colorlight,
    ),

    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: appcolor.textLight,
      )
    ),

    iconTheme: IconThemeData(
      color: appcolor.iconLight
    ),

    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: appcolor.navigationBarLight,

      indicatorColor: appcolor.navigationSelectedLight,

      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          color: appcolor.navigationSelectedLight,
        ),
      ),
    ),

  );
  static ThemeData darkTheme = ThemeData(
    brightness:  Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,

    colorScheme:  ColorScheme.dark(
      primary: appcolor.colordark,
    ),

    textTheme: TextTheme(bodyMedium: TextStyle(
      color: appcolor.textDark,
    )),

    iconTheme: IconThemeData(
      color: appcolor.iconDark,
    ),

    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: appcolor.navigationBarDark,

      indicatorColor: appcolor.navigationSelectedDark,

      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          color: appcolor.navigationSelectedDark,
        ),
      ),
    ),

  );
}
