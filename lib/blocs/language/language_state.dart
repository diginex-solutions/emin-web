part of 'language_bloc.dart';

class LanguageState {
  final Locale locale;
  final String localeLanguageJson;

  const LanguageState({this.locale, this.localeLanguageJson});

  List<Object> get props => [locale, localeLanguageJson];
}
