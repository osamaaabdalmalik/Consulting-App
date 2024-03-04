import 'package:consultancy/controller/auth/chose_garde_controller.dart';
import 'package:consultancy/core/constant/app_assets.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/view/widget/auth/buttom_gard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class ChoseGardeScreen extends StatelessWidget {
  ChoseGardeScreen({Key? key}) : super(key: key);

  ChoseGardeController controller=Get.put(ChoseGardeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                AppAssets.profile,
                // width: ,
                height: Get.width / 1.3,
                fit: BoxFit.fill,
              ),
              Text(AppTranslationKeys.choseTypeAuthentication.tr, style: Theme.of(context).textTheme.headline1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonGard(
                      textbutton: AppTranslationKeys.asExpert.tr,
                      onPressed: () {
                        controller.goToLogin('Expert');
                      }),
                  ButtonGard(
                      textbutton: AppTranslationKeys.asUser.tr,
                      onPressed: () {
                        controller.goToLogin('User');
                      }),
                ],
              )
            ],
          )),
    );
  }
}
