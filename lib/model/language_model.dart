class LanguageModel {
  String name;
  String code;

  LanguageModel({required this.code, required this.name});
  static List<LanguageModel> languages = [
    LanguageModel(code: 'en', name: 'English'),
    LanguageModel(code: 'ar', name: 'العربية'),
  ];
}
