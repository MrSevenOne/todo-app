import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData DarkTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFF000000),
  brightness: Brightness.dark,
  primaryColor: Color(0xFF8875FF),
  cardColor: Colors.grey[900],
  dividerColor: Color(0xFF979797),

  ///AppBar Theme
  appBarTheme: AppBarTheme(
      centerTitle: true, backgroundColor: Color(0xFF000000), elevation: 0.0),

  /// DatePicker uchun maxsus UI sozlamalar
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Color(0xFF121212),
    // Modal fon rangi
    surfaceTintColor: Colors.black,
    
    // Soyalar
    headerBackgroundColor: Color(0xFF8875FF),
    // Sarlavha qismi
    headerForegroundColor: Colors.white,
    // Sarlavha matn rangi
    yearForegroundColor: WidgetStateProperty.all(Colors.white),
    // Yil matn rangi
    dayForegroundColor: WidgetStateProperty.all(Colors.white),
    // Kun matn rangi
    todayBackgroundColor: WidgetStateProperty.all(Color(0xFF8875FF)),
    // Bugungi sana
    todayForegroundColor: WidgetStateProperty.all(Colors.white),
    // Bugungi sana matni
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r), // Modal oynaning burchaklari
    ),
  ),

  textTheme: TextTheme(
    headlineLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 32.sp,
    ),
  ),

  colorScheme: ColorScheme.dark(
    primary: Color(0xFF8875FF),
    onPrimary: Color(0xFFFFFFFF),
    outline: Color(0xFFAFAFAF),
    error: Colors.red,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.black,
    hintStyle: TextStyle(color: Colors.grey[600]),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(color: Colors.white),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF8875FF),
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
