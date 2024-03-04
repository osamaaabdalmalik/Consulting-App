
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemes{
  static ThemeData themeEnglish = ThemeData(
    fontFamily: "PlayfairDisplay",
    primarySwatch: AppColors.purple,
    textTheme: const TextTheme(
        headline1: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.black),
        headline2: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 26, color: AppColors.black),
        bodyText1: TextStyle(
            height: 2,
            color: AppColors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 14),
        bodyText2: TextStyle(height: 2, color: AppColors.grey, fontSize: 14)),
  );
  static ThemeData themeArabic = ThemeData(
    fontFamily: "Cairo",
    primarySwatch: AppColors.purple,
    textTheme: const TextTheme(
        headline1: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.black),
        headline2: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 26, color: AppColors.black),
        bodyText1: TextStyle(
            height: 2,
            color: AppColors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 14),
        bodyText2: TextStyle(height: 2, color: AppColors.grey, fontSize: 14)),
  );
}

