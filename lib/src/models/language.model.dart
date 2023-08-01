import 'dart:ui';

class Language {
  final String title;
  final Locale locale;

  Language(this.title, this.locale);

  @override
  bool operator ==(Object other) {
    return (other is Language) && other.title == title;
  }

  @override
  String toString() {
    return '$title-$locale';
  }

  factory Language.fromStore(String lang) {
    return Language(lang.split('-')[0], Locale(lang.split('-')[1]));
  }
}
