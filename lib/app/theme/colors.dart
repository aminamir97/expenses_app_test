import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF438883);
  static const accent = Color(0xFF0893EA);
  static const accentDark = Color(0xFF276bfd);
  static const black = Color(0xFF0E0E0E);
  static const white = Color(0xFFFFFFFF);
  static const error = Color(0xFFD32F2F);

  static const subtitle = Color(0xFFD9D9D9);
  static const cardDark = Color(0xFF262A34);
  static const chalky = Color(0xFFE5D78E);
  static const background = Color(0xFFEBF9F5);

  static const pink = Color(0xFFEF6CAD);
  static const pinkDark = Color(0xFFFF5E57);

  static const green = Color(0xFF5BBC7B);
  static const greenLight = Color(0xFF69C187);
  static const greenDark = Color(0xFF336E45);

  static const orange = Color(0xFFFBCA00);
  static const orangeLight = Color(0xFFF5B556);
  static const orangeDark = Color(0xFFEA8B43);

  static const blue = Color(0xFF4382EE);
  static const blueDark = Color(0xFF5273E1);

  static const grey100 = Color(0xFFF8F9FD);
  static const grey200 = Color(0xFFEFF1F8);
  static const grey300 = Color(0xFFE3E5ED);
  static const grey400 = Color(0xFFD2D5DF);
  static const grey500 = Color(0xFFB7BAC9);
  static const grey600 = Color(0xFF999DAE);
  static const grey700 = Color(0xFF767B92);
  static const grey800 = Color(0xFF545C7C);
  static const grey900 = Color(0xFF161F42);

  static const gradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
}
