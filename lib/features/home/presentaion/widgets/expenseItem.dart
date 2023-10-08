import 'dart:math';

import 'package:expenses_app/app/paddings.dart';
import 'package:expenses_app/app/theme/colors.dart';
import 'package:expenses_app/app/theme/fonts.dart';
import 'package:expenses_app/core/extensions/context_ext.dart';
import 'package:expenses_app/features/home/controller/expensesController.dart';
import 'package:expenses_app/features/home/models/expenseModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseModel model;
  ExpenseItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    var cont = context.watch<ExpensesController>();

    Random random = new Random();
    var imgName = "assets/images/cat${random.nextInt(4) + 1}.png";

    return Dismissible(
      key: Key("item${model.id}"),
      resizeDuration: const Duration(microseconds: 2),
      background: Container(
        color: AppColors.primary,
        child: const Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Icon(Icons.edit_document, color: Colors.white),
              SizedBox(
                width: 8.0,
              ),
              Text('Go to Edit', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.delete, color: Colors.white),
              SizedBox(
                width: 8.0,
              ),
              Text('Move to trash', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
      onDismissed: (DismissDirection direction) async {
        await cont.deleteExpense(model.id!);
      },
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          return await showDialog(
            context: cont.navigation.context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Edit this Expense"),
                content: const Text(
                    "Are you sure you want to edit this expense item"),
                actions: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        context.push("editExpense", arguments: model);
                      },
                      child: const Text("Yes")),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("No"),
                  ),
                ],
              );
            },
          );
        } else {
          return await showDialog(
            context: cont.navigation.context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Remove Expense"),
                content: const Text(
                    "Are you sure you want to remove this expense item?"),
                actions: <Widget>[
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Yes")),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("No"),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Container(
          margin: AppPaddings.smallY,
          height: 50.h,
          child: Row(
            children: [
              //img
              Container(
                  height: 50.h,
                  padding: EdgeInsets.all(10.w),
                  decoration: ShapeDecoration(
                    color: Color(0xFFF0F6F5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Image.asset(imgName)),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    model.title!,
                    style: AppFonts.body2.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    model.showDate,
                    style: AppFonts.small.copyWith(
                      color: Color(0xFF666666),
                    ),
                  )
                ],
              ),
              //expense value
              const Spacer(),
              Text(
                "\$${model.amount}",
                style: AppFonts.headline6.copyWith(color: Colors.green),
              )
            ],
          )),
    );
  }
}
