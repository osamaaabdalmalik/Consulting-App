import 'package:consultancy/controller/user/home_user_controller.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/core/functions/helper_function.dart';
import 'package:consultancy/data/datasource/static/user_home_data.dart';
import 'package:consultancy/view/widget/user/home/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeUserScreen extends StatelessWidget {
  HomeUserScreen({Key? key}) : super(key: key);
  HomeUserController homeUserController = Get.put(HomeUserController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeUserController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: controller.showSearchField ?
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: AppTranslationKeys.findCategory.tr,
                      filled: true,
                      fillColor: AppColors.whiteSecondary,
                    ),
                    controller: controller.showSearchFieldController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      controller.search(value);
                    },
                  ),
                )
                    : Text(AppTranslationKeys.home.tr,style: const TextStyle(fontSize: 25 ,fontWeight: FontWeight.bold)),
                centerTitle: true,
                actions: homeUserController.selectedBottomNavigationBarItem != 1
                    ? null
                    : [
                        IconButton(
                            onPressed: () {
                              controller.showSearch();
                            },
                            icon: Icon(controller.showSearchField ? Icons.arrow_forward_rounded:Icons.search))
                      ],
              ),
              drawer: Drawer(
                child: UserDrawer(),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.selectedBottomNavigationBarItem,
                onTap: (index) async {
                  await controller.changeButtonNavBar(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.favorite_outline),
                    label: AppTranslationKeys.favorite.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.category_outlined),
                    label: AppTranslationKeys.consultancy.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.lock_clock),
                    label: AppTranslationKeys.bookings.tr,
                  ),
                ],
              ),
              body: WillPopScope(
                onWillPop: alertExitApp,
                child: UserHomeData.userBottomNavBarPages[
                    controller.selectedBottomNavigationBarItem],
              ),
            ));
  }
}
