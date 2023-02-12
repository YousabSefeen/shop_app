import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/presentation%20layer/widgets/custom_button.dart';

import '../../presentation%20layer/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> boardingPages = [
    OnBoardingModel(
      imageUrl: 'assets/images/image1.png',
      title: 'Buy',
      description: 'Shop from thousands of brands\n at throwaway prices.',
    ),
    OnBoardingModel(
      imageUrl: 'assets/images/image2.png',
      title: 'ONLINE CART',
      description:
          'Select and memorize your future pur-\n chases with smart online shopping cart.',
    ),
    OnBoardingModel(
      imageUrl: 'assets/images/image3.png',
      title: 'SALES AND GIFTS',
      description:
          'Holiday sales .Birthday gifts.\nVarious choice and categories.',
    ),
  ];

  PageController boardingController = PageController();

  submit() async {
    Navigator.of(context).pushReplacementNamed(LogIngScreen.route);

    var pref = await SharedPreferences.getInstance();

    pref.setBool('isWatchOnBoard', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (ctx, constraints) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * 0.05,
          ),
          child: Column(
            children: [
              SizedBox(height: constraints.maxHeight * 0.12),
              SizedBox(
                height: constraints.maxHeight * 0.6,
                child: PageView.builder(
                  controller: boardingController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: boardingPages.length,
                  itemBuilder: (ctx, index) {
                    return buildOnBoardingItem(boardingPages[index], context);
                  },
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.06,
                child: SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingPages.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Color.fromARGB(255, 71, 115, 239),
                  ),
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.03),
              SizedBox(
                  height: constraints.maxHeight * 0.08,
                  child: CustomButton(
                    text: 'Get Started',
                    onTap: submit,
                  )),
              SizedBox(height: constraints.maxHeight * 0.11),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildOnBoardingItem(
    OnBoardingModel onBoardingModel, BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: constraints.maxHeight * 0.05),
        SizedBox(
          height: constraints.maxHeight * 0.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(360.r),
            child: Image(
              image: AssetImage(onBoardingModel.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.05),
        SizedBox(
          height: constraints.maxHeight * 0.15,
          child: Text(
            onBoardingModel.title,
            style: TextStyle(
              color: const Color.fromARGB(255, 71, 115, 239),
              fontSize: 35.sp,
              fontWeight: FontWeight.w800,
              fontFamily: 'styleOne',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.03),
        SizedBox(
          height: constraints.maxHeight * 0.15,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: FittedBox(
              child: Text(
                onBoardingModel.description,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'styleOne',
                  fontSize: 30.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.07),
      ],
    ),
  );
}

class OnBoardingModel {
  final String imageUrl;
  final String title;

  final String description;

  OnBoardingModel({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}
