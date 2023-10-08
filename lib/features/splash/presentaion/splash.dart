import 'package:expenses_app/app/theme/fonts.dart';
import 'package:expenses_app/core/extensions/context_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isRendered = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(milliseconds: 100)).then((value) {
        setState(() {
          isRendered = !isRendered;
          print("im rendered");
        });
      });

      Future.delayed(Duration(seconds: 2)).then((value) {
        print("I'm leaving splash");
        context.replace("onBoarding");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment(0.23, -0.97),
          end: Alignment(-0.23, 0.97),
          colors: [Color(0xFF63B4AE), Color(0xFF438883)],
        )),
        child: Center(
            child: AnimatedCrossFade(
                firstChild: const Text(
                  "",
                ),
                secondChild: Text(
                  "Expensy",
                  style: AppFonts.headline1,
                ),
                crossFadeState: !isRendered
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 600))),
      ),
    );
  }
}
