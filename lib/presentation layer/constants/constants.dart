import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

buildSnackBar({
  required BuildContext context,
  required String message,
  required Color textColor,
}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 20.sp,
            color: textColor,
            fontWeight: FontWeight.w500,
            fontFamily: 'styleOne',
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black,
        duration: const Duration(milliseconds: 700),
      ),
    );
}

myToast({
  required BuildContext context,
  required String message,
  required Color color,
}) =>
    showToast(message,
        textStyle: TextStyle(
          fontSize: 20.sp,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
        context: context,
        backgroundColor: color,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.bottom,
//const StyledToastPosition(align: Alignment.centerLeft, offset: 50)
        animDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ));

String? token;

