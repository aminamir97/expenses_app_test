import 'package:expenses_app/app/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'fonts.dart';

class ButtonThemes {
  static final buttonSize = Size(157.w, 54.h);

  static final defaultElevatedButton = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.all(AppColors.primary),
    textStyle: MaterialStateProperty.all(AppFonts.subtitle1),
    padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.r),
      ),
    ),
  );

  static final secondaryElevatedButton = defaultElevatedButton.copyWith(
    alignment: Alignment.centerLeft,
    foregroundColor: const MaterialStatePropertyAll(AppColors.black),
    backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
  );

  static final disabledElevatedButton = defaultElevatedButton.copyWith(
    foregroundColor: const MaterialStatePropertyAll(AppColors.black),
    backgroundColor: const MaterialStatePropertyAll(AppColors.grey300),
  );

  static final darkElevatedButton = defaultElevatedButton.copyWith(
    side: const MaterialStatePropertyAll(BorderSide(color: Colors.white)),
    textStyle: MaterialStatePropertyAll(AppFonts.subtitle1),
    backgroundColor: const MaterialStatePropertyAll(Color(0xFF333C39)),
  );

  static final invertedElevatedButton = defaultElevatedButton.copyWith(
    backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
    foregroundColor: const MaterialStatePropertyAll(AppColors.black),
    side: const MaterialStatePropertyAll(BorderSide(width: 1.5)),
  );
}
