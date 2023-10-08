// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:expenses_app/core/utils/database_api.dart';
import 'package:expenses_app/features/home/controller/expensesController.dart';
import 'package:expenses_app/features/home/models/expenseModel.dart';
import 'package:expenses_app/injections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expenses_app/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final List<ExpenseModel> testExpensesList = [
    ExpenseModel(1, "new Expenses", 10, DateTime.now().millisecondsSinceEpoch),
    ExpenseModel(2, "new Expenses", 20,
        DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch),
    ExpenseModel(3, "new Expenses", 30,
        DateTime.now().add(const Duration(days: 2)).millisecondsSinceEpoch),
    ExpenseModel(4, "new Expenses", 40,
        DateTime.now().add(const Duration(days: 2)).millisecondsSinceEpoch),
    ExpenseModel(5, "new Expenses", 50,
        DateTime.now().add(const Duration(days: 3)).millisecondsSinceEpoch),
    ExpenseModel(6, "new Expenses", 60,
        DateTime.now().add(const Duration(days: 3)).millisecondsSinceEpoch),
    ExpenseModel(7, "new Expenses", 70,
        DateTime.now().add(const Duration(days: 4)).millisecondsSinceEpoch),
    ExpenseModel(8, "new Expenses", 80,
        DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch),
  ];

  group("expenses functionality testing", () {
    //Data preparing
    DatabaseApi db = Injections.instance.databaseApi;
    db.settingBox = MockHiveBox();
    final cont = ExpensesController(databaseApi: db);
    cont.testing = true;

    //test get the expenses
    test("Fetch the expenses", () async {
      await cont.fetchAllExpenses();
      expect(cont.expenses, []);
    });
    //test add new expense
    test("Add new expense", () async {
      var newExpense = ExpenseModel(
          27272, "new Expenses", 20, DateTime.now().millisecondsSinceEpoch);
      await cont.addNewExpense(newExpense);
      expect(cont.expenses.length, 1);
    });
    //test edit a expense
    test("Edit a expense", () async {
      var editedExpense = ExpenseModel(
          27272, "edited Expenses", 30, DateTime.now().millisecondsSinceEpoch);
      await cont.editExpense(editedExpense);
      expect(cont.expenses[0].amount, 30);
    });
    //test delete a expense
    test("Delete a expense", () async {
      await cont.deleteExpense(27272);
      expect(cont.expenses.isEmpty, true);
    });
    //test get total expenses
    test("Get total of the expenses", () async {
      cont.expenses = testExpensesList;
      var total = cont.totalExpenses();
      expect(total, 360);
    });
    //test get weekly Chart data calculated from expenses
    test("Get the weekly chart data", () async {
      cont.expenses = testExpensesList;
      var weeklyList = cont.getWeeklyData();
      expect(weeklyList.length, 7);
    });
  });
}
