import 'package:expenses_app/app/theme/colors.dart';
import 'package:expenses_app/app/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            "assets/images/noData.png",
            height: 250.h,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 20.h,
          ),
          //text
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Text("No Data yet",
                textAlign: TextAlign.center,
                style: AppFonts.headline2.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
