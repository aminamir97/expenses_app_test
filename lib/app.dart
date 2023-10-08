import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'app/constants.dart';
import 'app/routes.dart';
import 'app/theme/theme.dart';
import 'core/utils/navigation_service.dart';
import 'core/utils/overlay_service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<AppTheme>().setPlatformTheme();
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: AppConstants.title,
      theme: context.watch<AppTheme>().currentTheme,
      initialRoute: AppRoutes.initial,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      scaffoldMessengerKey: OverlayService.instance.scaffoldKey,
      navigatorKey: NavigationService.instance.navKey,
    );
  }
}
