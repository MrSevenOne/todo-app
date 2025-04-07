import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData LightTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFFFFFFFF), // Oq fon
  brightness: Brightness.light,
  primaryColor: Color(0xFF6750A4), // Yorqin binafsha
  cardColor: Colors.grey[100], // Yengil kulrang kartalar
  dividerColor: Color(0xFFE0E0E0), // Ajratgich rangi

  /// AppBar Theme
  appBarTheme: AppBarTheme(
      centerTitle: true, backgroundColor: Color(0xFFFFFFFF), elevation: 0.0),

  /// DatePicker uchun UI sozlamalar
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Color(0xFFF5F5F5), // Modal fon rangi
    surfaceTintColor: Colors.white,

    headerBackgroundColor: Color(0xFF6750A4), // Sarlavha qismi
    headerForegroundColor: Colors.white, // Sarlavha matn rangi
    yearForegroundColor: MaterialStateProperty.all(Colors.black), // Yil matn rangi
    dayForegroundColor: MaterialStateProperty.all(Colors.black), // Kun matn rangi
    todayBackgroundColor: MaterialStateProperty.all(Color(0xFF6750A4)), // Bugungi sana
    todayForegroundColor: MaterialStateProperty.all(Colors.white), // Bugungi sana matni
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r), // Modal oynaning burchaklari
    ),
  ),

  textTheme: TextTheme(
    headlineLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 32.sp,
    ),
  ),

  colorScheme: ColorScheme.light(
    primary: Color(0xFF6750A4),
    onPrimary: Color(0xFFFFFFFF),
    outline: Color(0xFFBDBDBD),
    error: Colors.red,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(color: Colors.grey[600]),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(color: Colors.black),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF6750A4),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 36),
      textStyle: TextStyle(
        fontSize: 16.sp,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);
