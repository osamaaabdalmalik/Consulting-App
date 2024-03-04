
import 'package:consultancy/controller/expert/home_expert_controller.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/core/functions/helper_function.dart';
import 'package:consultancy/data/datasource/static/expert_home_data.dart';
import 'package:consultancy/view/widget/expert/expert_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeExpertScreen extends StatelessWidget {
  HomeExpertScreen({Key? key}) : super(key: key);
  HomeExpertController controller=Get.put(HomeExpertController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslationKeys.home.tr,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ExpertDrawer(),
      ),
      bottomNavigationBar: GetBuilder<HomeExpertController>(builder: (controller) => BottomNavigationBar(
        currentIndex: controller.selectedBottomNavBarItem,
        onTap: (index) async {
          await controller.changeButtonNavBar(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: AppTranslationKeys.profile.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.lock_clock),
            label: AppTranslationKeys.bookings.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.follow_the_signs),
            label: AppTranslationKeys.follows.tr,
          ),
        ],
      )),
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<HomeExpertController>(builder: (controller) => ExpertHomeData.expertBottomNavBarPages[controller.selectedBottomNavBarItem],),
      ),
    );
  }
}
