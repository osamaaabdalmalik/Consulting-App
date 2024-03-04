
import 'package:consultancy/controller/auth/login_controller.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/core/functions/validator_function.dart';
import 'package:consultancy/view/widget/app/handling_data_request.dart';
import 'package:consultancy/view/widget/auth/button_auth.dart';
import 'package:consultancy/view/widget/auth/text_auth.dart';
import 'package:consultancy/view/widget/auth/text_body_auth.dart';
import 'package:consultancy/view/widget/auth/text_form_auth.dart';
import 'package:consultancy/view/widget/auth/text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.whiteSecondary,
        elevation: 0.0,
        title: Text(AppTranslationKeys.login.tr,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: AppColors.grey)),
      ),
      body: GetBuilder<LoginController>(
            builder: (controller) => HandlingDataRequest(
                statusView: controller.statusView,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Form(
                    key: controller.formKey,
                    child: ListView(children: [
                      const SizedBox(height: 20),
                      TextTitleAuth(text: AppTranslationKeys.welcomeBack.tr),
                      const SizedBox(height: 10),
                      TextBodyAuth(text: AppTranslationKeys.loginOrRegister.tr),
                      const SizedBox(height: 15),
                      TextFormAuth(
                        isNumber: true,
                        valid: (val) {
                          return Validate.valid(val!,type: Validate.phone,min: 10);
                        },
                        mycontroller: controller.phoneNumber,
                        hinttext: AppTranslationKeys.enterYourPhoneNumber.tr,
                        iconData: Icons.phone_android_outlined,
                        labeltext: AppTranslationKeys.phone.tr,
                      ),
                      GetBuilder<LoginController>(
                        builder: (controller) => TextFormAuth(
                          obscureText: controller.isHidePassword,
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          isNumber: false,
                          valid: (val) {
                            return Validate.valid(val!,min: 8,max: 30);
                          },
                          mycontroller: controller.password,
                          hinttext: AppTranslationKeys.enterYourPassword.tr,
                          iconData: Icons.lock_outline,
                          labeltext: AppTranslationKeys.password.tr,
                          // mycontroller: ,
                        ),
                      ),
                      ButtonAuth(
                          text: AppTranslationKeys.login.tr,
                          onPressed: () {
                            controller.login();
                          }),
                      const SizedBox(height: 40),
                      TextAuth(
                        textone: AppTranslationKeys.dontHaveAccount.tr,
                        texttwo: AppTranslationKeys.register.tr,
                        onTap: () {
                          controller.goToRegisterUp();
                        },
                      )
                    ]),
                  ),
                )),
          )
    );
  }
}
