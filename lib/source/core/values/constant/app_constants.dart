import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class AppConstants {
  /// Constant size
  static const Size size150 = Size(150, 150);

  /// Constant Global widget
  static const int maxLines = 1;
  static const String emptyText = '';
  static const double appLoadingOpacity = 0.6;

  /// Constant Border
  static const double border1_5 = 1.5;
  static const double border1_2 = 1.2;

  /// Constant opacity
  static const double opacity00 = 0.0;
  static const double opacity0_5 = 0.5;
  static const double opacity0_6 = 0.6;
  static const double opacity0_7 = 0.7;
  static const double opacity01 = 1.0;

  /// Constant duration
  static const int duration00 = 0;
  static const int duration02 = 2;
  static const int duration15 = 15;
  static const int duration100 = 100;
  static const int duration150 = 150;
  static const int duration300 = 300;
  static const int duration400 = 400;
  static const int duration500 = 500;
  static const int duration600 = 600;
  static const int duration800 = 800;
  static const int duration1000 = 1000;
  static const int duration1200 = 1200;
  static const int duration2500 = 2500;
  static const int duration2000 = 2000;
  static const int duration40000 = 40000;

  /// Constant offsets
  static const Offset offset10 = Offset(10, 10);
  static const Offset offset00 = Offset(0, 0);
  static const Offset offset0_1 = Offset(0, -1);

  /// Constant transform
  static const double transform12 = 12;
  static const double transform18 = 18;

  /// Constant cross
  static const double cross3_8 = 3.8;
  static const int cross04 = 4;
  static const double cross7_8 = 7.8;
  static const int cross12 = 12;
  static const int cross14 = 14;
  static const int cross16 = 16;
  static const int cross20 = 20;
  static const int cross40 = 40;

  /// Constant Main Axis
  static const double mainAxis4 = 4;
  static const double mainAxis5 = 5;
  static const double mainAxis8 = 8;

  /// Constant indexes
  static const int index01 = 1;
  static const int index05 = 5;
  static const int index06 = 6;
  static const int index07 = 7;

  /// Constant Tween
  static const double tween00 = 0;
  static const double tween0_9 = 0.9;
  static const double tween1_1 = 1.1;
  static const double tween12 = 12;

  /// Constant code
  static const int code_1 = -1;
  static const int code200 = 200;
  static const int code400 = 400;
  static const int code401 = 401;
  static const int code403 = 403;
  static const int code404 = 404;
  static const int code409 = 409;
  static const int code500 = 500;
  static const int code503 = 503;
  static const int code601 = 601;
  static const int code602 = 602;
  static const int code603 = 603;
  static const int code604 = 604;
  static const int code605 = 605;

  static List<String> gateSettingsItems = [
    AppStrings.off.t(),
    AppStrings.autoSync.t(),
    AppStrings.autoDeSync.t(),
    AppStrings.onPrompt.t(),
    AppStrings.normal.t(),
  ];

  static List<String> piecesSizeItems = [
    AppStrings.custom.t(),
    AppStrings.auto.t(),
    AppStrings.manual.t(),
  ];

  static List<String> piecesAutoItems = [
    'M1...0.5',
    'M2...1.0',
    'M3...1.5',
    'M4...2.0',
  ];
}
