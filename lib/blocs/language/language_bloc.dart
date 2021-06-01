import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:business/utils/share_pref_service.dart';
import 'package:flutter/services.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc(LanguageState initialState) : super(initialState);

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is LanguageLoadStarted) {
      yield* _mapLanguageLoadStartedToState();
    } else if (event is LanguageSelected) {
      yield* _mapLanguageSelectedToState(event.languageCode);
    }
  }

  Stream<LanguageState> _mapLanguageLoadStartedToState() async* {
    final sharedPrefService = await SharedPreferencesService.instance;

    final defaultLanguageCode = sharedPrefService.languageCode;
    Locale locale;
    String localeLanguageJson;
    if (defaultLanguageCode == null) {
      locale = Locale('en', 'EN');
      localeLanguageJson = await getLanguageJson("en");
      await sharedPrefService.setLanguage(locale.languageCode);
    } else {
      locale = Locale(defaultLanguageCode);
      localeLanguageJson = await getLanguageJson(defaultLanguageCode);
    }

    yield LanguageState(locale: locale, localeLanguageJson: localeLanguageJson);
  }

  Stream<LanguageState> _mapLanguageSelectedToState(
      String selectedLanguage) async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    final defaultLanguageCode = sharedPrefService.languageCode;

    if (selectedLanguage == "en" && defaultLanguageCode != 'en') {
      yield* _loadLanguage(sharedPrefService, 'en', 'EN');
    } else if (selectedLanguage == "th" && defaultLanguageCode != 'th') {
      yield* _loadLanguage(sharedPrefService, 'th', 'TH');
    } else if (selectedLanguage == "lo" && defaultLanguageCode != 'lo') {
      yield* _loadLanguage(sharedPrefService, 'lo', 'LO');
    } else if (selectedLanguage == "km" && defaultLanguageCode != 'km') {
      yield* _loadLanguage(sharedPrefService, 'km', 'LM');
    }
  }

  /// This method is added to reduce code repetition.
  Stream<LanguageState> _loadLanguage(
      SharedPreferencesService sharedPreferencesService,
      String languageCode,
      String countryCode) async* {
    final locale = Locale(languageCode, countryCode);
    await sharedPreferencesService.setLanguage(locale.languageCode);
    var localeLanguageJson = await getLanguageJson(locale.languageCode);
    yield LanguageState(localeLanguageJson: localeLanguageJson, locale: locale);
  }

  Future<String> getLanguageJson(String languageCode) async {
    var data = await rootBundle.loadString('assets/langs/$languageCode.json');
    return data;
  }
}
