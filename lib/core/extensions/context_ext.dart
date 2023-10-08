import 'package:flutter/material.dart';

extension BasicExtOnContext on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;
}

extension NavExtOnContext on BuildContext {
  Future<void> to(Widget screen) async {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  Future<void> push(String appRoute, {Object? arguments}) async {
    Navigator.of(this).pushNamed(appRoute, arguments: arguments);
  }

  Future<void> replace(String appRoute, {Object? arguments}) async {
    await Navigator.of(this).pushReplacementNamed(appRoute, arguments: arguments);
  }

  Future<void> replaceAll(String appRoute, {Object? arguments}) async {
    while (Navigator.of(this).canPop()) {
      Navigator.of(this).pop();
    }
    await Navigator.of(this).pushReplacementNamed(appRoute, arguments: arguments);
  }

  Future<void> pop([bool? result]) async {
    return Navigator.of(this).pop(result);
  }

  Future<void> maybePop([bool? result]) async {
    await Navigator.of(this).maybePop(result);
  }

  void popTillFirst() async {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  bool get canPop {
    return Navigator.of(this).canPop();
  }
}
