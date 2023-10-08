import 'package:expenses_app/features/home/models/expenseModel.dart';
import 'package:expenses_app/features/home/presentaion/addExpense.dart';
import 'package:expenses_app/features/home/presentaion/allExpenses.dart';
import 'package:expenses_app/features/home/presentaion/editExpense.dart';
import 'package:expenses_app/features/home/presentaion/home.dart';
import 'package:expenses_app/features/home/presentaion/homeMain.dart';
import 'package:expenses_app/features/splash/presentaion/onBoarding.dart';
import 'package:expenses_app/features/splash/presentaion/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/errors/failures.dart';

class AppRoutes {
  static const initial = splash;
  static const first = splash;

  static const splash = "splash";
  static const onBoarding = "onBoarding";
  static const home = "home";
  static const addExpense = "addExpense";
  static const editExpense = "editExpense";
  static const allExpenses = "allExpenses";

  static Route<dynamic> onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeMain());

      case addExpense:
        return MaterialPageRoute(builder: (_) => const AddExpense());

      case allExpenses:
        return MaterialPageRoute(builder: (_) => const AllExpenses());

      case editExpense:
        return MaterialPageRoute(
            builder: (_) =>
                EditExpense(model: route.arguments as ExpenseModel));

      default:
        throw RouteFailure(message: route.name ?? "", "route not found");
    }
  }
}
