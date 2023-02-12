import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Business Logic Layer/cubits/cubit_theme_bottom_na.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;

  final String? hint;

  final String? label;

  final bool obscureText;
  final IconData prefixIcon;
  final IconButton? suffixIcon;
  final TextInputType textInputType;

  final void Function(String)? onFieldSubmitted;

  final String? Function(String?)? validator;
  final double? radius;
  final bool isLoginScreen;

  const CustomTextField({
    this.controller,
    this.hint,
    this.label,
    required this.obscureText,
    required this.prefixIcon,
    required this.radius,
    required this.textInputType,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.validator,
    this.isLoginScreen = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeAndBNCubit.getObject(context).tm == ThemeMode.dark;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 7.h,
        horizontal: 8.w,
      ),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
             vertical: 20.h,
          ),
          hintText: hint,
          hintStyle: isLoginScreen
              ? TextStyle(
                  fontSize: 15.sp,
                  color: const Color.fromARGB(255, 38, 38, 115))
              : TextStyle(fontSize: 15.sp, color: Colors.grey),
          labelText: isLoginScreen ? null : label,
          labelStyle: isLoginScreen
              ? TextStyle(fontSize: 20.sp, color: Colors.black)
              : Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 20.sp,
                  ),
          fillColor: Colors.white,
          filled: isLoginScreen,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius!),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: const BorderSide(color: Colors.white, width: 0)),
          enabled: true,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(

             vertical: 12.h,
              horizontal: 12.w,
            ),
            child: Icon(prefixIcon,
                size: 30.h, color: const Color.fromARGB(255, 38, 38, 115)),
          ),
          suffixIcon: suffixIcon,
        ),
        keyboardType: textInputType,
        obscureText: obscureText,

        validator: validator,
        style: TextStyle(
          color: isLoginScreen
              ? Colors.black
              : isDark
                  ? Colors.white70
                  : Colors.black,
          fontSize: 20.sp,
          fontFamily: 'styleTwo',
        ),
        cursorColor: isLoginScreen
            ? const Color.fromARGB(255, 38, 38, 115)
            : Colors.deepOrange,
      ),
    );
  }
}
