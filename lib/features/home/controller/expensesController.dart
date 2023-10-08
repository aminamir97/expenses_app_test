import 'package:expenses_app/core/extensions/datetime_ext.dart';
import 'package:expenses_app/core/utils/database_api.dart';
import 'package:expenses_app/core/utils/navigation_service.dart';
import 'package:expenses_app/core/utils/overlay_service.dart';
import 'package:expenses_app/features/home/models/chartModel.dart';
import 'package:expenses_app/features/home/models/expenseModel.dart';
import 'package:flutter/foundation.dart';

class ExpensesController extends ChangeNotifier {
  List<ExpenseModel> expenses = [];
  List<ExpenseModel> filteredExpenses = [];

  bool loading = true;
  final overlay = OverlayService.instance;
  final navigation = NavigationService.instance;
  final DatabaseApi databaseApi;
  bool testing = false;

  ExpensesController({required this.databaseApi});

  Future addNewExpense(ExpenseModel newExpense) async {
    expenses.add(newExpense);
    await dbSync();
    overlay.showSnackbar("Expense Added successfully");
    expensesSorter();
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
    return true;
  }

  int totalExpenses() {
    int total = 0;
    expenses.forEach((element) {
      total += element.amount!;
    });

    return total;
  }

  void expensesSorter() {
    expenses.sort(
      (a, b) {
        return DateTime.fromMillisecondsSinceEpoch(b.date!)
            .compareTo(DateTime.fromMillisecondsSinceEpoch(a.date!));
      },
    );
    notifyListeners();
  }

  Future editExpense(ExpenseModel model) async {
    int itemIndex = expenses.indexWhere((element) => model.id == element.id);
    expenses[itemIndex].title = model.title;
    expenses[itemIndex].amount = model.amount;
    expenses[itemIndex].date = model.date;
    await dbSync();
    expensesSorter();

    notifyListeners();
  }

  Future fetchAllExpenses() async {
    expenses = [];
    List allItemsAsMaps = (databaseApi.getExpenses());
    for (var element in allItemsAsMaps) {
      expenses.add(ExpenseModel.fromMap(element));
    }
    filteredExpenses = expenses;
    loading = false;
    notifyListeners();
  }

  void filterExpensesOnMonth(DateTime monthDate) {
    filteredExpenses = [];
    filteredExpenses = expenses
        .where((element) =>
            DateTime.fromMillisecondsSinceEpoch(element.date!).month ==
            monthDate.month)
        .toList();
    notifyListeners();
  }

  void resetFilter() {
    filteredExpenses = expenses;
    notifyListeners();
  }

  Future deleteExpense(int id) async {
    expenses.removeWhere((element) => id == element.id);
    await dbSync();
    notifyListeners();
  }

  Future dbSync() async {
    if (!testing) {
      List<Map> list = [];
      expenses.forEach((element) {
        list.add(element.toMap());
      });
      await databaseApi.syncExpenses(list);
    }
    print("Testing mood");
  }

  List<ChartDataModel> getWeeklyData() {
    List<ChartDataModel> week = [];
    var dateTime = DateTime.now();
    var startDate = dateTime.subtract(Duration(days: dateTime.weekday - 1));
    var endDate = startDate.add(Duration(days: 6));
    print(endDate.difference(startDate).inDays);

    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      var dayDate = startDate.add(Duration(days: i));

      var totalSpentAmount = 0;
      expenses.forEach((element) {
        if (DateTime.fromMillisecondsSinceEpoch(element.date!).day ==
            (dayDate.day)) {
          totalSpentAmount += element.amount!;
        }
      });
      var newItem = ChartDataModel(
          id: i, date: dayDate.dateFormatedShort, amount: totalSpentAmount);
      week.add(newItem);
    }

    week.forEach((element) {
      print(element.date);
      print(element.amount);
      print("\n");
    });

    return week;
  }
}
