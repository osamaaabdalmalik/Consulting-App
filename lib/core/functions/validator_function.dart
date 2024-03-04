
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:get/get.dart';

abstract class Validate {
  static const String none='';
  static const String phone='phone';
  static const String num='num';
  static const String negativeNum='negativeNum';
  static const String positiveNum='positiveNum';

  static String? valid(String val, {String type=none,int min=5,int max=20}) {
    if (val.isEmpty) {
      return AppTranslationKeys.cannotBeEmpty.tr;
    }
    if(type == phone && !GetUtils.isPhoneNumber(val)) {
      return AppTranslationKeys.phoneNumberNotValid.tr;
    }
    if(type == positiveNum) {
      if (!GetUtils.isNum(val)) {
        return AppTranslationKeys.numberNotValid.tr;
      }
      if (double.parse(val) < 0) {
        return AppTranslationKeys.numberNotBeNegative.tr;
      }
    }
    if(val.length < min) {
      return "${AppTranslationKeys.numberNotBeSmaller.tr} $min";
    }
    if(val.length > max) {
      return "${AppTranslationKeys.numberNotBeGreater.tr} $max";
    }
    return null;
  }
}



