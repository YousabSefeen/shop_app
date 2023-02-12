import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static ThemeData light = ThemeData(
    primarySwatch: Colors.amber,
    unselectedWidgetColor: Colors.grey,
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[100],
      elevation: 0,
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: Color.fromARGB(255, 38, 38, 115),
      elevation: 8,
    ),
    iconTheme: const IconThemeData(
      color: Colors.grey,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      /// type: BottomNavigationBarType.fixed,This is necessary to show the background color
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(size: 32.h),
      unselectedIconTheme: IconThemeData(size: 20.h),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(
          color: Colors.white,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontFamily: 'styleOne',
      ),
      titleMedium: TextStyle(
        fontSize: 35.sp,
        fontWeight: FontWeight.w700,
        fontFamily: 'styleOne',
        color: const Color.fromARGB(255, 38, 38, 115),
      ),
      titleSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: 'styleOne',
      ),
      bodyLarge: TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeight.w700,
        color: const Color.fromARGB(255, 38, 38, 115),
        fontFamily: 'styleOne',
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontFamily: 'styleTwo',
        color: Colors.blueGrey,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        fontSize: 22.sp,
        color: Colors.black54,
        fontFamily: 'styleTwo',
      ),
      labelLarge: TextStyle(
        color: Colors.white,
        fontFamily: 'styleTwo',
        fontSize: 16.sp,
      ),
      labelMedium: TextStyle(
        fontSize: 15.sp,
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontFamily: 'styleTwo',
      ),
      labelSmall: TextStyle(
        fontSize: 13.sp,
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontFamily: 'styleTwo',
      ),
      displaySmall: TextStyle(
        fontSize: 23.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontFamily: 'styleOne',
      ),
    ),
  );

  static ThemeData dark = ThemeData(




    primarySwatch: Colors.grey,
    scaffoldBackgroundColor: Colors.black,
    unselectedWidgetColor: Colors.grey,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: Color.fromARGB(255, 38, 38, 115),
      elevation: 8,
    ),
    iconTheme: const IconThemeData(
      color: Colors.grey,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(
        size: 32.h,
      ),
      unselectedIconTheme: IconThemeData(
        size: 20.h,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.black,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(
          color: Colors.white70,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white70,
        fontFamily: 'styleOne',
      ),
      titleMedium: TextStyle(
        fontSize: 35.sp,
        fontWeight: FontWeight.w700,
        color: Colors.grey,
        fontFamily: 'styleOne',
      ),
      titleSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
        fontFamily: 'styleOne',
      ),
      bodyLarge: TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeight.w700,
        color: Colors.grey,
        fontFamily: 'styleOne',
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontFamily: 'styleTwo',
        color: Colors.blueGrey,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        fontSize: 22.sp,
        color: Colors.grey,
        fontFamily: 'styleTwo',
      ),
      labelLarge: TextStyle(
        color: Colors.white,
        fontFamily: 'styleTwo',
        fontSize: 16.sp,
      ),
      labelMedium: TextStyle(
        fontSize: 15.sp,
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontFamily: 'styleTwo',
      ),
      labelSmall: TextStyle(
        fontSize: 13.sp,
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontFamily: 'styleTwo',
      ),
      displaySmall: TextStyle(
        fontSize: 23.sp,
        fontWeight: FontWeight.w700,
        color: Colors.grey,
        fontFamily: 'styleOne',
      ),
    ),
  );
}
