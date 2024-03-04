import 'package:consultancy/core/constant/app_shared_keys.dart';
import 'package:consultancy/core/constant/app_themes.dart';
import 'package:consultancy/core/services/shared_preferences_service.dart';
import 'package:consultancy/data/datasource/static/user_home_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  
  Locale? language;
  SharedPreferencesService sharedService = Get.find();
  ThemeData appTheme = AppThemes.themeEnglish;

  @override
  void onInit() {
    String? sharedPrefLang = sharedService.sharedPreferences.getString(AppSharedKeys.lang);
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      appTheme = AppThemes.themeArabic;
      UserHomeData.lang='ar';
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      appTheme = AppThemes.themeEnglish;
      UserHomeData.lang='en';
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      if (Get.deviceLocale!.languageCode == "ar") {
        appTheme = AppThemes.themeArabic;
      } else if (Get.deviceLocale!.languageCode == "en") {
        appTheme = AppThemes.themeEnglish;
      }
      sharedService.sharedPreferences.setString(AppSharedKeys.lang, Get.deviceLocale!.languageCode);
      UserHomeData.lang=Get.deviceLocale!.languageCode;
    }
    super.onInit();
  }

  changeLang() {
    var oldLangCode = sharedService.sharedPreferences.getString(AppSharedKeys.lang) ?? 'ar';
    String newLangCode = oldLangCode=="ar" ?'en':'ar';
    Locale locale = Locale(newLangCode);
    UserHomeData.lang=newLangCode;
    sharedService.sharedPreferences.setString(AppSharedKeys.lang, newLangCode);
    appTheme = newLangCode == "ar" ? AppThemes.themeArabic : AppThemes.themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }
}
