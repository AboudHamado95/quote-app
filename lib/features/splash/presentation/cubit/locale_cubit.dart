import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/core/usecases/usecases.dart';

import 'package:flutter_app3/core/utils/app_strings.dart';
import 'package:flutter_app3/features/splash/domain/usecases/change_lang.dart';
import 'package:flutter_app3/features/splash/domain/usecases/get_saved_lang.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  ChangeLangUseCase changeLangUseCase;
  GetSavedLangUseCase getSavedLangUseCase;
  LocaleCubit(
      {required this.changeLangUseCase, required this.getSavedLangUseCase})
      : super(const ChangeLocaleState(Locale(AppStrings.englishCode)));

//get saved language
  String currentLangCode = AppStrings.englishCode;

  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure),
        (value) => currentLangCode = value);
    emit(ChangeLocaleState(Locale(currentLangCode)));
  }

  Future<void> _changeLang(String langCode) async {
    final response = await changeLangUseCase.call(langCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure),
        (value) => currentLangCode = langCode);
    emit(ChangeLocaleState(Locale(currentLangCode)));
  }

// change Locale

  void toEnglish() => _changeLang(AppStrings.englishCode);

  void toArabic() => _changeLang(AppStrings.arabicCode);
}
