import 'dart:math';

import 'package:expenses_app/app/assets.dart';
import 'package:expenses_app/app/paddings.dart';
import 'package:expenses_app/app/routes.dart';
import 'package:expenses_app/app/theme/colors.dart';
import 'package:expenses_app/app/theme/fonts.dart';
import 'package:expenses_app/core/extensions/context_ext.dart';
import 'package:expenses_app/core/utils/navigation_service.dart';
import 'package:expenses_app/core/utils/overlay_service.dart';
import 'package:expenses_app/features/home/controller/expensesController.dart';
import 'package:expenses_app/features/home/models/expenseModel.dart';
import 'package:expenses_app/features/home/presentaion/allExpenses.dart';
import 'package:expenses_app/features/home/presentaion/widgets/exopensesList.dart';
import 'package:expenses_app/features/home/presentaion/widgets/noData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      Provider.of<ExpensesController>(context, listen: false)
          .fetchAllExpenses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<ExpensesController>();

    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () {
                context.push(AppRoutes.addExpense);
                // controller.fetchAllExpenses();
              },
              child: const Icon(Icons.add)),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      AppImages.homeHeader,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      left: 25.w,
                      top: 40.h,
                      child: Text(
                        "Good Day",
                        style: AppFonts.subtitle1,
                      ),
                    ),
                    Positioned(
                      left: 25.w,
                      top: 80.h,
                      child: Text(
                        "Mr. New User",
                        style: AppFonts.headline4,
                      ),
                    ),
                    Positioned(
                      bottom: -40.h,
                      left: 30.w,
                      right: 30.w,
                      child: Container(
                        padding: AppPaddings.normal,
                        alignment: Alignment.center,
                        width: 300.w,
                        decoration: ShapeDecoration(
                          shadows: const <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 8.0,
                                offset: Offset(0.0, 0.2))
                          ],
                          color: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Total Expenses",
                                  style: AppFonts.headline6,
                                ),
                                const Icon(
                                  Icons.arrow_drop_up,
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "\$ ${controller.totalExpenses()}",
                              style: AppFonts.headline2,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 60.h,
                ),
                controller.loading
                    ? const Expanded(
                        child: Center(child: CircularProgressIndicator()))
                    : controller.expenses.isEmpty
                        ? const NoData()
                        : Container(
                            padding: AppPaddings.normalX,
                            child: Text(
                              "Transaction History",
                              style: AppFonts.subtitle1
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                SizedBox(
                  height: 20.h,
                ),
                ExpensesList()
              ],
            ),
          )),
    );
  }
}
