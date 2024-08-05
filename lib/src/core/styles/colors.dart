import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tekflat_design/tekflat_design.dart';

class AppColors {
  static Color light = TekColors().white;
  static const Color iconColor = Color(0xff5b5a5a);
  static const Color textPrimary = Color(0xFF000000);
  static Color textSecondary = const Color.fromRGBO(0, 0, 0, 0.45);

  static const Color chartBorderColor = Color(0xffD9D9D9);

  static const Color transactionBgIconColor = Color(0xfff4fbfd);

  // Background
  static const Color tooltipBg = Color.fromRGBO(0, 0, 0, 0.88);
  static const Color bgMask = Color.fromRGBO(0, 0, 0, 0.45);
  static const Color boxShadowSecondary1 = Color.fromRGBO(0, 0, 0, 0.05);
  static const Color boxShadowSecondary2 = Color.fromRGBO(0, 0, 0, 0.12);

  static const Color muted = Color.fromRGBO(0, 0, 0, 1);
  static const Color secondary = Color(0xFFF5F5F5);
  static const Color baseStrong = Color.fromRGBO(0, 0, 0, 0.25);

  /// For global theme
  static const Color dividerColor = Color.fromRGBO(0, 0, 0, 0.06);

  static const Color bgPrimaryThemeLight = Color(0xFFF5F5F5);

  static const Color black = Color(0xFF212533);

  /// For app style text, icon
  static const Color iconSecondary = Color.fromRGBO(0, 0, 0, 0.45);

  /// For app others color
  static const Color borderColor = Color.fromRGBO(0, 0, 0, 0.15);

  static const Color starColor = Color(0xFFFADB14);
  static const Color starDisabledColor = Color(0xFFDCDEE9);
  static const Color errorColor = Color(0xFFCF1322);

  static const Color green = Color(0xFF29CC6A);
  static const Color red = Color(0xFFF5222D);
}

Color $getColorFromFirstCharacter(String? firstCharacter) {
  switch (firstCharacter?.toUpperCase()) {
    case "A":
      return const Color(0xFFE57373);
    case "B":
      return const Color(0xFFBA68C8);
    case "C":
      return const Color(0xFF7986CB);
    case "D":
      return const Color(0xFF64B5F6);
    case "E":
      return const Color(0xFF4DD0E1);
    case "F":
      return const Color(0xFF4DB6AC);
    case "G":
      return const Color(0xFF81C784);
    case "H":
      return const Color(0xFFAED581);
    case "I":
      return const Color(0xFFFFD54F);
    case "J":
      return const Color(0xFFFFB74D);
    case "K":
      return const Color(0xFFFF8A65);
    case "L":
      return const Color(0xFFA1887F);
    case "M":
      return const Color(0xFF90A4AE);
    case "N":
      return const Color(0xFF78909C);
    case "O":
      return const Color(0xFFE0E0E0);
    case "P":
      return const Color(0xFFE57373);
    case "Q":
      return const Color(0xFFBA68C8);
    case "R":
      return const Color(0xFF7986CB);
    case "S":
      return const Color(0xFF64B5F6);
    case "T":
      return const Color(0xFF4DD0E1);
    case "U":
      return const Color(0xFF4DB6AC);
    case "V":
      return const Color(0xFF81C784);
    case "W":
      return const Color(0xFFAED581);
    case "X":
      return const Color(0xFFFFD54F);
    case "Y":
      return const Color(0xFFFFB74D);
    case "Z":
      return const Color(0xFFFF8A65);
    default:
      return const Color(0xFFE0E0E0);
  }
}