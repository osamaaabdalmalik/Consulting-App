
import 'package:consultancy/controller/expert/info_expert_controller.dart';
import 'package:consultancy/core/constant/app_assets.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/core/functions/validator_function.dart';
import 'package:consultancy/data/datasource/static/expert_home_data.dart';
import 'package:consultancy/data/model/category_model.dart';
import 'package:consultancy/data/model/day_model.dart';
import 'package:consultancy/view/widget/app/handling_data_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class InfoExpertScreen extends StatelessWidget {
  InfoExpertScreen({Key? key}) : super(key: key);
  InfoExpertController controller = Get.put(InfoExpertController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslationKeys.addInformation.tr),
      ),
      body: GetBuilder<InfoExpertController>(
        builder: (controller) => HandlingDataRequest(
          statusView: controller.statusView,
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: controller.formKeyCreate,
              child: GetBuilder<InfoExpertController>(
                builder: (controller) => ListView(
                  children: [
                    Container(
                      height: 0.6*Get.width,
                      width: 0.6*Get.width,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          ClipOval(
                            child:controller.image!=null ?
                                  Image.file(controller.image!,width: 0.65*Get.width,height: 0.5*Get.width,fit: BoxFit.fill,)
                                  :Image.asset(AppAssets.profile)
                          ),
                          Positioned(
                            bottom: -15,
                            left: -5,
                            height: 100,
                            width: 100,
                            child: ClipOval(
                              child: IconButton(onPressed: (){
                                controller.pickImage();
                              },icon: const Icon(Icons.camera_alt_outlined,size: 50,color: AppColors.primary,)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppTranslationKeys.yourAddress.tr,
                          labelStyle: const TextStyle(fontSize: 20,color: AppColors.black),
                          border: const OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                color: AppColors.primary, width: 1)),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                color: AppColors.primary, width: 1)),
                        prefixIcon: const Icon(Icons.location_on_outlined,color: AppColors.primaryLight,)
                      ),
                      controller: controller.addressFieldController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        return Validate.valid(text!);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.category_outlined),
                            iconColor: AppColors.primaryLight,
                            contentPadding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                            label: Text(AppTranslationKeys.consultancy.tr),
                            labelStyle: const TextStyle(fontSize: 20,color: AppColors.black),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: AppColors.primary, width: 1),
                            ),

                        ),
                        borderRadius: BorderRadius.circular(20),
                        elevation: 3,
                        hint: Text(AppTranslationKeys.chooseCategory.tr),
                        iconSize: 0,
                        alignment: Alignment.center,
                        value: controller.selectedCategory,
                        items: controller.categories
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name!),
                        ))
                            .toList(),
                        onChanged: (val) {
                          controller
                              .onChangeCategory(val as CategoryModel);
                        },
                        onTap: () {},
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      endIndent: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                              AppTranslationKeys.experiences.tr,
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            onPressed: () {
                              controller.addExperienceField();
                            },
                            color: AppColors.primaryLight,
                            disabledColor: AppColors.red,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: const Icon(Icons.add),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            onPressed: () {
                              controller.removeExperienceField();
                            },
                            color: AppColors.primaryLight,
                            disabledColor: AppColors.red,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: const Icon(Icons.remove),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GetBuilder<InfoExpertController>(
                      builder: (controller) => SizedBox(
                        height: 50 +
                            42.0 * controller.experiencesFieldController.length,
                        child: GridView.builder(
                            itemCount:
                                controller.experiencesFieldController.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 2),
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                                  width: 0.5 * Get.width,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: '${AppTranslationKeys.experience.tr} ${index + 1}',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          borderSide: BorderSide(
                                              color: AppColors.primary,
                                              width: 1)),
                                      enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          borderSide: BorderSide(
                                              color: AppColors.primary,
                                              width: 1)),
                                      prefixIcon: const Icon(Icons.business_center_outlined,color: AppColors.primaryLight,)
                                    ),
                                    controller: controller
                                        .experiencesFieldController[index],
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (text) {
                                      return Validate.valid(text!);
                                    },
                                  ),
                                )),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      height: 30,
                      endIndent: 50,
                    ),
                    Text(
                      AppTranslationKeys.choseWorkTime.tr,
                      style: const TextStyle(
                          fontSize: 25,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 0.5 * Get.width,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  label: Text(AppTranslationKeys.start.tr),
                                  labelStyle: const TextStyle(fontSize: 23,color: AppColors.black),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  )
                              ),
                              icon: const Icon(Icons.access_alarm,color: AppColors.primary,),
                              borderRadius: BorderRadius.circular(20),
                              iconSize: 20,
                              value: controller.selectedStartTime,
                              items: ExpertHomeData.times
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                controller.onChangeStartTime(val as String);
                              },
                              onTap: () {},
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 0.5 * Get.width,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  label: Text(AppTranslationKeys.end.tr),
                                  labelStyle: const TextStyle(fontSize: 23,color: AppColors.black),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  )
                              ),
                              icon: const Icon(Icons.timer_off_outlined,color: AppColors.primary),
                              borderRadius: BorderRadius.circular(20),
                              iconSize: 20,
                              value: controller.selectedEndTime,
                              items: ExpertHomeData.times
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                controller.onChangeEndTime(val as String);
                              },
                              onTap: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppTranslationKeys.choseWorkDays.tr,
                      style: const TextStyle(
                          fontSize: 25,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MultiSelectChipField<Day?>(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                            color: AppColors.primary, width: 1),
                      ),
                      showHeader: false,
                      initialValue: controller.selectedDays,
                      selectedChipColor: AppColors.primaryLight,
                      selectedTextStyle:
                          const TextStyle(color: AppColors.black),
                      items: controller.days
                          .map((e) => MultiSelectItem<Day?>(e, e!.name!))
                          .toList(),
                      icon: const Icon(
                        Icons.check,
                        color: AppColors.white,
                      ),
                      onTap: (values) {
                        controller.selectedDays = values;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await controller.addExpertInfo();
                      },
                      color: AppColors.primary,
                      disabledColor: AppColors.red,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Text(
                        AppTranslationKeys.save.tr,
                        style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
