
import 'package:consultancy/controller/local_controller.dart';
import 'package:consultancy/controller/user/home_user_controller.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDrawer extends GetView<HomeUserController> {

  UserDrawer({super.key});
  LocaleController localeController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserAccountsDrawerHeader(
          arrowColor: AppColors.primaryDark,
          accountName: Text(controller.name,style: const TextStyle(fontSize: 20),),
          accountEmail: Text(controller.phoneNumber,style: const TextStyle(fontSize: 15),),
          currentAccountPicture: CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primaryLight,
            child: Text('${controller.name[0]}${controller.name[1]}',
                style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ),
        ListTile(
          title: Text("${controller.userInfo.money} \$"),
          leading: const Icon(Icons.monetization_on_outlined),
        ),
        ListTile(
          title: Text(AppTranslationKeys.changeLocal.tr),
          leading: const Icon(Icons.translate),
          onTap: () {
            localeController.changeLang();
            controller.changeButtonNavBar(controller.selectedBottomNavigationBarItem);
          },
        ),
        ListTile(
          title: Text(AppTranslationKeys.logout.tr),
          leading: const Icon(Icons.exit_to_app),
          onTap: () {
            controller.logout();
          },
        ),
        const Divider(
          indent: 15,
          endIndent: 50,
          thickness: 2,
        ),
        ListTile(
          title: Text(AppTranslationKeys.help.tr),
          leading: const Icon(Icons.help),
          onTap: () {},
        ),
      ],
    );
  }
}
