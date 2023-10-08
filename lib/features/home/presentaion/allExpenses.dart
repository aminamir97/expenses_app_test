import 'package:expenses_app/app/assets.dart';
import 'package:expenses_app/app/paddings.dart';
import 'package:expenses_app/app/theme/colors.dart';
import 'package:expenses_app/app/theme/fonts.dart';
import 'package:expenses_app/core/extensions/context_ext.dart';
import 'package:expenses_app/core/extensions/datetime_ext.dart';
import 'package:expenses_app/core/utils/overlay_service.dart';
import 'package:expenses_app/features/home/controller/expensesController.dart';
import 'package:expenses_app/features/home/models/expenseModel.dart';
import 'package:expenses_app/features/home/presentaion/widgets/customTextField.dart';
import 'package:expenses_app/features/home/presentaion/widgets/exopensesList.dart';
import 'package:expenses_app/features/home/presentaion/widgets/noData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

class AllExpenses extends StatefulWidget {
  const AllExpenses({super.key});

  @override
  State<AllExpenses> createState() => _AllExpensesState();
}

class _AllExpensesState extends State<AllExpenses> {
  DateTime? filteredMonth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<ExpensesController>();

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: AppPaddings.smallX,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.homeHeader),
                  alignment: Alignment.topCenter)),
          child: Column(children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              "All Expenses",
              style: AppFonts.subtitle1,
            ),
            SizedBox(height: 50.h),
            Expanded(
              child: Container(
                  padding: AppPaddings.small,
                  width: double.maxFinite,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 35,
                        offset: Offset(0, 22),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: AppPaddings.small,
                              decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  shape: BoxShape.rectangle),
                              child: Row(
                                children: [
                                  if (filteredMonth != null)
                                    GestureDetector(
                                      onTap: () {
                                        filteredMonth = null;
                                        controller.resetFilter();
                                      },
                                      child: const Icon(
                                        Icons.cancel,
                                        color: Colors.white,
                                      ),
                                    ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    filteredMonth?.dateFormated ??
                                        "Selected Filter goes here",
                                    style: AppFonts.subtitle2,
                                  ),
                                ],
                              )),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(
                              Icons.filter_list_sharp,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              filteredMonth = await showMonthYearPicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 1095)),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 1095)));
                              if (filteredMonth != null) {
                                print("selected month ${filteredMonth!.month}");
                                controller
                                    .filterExpensesOnMonth(filteredMonth!);
                              }

                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      Divider(),
                      controller.filteredExpenses.isEmpty
                          ? NoData()
                          : ExpensesList(
                              isFiltered: true,
                            )
                    ],
                  )),
            ),
          ])),
    ));
  }
}
