import 'package:counter/source/core/translations/language_type_enum.dart';
import 'package:flutter/material.dart';

///region const translation
const String arabic = 'ar';
const String english = 'en';
const String assetPathLocalization = 'assets/languages';
const Locale arabicLocal = Locale("ar", "SA");
const Locale englishLocal = Locale("en", "US");

///endRegion const translation

/// Change language by type
extension LanguageTypeExtention on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.arabic:
        return arabic;
    }
  }
}
