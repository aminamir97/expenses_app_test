import 'package:expenses_app/features/home/models/expenseModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseApi {
  late final HiveInterface hive;

  late Box settingBox;

  Future<void> initDatabase() async {
    await Hive.initFlutter();
    settingBox = await Hive.openBox('settings-box');
  }

  List getExpenses() {
    return settingBox.get('expenses') ?? [];
  }

  Future<void> addExpense(Map expense) async {
    List list = getExpenses();
    list.add(expense);
    await settingBox.put("expenses", list);
    var x = getExpenses();
    print("my new list after adding = ${x}");
    settingBox.flush();
  }

  Future syncExpenses(List expenses) async {
    await settingBox.put("expenses", expenses);
    return true;
  }

  Future<void> setTheme(bool isDark) async {
    await settingBox.put('theme-mode', isDark);
  }

  Future<void> setOnboardingStatus() async {
    await settingBox.put('onboard-status', true);
  }

  Future<bool> getOnboardingStatus() async {
    return settingBox.get('onboard-status') as bool? ?? false;
  }
}
