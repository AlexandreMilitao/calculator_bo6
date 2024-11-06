import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData myTheme = ThemeData(
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
    ),
  ),
  textTheme: textTheme,
);

TextTheme textTheme = TextTheme(
  titleLarge: TextStyle(
    fontSize: 30.sp,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
  bodyLarge: TextStyle(
    fontSize: 20.sp,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
);
