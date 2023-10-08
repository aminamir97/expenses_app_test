import 'package:flutter/material.dart';

class NavigationService {
  static final instance = NavigationService._();
  NavigationService._();

  final navKey = GlobalKey<NavigatorState>();

  BuildContext get context => navKey.currentContext!;

  void showLoadingIndicator([bool critical = false]) {
    final context = navKey.currentState?.overlay?.context;
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: !critical,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
