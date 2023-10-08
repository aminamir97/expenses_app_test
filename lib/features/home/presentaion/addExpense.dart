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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  var key = GlobalKey<FormState>();
  Map formData = {"title": null, "amount": null, "date": null};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: AppPaddings.normalX,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.homeHeader),
                  alignment: Alignment.topCenter)),
          child: Column(children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    context.pop();
                  },
                  color: Colors.white,
                ),
                Text(
                  "Add New Expense",
                  style: AppFonts.subtitle1,
                ),
                SizedBox(),
              ],
            ),
            SizedBox(height: 100.h),
            Container(
              padding: AppPaddings.small,
              width: 358,
              height: 500,
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
              child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Input Fields:",
                        style: AppFonts.subtitle1.copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextField(
                        hint: "Expense Title",
                        icon: const Icon(Icons.text_fields_rounded),
                        validator: (x) {
                          if (x!.isEmpty) return "must have a value";
                        },
                        onSaved: (x) {
                          formData["title"] = x;
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomTextField(
                        textInputType:
                            TextInputType.numberWithOptions(decimal: true),
                        hint: "Expense Amount",
                        icon: const Icon(Icons.monetization_on_rounded),
                        validator: (x) {
                          //checking if int entered
                          var checkerInt = int.tryParse(x!);
                          if (x.isEmpty || checkerInt == null)
                            return "must have a value";
                        },
                        onSaved: (x) {
                          formData["amount"] = int.parse(x!);
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var currentDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate:
                                  DateTime.now().subtract(Duration(days: 365)),
                              lastDate:
                                  DateTime.now().add(Duration(days: 365)));
                          formData["date"] =
                              currentDate!.millisecondsSinceEpoch;
                          setState(() {});
                        },
                        child: Container(
                          padding: AppPaddings.small,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFDDDDDD)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formData["date"] == null
                                    ? "Expense Date"
                                    : DateTime.fromMillisecondsSinceEpoch(
                                            formData["date"])
                                        .dateFormated,
                                style: AppFonts.subtitle1.copyWith(
                                  color: formData["date"] == null
                                      ? AppColors.grey600
                                      : AppColors.black,
                                ),
                              ),
                              const Icon(
                                Icons.date_range_rounded,
                                color: AppColors.grey600,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: ElevatedButton(
                              onPressed: () {
                                if (key.currentState!.validate() &&
                                    formData["date"] != null) {
                                  key.currentState!.save();
                                  print(formData);
                                  addNewExpense(context, formData);
                                } else {
                                  OverlayService.instance.showError(
                                      "please fill all the required fields");
                                }
                              },
                              child: Text(
                                "Add Expense",
                                style: AppFonts.subtitle1,
                              ))),
                    ],
                  )),
            ),
          ])),
    ));
  }
}

void addNewExpense(BuildContext ctx, Map form) async {
  var x = ExpenseModel(DateTime.now().millisecondsSinceEpoch, form["title"],
      form["amount"], form["date"]);
  await ctx.read<ExpensesController>().addNewExpense(x);
  ctx.pop();
}
