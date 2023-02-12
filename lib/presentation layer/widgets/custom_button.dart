import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CustomButton({Key? key, required this.text,required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          const Color.fromARGB(255, 38, 38, 115),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(

          vertical: 10.h,
          horizontal: 25.w
        ))
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 25.sp,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

