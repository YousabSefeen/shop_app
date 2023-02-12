import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            children: [
              SizedBox(height: constraints.maxHeight * 0.15),
              Container(
                height: constraints.maxHeight * 0.50,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/no_internet.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.20,
                child: Text(
                  'Can\'t connect..check internet.',
                  style: TextStyle(
                    fontSize: 30.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.15),
            ],
          ),
        ),
      ),
    );
  }
}
