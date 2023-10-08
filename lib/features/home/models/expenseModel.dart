import 'package:expenses_app/core/extensions/datetime_ext.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExpenseModel extends HiveObject {
  int? id;
  String? title;
  int? amount;
  int? date;

  ExpenseModel(int this.id, String this.title, int this.amount, int this.date);

  Map toMap() {
    return {"id": id, "title": title, "amount": amount, "date": date};
  }

  factory ExpenseModel.fromMap(Map obj) {
    return ExpenseModel(obj["id"], obj["title"], obj["amount"], obj["date"]);
  }

  String get showDate {
    return DateTime.fromMillisecondsSinceEpoch(date!).dateFormated;
  }
}
