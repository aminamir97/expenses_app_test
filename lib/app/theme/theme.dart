import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/database_api.dart';
import '../paddings.dart';
import 'button_themes.dart';
import 'colors.dart';
import 'fonts.dart';

class AppTheme extends ChangeNotifier {
  Brightness mode = Brightness.light;

  final DatabaseApi databaseApi;

  AppTheme({required this.databaseApi}) {
    setLightOverlay();
  }

  bool get isDark => mode == Brightness.dark;

  ThemeData get currentTheme => isDark ? darkTheme : lightTheme;

  void toggleTheme() {
    mode = isDark ? Brightness.light : Brightness.dark;
    databaseApi.setTheme(isDark);
    notifyListeners();
  }

  void setPlatformTheme() {
    mode = SchedulerBinding.instance.window.platformBrightness;
    databaseApi.setTheme(isDark);
    notifyListeners();
  }

  void setStatusBar(Color color, [Brightness brightness = Brightness.dark]) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: brightness,
        statusBarBrightness: brightness,
      ),
    );
  }

  void setLightOverlay() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        systemNavigationBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  void setDarkOverlay() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  late final basetheme = ThemeData(
    fontFamily: AppFonts.fontFamily,
    cardColor: AppColors.accent,
    colorSchemeSeed: AppColors.primary,
    inputDecorationTheme: inputDecoration,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      color: Colors.transparent,
      foregroundColor: AppColors.black,
    ).copyWith(
      titleTextStyle: AppFonts.body2.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonThemes.defaultElevatedButton,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.grey400,
      padding: AppPaddings.zero,
      labelPadding: AppPaddings.smallX,
      labelStyle: AppFonts.subtitle2.copyWith(color: AppColors.black),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      height: 50.h,
      indicatorColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      iconTheme: MaterialStatePropertyAll(
        IconThemeData(color: Colors.white, size: 32.sp),
      ),
    ),
  );

  late final lightTheme = basetheme.copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    dividerTheme: const DividerThemeData(
      color: AppColors.grey300,
      thickness: 1,
    ),
  );

  late final darkTheme = basetheme.copyWith(
    brightness: Brightness.dark,
  );

  late final textThemeLight = TextTheme(
    displayLarge: AppFonts.headline1,
    displayMedium: AppFonts.headline2,
    displaySmall: AppFonts.headline3,
    headlineMedium: AppFonts.headline4,
    headlineSmall: AppFonts.headline5,
    titleLarge: AppFonts.headline6,
    bodyLarge: AppFonts.body1,
    bodyMedium: AppFonts.body2,
    titleMedium: AppFonts.subtitle1,
    titleSmall: AppFonts.subtitle2,
  );

  late final inputDecoration = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    hintStyle: AppFonts.subtitle1.copyWith(
      color: AppColors.grey600,
    ),
    errorStyle: AppFonts.small.copyWith(color: Colors.red),
    contentPadding: EdgeInsets.all(15.sp),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.grey300),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.grey300),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.primary),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.error),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.error),
    ),
  );
}
