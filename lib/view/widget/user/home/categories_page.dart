
import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultancy/controller/user/home_user_controller.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/view/widget/app/handling_data_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesPage extends GetView<HomeUserController> {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15,right: 15, top: 10),
      child: GetBuilder<HomeUserController>(builder: (controller) => HandlingDataRequest(
        statusView: controller.statusView,
        child:controller.showSearchField && controller.filterCategories.isEmpty ?
        Center(
          child: Text(
            AppTranslationKeys.notCategory.tr,
            style: const TextStyle(
                fontSize: 18,
                color: AppColors.black,
                fontWeight: FontWeight.bold),
          ),
        ):
        GridView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.showSearchField ?  controller.filterCategories.length: controller.categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.9),
          itemBuilder: (context, index) => InkWell(
            onTap: (){
              controller.toCategoryExperts(controller.showSearchField ? controller.filterCategories[index]:controller.categories[index]);
            },
            child: Card(
              color: AppColors.primaryLight,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:controller.showSearchField ?  controller.filterCategories[index].photo!: controller.categories[index].photo!,
                      width: 0.3*Get.width,height:0.3*Get.width,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Text(
                    controller.showSearchField ?  controller.filterCategories[index].name! :controller.categories[index].name!,
                    style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),),
    );
  }
}
