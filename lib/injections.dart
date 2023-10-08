import 'package:expenses_app/features/home/controller/expensesController.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'app/theme/theme.dart';
import 'core/utils/database_api.dart';

class Injections {
  Injections._();

  static final instance = Injections._();

  late final providers = [
    Provider<Injections>.value(value: instance),
    ChangeNotifierProvider<AppTheme>(
      create: (_) => AppTheme(databaseApi: databaseApi),
    ),
    ChangeNotifierProvider<ExpensesController>(
      create: (_) => ExpensesController(databaseApi: databaseApi),
    ),
  ];

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await databaseApi.initDatabase();
  }

  final databaseApi = DatabaseApi();
}
