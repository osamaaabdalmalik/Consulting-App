
import 'package:consultancy/controller/user/category_experts_controller.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/view/widget/user/experts_details/experts_listview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryExpertsScreen extends StatelessWidget {
  CategoryExpertsScreen({Key? key}) : super(key: key);
  CategoryExpertsController categoryExpertsController=Get.put(CategoryExpertsController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryExpertsController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: controller.showSearchField ?
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: AppTranslationKeys.findExpert.tr,
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
              : Text(categoryExpertsController.name,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              controller.showSearch();
            }, icon: Icon(controller.showSearchField?Icons.arrow_forward_rounded:Icons.search))
          ],
        ),
        body: const ExpertListview(),
      ),
    );
  }
}
