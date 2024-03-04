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

class LoginController extends GetxController {

  late AuthRemote authRemote;
  late SharedPreferencesService sharedService;
  late GlobalKey<FormState> formKey;
  late TextEditingController phoneNumber;
  late TextEditingController password;
  late bool isHidePassword;
  StatusView statusView=StatusView.none;
  String? garde;

  @override
  void onInit() async {
    super.onInit();
    formKey = GlobalKey<FormState>();
    authRemote = AuthRemote(Get.find());
    sharedService =Get.find();
    phoneNumber = TextEditingController();
    password = TextEditingController();
    isHidePassword = true;
    garde=sharedService.sharedPreferences.getString(AppSharedKeys.garde);
  }

  void login() async {
    printNote('Start login Controller');
    if (formKey.currentState!.validate()) {
      statusView = StatusView.loading;
      update();
      if(garde=='Expert'){
        var response = await authRemote.loginExpert(phoneNumber.text, password.text);
        if(response is! StatusView){
          if (response['status'] == StatusCodeRequest.ok) {
            appendExpertData(response);
            Get.offAllNamed(AppPagesRoutes.expertHome);
          }else if (response['status'] == StatusCodeRequest.unauthorised){
            Get.snackbar(
              AppTranslationKeys.passwordNotCorrect.tr,
              AppTranslationKeys.pleaseTryAgain.tr,
              icon: const Icon(
                Icons.error,
                color: AppColors.white,
              ),
              backgroundColor: AppColors.red,
            );
            statusView = StatusView.none;
          } else if (response['status'] == StatusCodeRequest.badRequest){
            Get.snackbar(
              AppTranslationKeys.phoneNumberNotFound.tr,
              AppTranslationKeys.pleaseTryAgain.tr,
              icon: const Icon(Icons.error,color: AppColors.white,),
              backgroundColor: AppColors.red,
            );
            statusView = StatusView.none;
          }
        }else{
          statusView = StatusView.serverFailure;
        }
      }else if(garde=='User'){
        var response = await authRemote.loginUser(phoneNumber.text, password.text);
        if(response is! StatusView){
          if (response['status'] == StatusCodeRequest.ok) {
            appendUserData(response);
            Get.offAllNamed(AppPagesRoutes.userHome);
          } else if (response['status'] == StatusCodeRequest.unauthorised){
            Get.snackbar(
              AppTranslationKeys.passwordNotCorrect.tr,
              AppTranslationKeys.pleaseTryAgain.tr,
              icon: const Icon(
                Icons.error,
                color: AppColors.white,
              ),
              backgroundColor: AppColors.red,
            );
            statusView = StatusView.none;
          }else if (response['status'] == StatusCodeRequest.badRequest){
            Get.snackbar(
              AppTranslationKeys.phoneNumberNotFound.tr,
              AppTranslationKeys.pleaseTryAgain.tr,
              icon: const Icon(Icons.error,color: AppColors.white,),
              backgroundColor: AppColors.red,
            );
            statusView = StatusView.none;
          }
        }else{
          statusView = StatusView.serverFailure;
        }}
      update();
    }
  }

  void appendExpertData(response){
    sharedService.sharedPreferences.setInt(AppSharedKeys.expertId, response['data']['id']) ;
    sharedService.sharedPreferences.setString(AppSharedKeys.rememberToken, response['data']['remember_token']) ;
    sharedService.sharedPreferences.setBool(AppSharedKeys.isAuthenticated, true);
    sharedService.sharedPreferences.setBool(AppSharedKeys.isPassAddInfo, true);
  }
  void appendUserData(response){
    sharedService.sharedPreferences.setInt(AppSharedKeys.userId, response['data']['id']) ;
    sharedService.sharedPreferences.setString(AppSharedKeys.rememberToken, response['data']['remember_token']) ;
    sharedService.sharedPreferences.setBool(AppSharedKeys.isAuthenticated, true);
  }

  void goToRegisterUp() {
    Get.offNamed(AppPagesRoutes.register);
  }
  void showPassword() {
    isHidePassword = isHidePassword == true ? false : true;
    update();
  }
}
