import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_pages_routes.dart';
import 'package:consultancy/core/constant/app_shared_keys.dart';
import 'package:consultancy/core/constant/app_status_code_request.dart';
import 'package:consultancy/core/constant/app_status_views.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/core/functions/helper_function.dart';
import 'package:consultancy/core/services/shared_preferences_service.dart';
import 'package:consultancy/data/datasource/remote/auth_remote.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  late AuthRemote authRemote;
  late SharedPreferencesService sharedService;
  late GlobalKey<FormState> formKey;
  late TextEditingController name,phoneNumber,password, confirmPassword;
  StatusView statusView=StatusView.none;
  bool isHidePassword=true;
  bool isHideConfirmPassword=true;
  String? garde;

  @override
  void onInit() async {
    super.onInit();
    formKey = GlobalKey<FormState>();
    name = TextEditingController();
    phoneNumber = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    authRemote = AuthRemote(Get.find());
    sharedService = Get.find();
    garde=sharedService.sharedPreferences.getString(AppSharedKeys.garde);
  }

  register() async {
    printNote('Start register Controller');
    if (formKey.currentState!.validate() && validatePasswordAndConfirm()) {
      statusView = StatusView.loading;
      update();
      if(garde=='Expert'){
        var response = await authRemote.registerExpert(name.text, phoneNumber.text, password.text,confirmPassword.text);
        if(response is! StatusView){
          if (response['status'] == StatusCodeRequest.ok) {
            appendExpertData(response);
            Get.offAllNamed(AppPagesRoutes.addInfo);
          } else if (response['status'] == StatusCodeRequest.badRequest){
            Get.snackbar(
              AppTranslationKeys.phoneNumberAlreadyExist.tr,
              AppTranslationKeys.pleaseGoToLogin.tr,
              icon: const Icon(Icons.error,color: AppColors.white,),
              backgroundColor: AppColors.red,
            );
            statusView = StatusView.none;
          }
        }else{
          statusView = StatusView.serverFailure;
        }
      }else if(garde=='User'){
        var response = await authRemote.registerUser(name.text, phoneNumber.text, password.text,confirmPassword.text);
        if(response is! StatusView){
          if (response['status'] == StatusCodeRequest.ok) {
            appendUserData(response);
            Get.offAllNamed(AppPagesRoutes.userHome);
          } else if (response['status'] == StatusCodeRequest.badRequest){
            Get.showSnackbar(
                GetSnackBar(
                  title: 'data not valid',
                  message: "${response['message']}",
                  backgroundColor: AppColors.red,
                ));
          }
        }else{
          statusView = StatusView.serverFailure;
        }
      }
    }
    update();
  }

  void appendExpertData(response){
    sharedService.sharedPreferences.setInt(AppSharedKeys.expertId, response['data']['id']) ;
    sharedService.sharedPreferences.setString(AppSharedKeys.rememberToken, response['data']['remember_token']) ;
    sharedService.sharedPreferences.setBool(AppSharedKeys.isAuthenticated, true);
    sharedService.sharedPreferences.setBool(AppSharedKeys.isPassAddInfo, false);
  }
  void appendUserData(response){
    sharedService.sharedPreferences.setInt(AppSharedKeys.userId, response['data']['id']) ;
    sharedService.sharedPreferences.setString(AppSharedKeys.rememberToken, response['data']['remember_token']) ;
    sharedService.sharedPreferences.setBool(AppSharedKeys.isAuthenticated, true);
  }
  goToSignIn() {
    Get.offNamed(AppPagesRoutes.login);
  }
  showPassword() {
    isHidePassword = isHidePassword == true ? false : true;
    update();
  }
  showConfirmPassword() {
    isHideConfirmPassword = isHideConfirmPassword == true ? false : true;
    update();
  }
  validatePasswordAndConfirm(){
    if(password.text != confirmPassword.text){
      Get.snackbar(
        AppTranslationKeys.passwordAndConfirmNotMatch.tr,
        AppTranslationKeys.pleaseTryAgain.tr,
        icon: const Icon(Icons.error,color: AppColors.white,),
        backgroundColor: AppColors.red,
      );
      statusView = StatusView.none;
      return false;
    }
    return true;
  }
}
