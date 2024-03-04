
import 'package:consultancy/controller/user/experts_details_controller.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/view/widget/app/handling_data_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SheetBooked extends GetView<ExpertsDetailsController> {
  const SheetBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HandlingDataRequest(
      statusView: controller.statusViewSheet,
      child: Container(
        padding: const EdgeInsets.only(left: 15,right: 15, top: 10),
        margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        height: Get.height * 0.3,
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  AppTranslationKeys.addBooking.tr,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GetBuilder<ExpertsDetailsController>(
                builder: (controller) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 0.4 * Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                      ),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            label: Text(AppTranslationKeys.day.tr),
                            labelStyle: const TextStyle(fontSize: 23,color: AppColors.black),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            )
                        ),
                        borderRadius: BorderRadius.circular(20),
                        elevation: 3,
                        hint: Text(controller.datesOfDaySelected.isEmpty ?AppTranslationKeys.time.tr:'Choose date'),
                        iconSize: 0,
                        alignment: Alignment.center,
                        value: controller.selectedDay,
                        items: controller.workDays
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name!),
                        )).toList(),
                        onChanged: (val) {
                          controller.changeListDay(val);
                        },
                        onTap: () {
                        },
                      ),
                    ),
                    Container(
                      width: 0.4 * Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                      ),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            contentPadding:const EdgeInsets.all(10),
                            label: Text(AppTranslationKeys.time.tr),
                            labelStyle: const TextStyle(fontSize: 23,color: AppColors.black),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            )
                        ),
                        borderRadius: BorderRadius.circular(20),
                        elevation: 3,
                        hint: Text(controller.datesOfDaySelected.isEmpty ?AppTranslationKeys.noDate.tr:'Choose date'),
                        iconSize: 0,
                        alignment: Alignment.center,
                        value: controller.selectedDate,
                        items: controller.datesOfDaySelected
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.time!),
                        )).toList(),
                        onChanged: (val) {
                          controller.changeListDate(val);
                        },
                        onTap: () {},
                      ),
                    ),
                  ],
                )
              ),
            ),
            MaterialButton(
              onPressed: () async {
                await controller.addBooking();
              },
              padding: EdgeInsets.symmetric(horizontal:0.25*Get.width ),
              color: AppColors.primary,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Text(AppTranslationKeys.bookDate.tr,style: const TextStyle(fontSize: 20,color: AppColors.white, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}
