import 'package:expenses_app/features/home/controller/expensesController.dart';
import 'package:expenses_app/features/home/presentaion/widgets/expenseItem.dart';
import 'package:expenses_app/features/home/presentaion/widgets/noData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenses_app/app/paddings.dart';
import 'package:expenses_app/app/theme/colors.dart';
import 'package:expenses_app/app/theme/fonts.dart';
import 'package:expenses_app/core/extensions/context_ext.dart';
import 'package:expenses_app/features/home/controller/expensesController.dart';
import 'package:expenses_app/features/home/models/expenseModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExpensesList extends StatefulWidget {
  bool isFiltered = false;
  ExpensesList({super.key, this.isFiltered = false});

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    var controller = context.watch<ExpensesController>();

    return Expanded(
        child: Container(
            padding: AppPaddings.normalX,
            width: double.infinity,
            child: ListView.builder(
              itemCount: widget.isFiltered
                  ? controller.filteredExpenses.length
                  : controller.expenses.length,
              itemBuilder: (context, index) {
                return ExpenseItem(
                    model: widget.isFiltered
                        ? controller.filteredExpenses[index]
                        : controller.expenses[index]);
              },
            )));
  }
}
