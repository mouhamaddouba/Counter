import 'package:flutter/foundation.dart';

loggerExtension(
  Object? text, {
  Logger textColor = Logger.magenta,
  Logger aroundColor = Logger.blue,
}) {
  if (kDebugMode) {
    print(
      '\x1B[${aroundColor.code}m <<<<<<<<<<<<<<< \x1B[0m\x1B[${textColor.code}m$text\x1B[0m\x1B[${aroundColor.code}m >>>>>>>>>>>>>>> \x1B[0m',
    );
  }
}

enum Logger {
  black("30"),
  red("31"),
  green("32"),
  yellow("33"),
  blue("34"),
  magenta("35"),
  cyan("36"),
  white("37");

  final String code;

  const Logger(this.code);
}
