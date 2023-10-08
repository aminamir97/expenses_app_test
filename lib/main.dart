import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'app/constants.dart';
import 'injections.dart';

void main() async {
  await Injections.instance.init();

  runApp(const ExpensyApp());
}

class ExpensyApp extends StatelessWidget {
  const ExpensyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Injections.instance.providers,
      child: ScreenUtilInit(
        designSize: AppConstants.designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => const App(),
      ),
    );
  }
}
