import 'package:flutter/material.dart';
import 'package:flutter_app3/core/utils/app_colors.dart';
import 'package:flutter_app3/core/utils/app_strings.dart';


ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    hintColor: AppColors.hint,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: AppStrings.fontFamily,
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.0)),
    textTheme: const TextTheme(
      displayMedium: TextStyle(
          height: 1.3,
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    ),
  );
}
