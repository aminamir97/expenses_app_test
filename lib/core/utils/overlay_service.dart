import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';

class OverlayService {
  static final instance = OverlayService._();
  OverlayService._();

  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void showSnackbar(String message, {Color color = AppColors.primary}) {
    scaffoldKey.currentState?.removeCurrentSnackBar();
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        content: SelectableText(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void showError(String message) {
    showSnackbar(message, color: AppColors.error);
  }
}
