class AppLanguages {
  /// Language in my app
  static List<AppLanguagesLocal> languages = [
    AppLanguagesLocal(code: 'en', value: 'English'),
    AppLanguagesLocal(code: 'ar', value: 'arabic'),
  ];
}

class AppLanguagesLocal {
  final String code;
  final String value;

  AppLanguagesLocal({
    required this.code,
    required this.value,
  });
}
