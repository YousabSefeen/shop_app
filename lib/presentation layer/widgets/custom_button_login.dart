import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonLogin extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CustomButtonLogin({Key? key, required this.text,required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(60.r),
      splashColor: const Color.fromARGB(255, 128, 128, 255),
      onTap: onTap,
      child: Container(
        padding:   EdgeInsets.symmetric(vertical: 10.h, horizontal: 50.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.r),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 128, 128, 255),
              Color.fromARGB(255, 204, 0, 204),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
