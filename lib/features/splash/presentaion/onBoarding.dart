import 'package:expenses_app/app/assets.dart';
import 'package:expenses_app/app/theme/colors.dart';
import 'package:expenses_app/app/theme/fonts.dart';
import 'package:expenses_app/core/extensions/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //img
          Image.asset(
            AppImages.onBoarding,
            height: 640.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 20.h,
          ),
          //text
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Text("Spend Smarter Save More",
                textAlign: TextAlign.center,
                style: AppFonts.headline2.copyWith(color: AppColors.primary)),
          ),
          //button
          SizedBox(
            height: 20.h,
          ),

          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: ElevatedButton(
                  onPressed: () {
                    context.replace("home");
                  },
                  child: const Text(
                    "Get Started",
                  ))),
        ],
      ),
    );
  }
}
