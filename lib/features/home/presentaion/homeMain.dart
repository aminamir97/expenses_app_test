import 'package:expenses_app/app/routes.dart';
import 'package:expenses_app/app/theme/colors.dart';
import 'package:expenses_app/core/extensions/context_ext.dart';
import 'package:expenses_app/features/home/presentaion/allExpenses.dart';
import 'package:expenses_app/features/home/presentaion/home.dart';
import 'package:expenses_app/features/home/presentaion/stats.dart';
import 'package:flutter/material.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int index = 1;

  List pages = [AllExpenses(), Home(), Stats()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                onTap: (value) {
                  setState(() {
                    index = value;
                  });
                },
                currentIndex: index,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.wallet_rounded), label: "Expesnes"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bar_chart_rounded), label: "Stats")
                ]),
            body: pages[index]));
  }
}
