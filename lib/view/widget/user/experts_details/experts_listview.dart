
import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultancy/controller/user/category_experts_controller.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/view/widget/app/handling_data_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ExpertListview extends GetView<CategoryExpertsController> {
  const ExpertListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GetBuilder<CategoryExpertsController>(builder: (controller) => HandlingDataRequest(
        statusView: controller.statusView,
        child:controller.showSearchField && controller.filterExperts.isEmpty ?
        Center(
          child: Text(
            AppTranslationKeys.notExpert.tr,
            style: const TextStyle(
                fontSize: 18,
                color: AppColors.black,
                fontWeight: FontWeight.bold),
          ),
        ): ListView.builder(
          itemCount:controller.showSearchField?controller.filterExperts.length: controller.experts.length,
          itemBuilder: (context, index) => Card(
            child: InkWell(
              onTap: () {
                controller.toExpertDetails(controller.showSearchField?controller.filterExperts[index].id!:controller.experts[index].id!);
              },
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBarIndicator(
                      rating:controller.showSearchField?controller.filterExperts[index].rating!: controller.experts[index].rating!,
                      direction: Axis.horizontal,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: AppColors.yellow,
                      ),
                      itemCount: 5,
                      itemSize: 20,
                    ),
                    Text(controller.showSearchField?controller.filterExperts[index].name!:controller.experts[index].name!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(controller.showSearchField?controller.filterExperts[index].address!:controller.experts[index].address!,style: const TextStyle(fontSize: 16),overflow: TextOverflow.ellipsis)),
                      Text(controller.showSearchField?controller.filterExperts[index].phoneNumber!:controller.experts[index].phoneNumber!),
                    ],
                  ),
                ),
                trailing: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: controller.showSearchField?controller.filterExperts[index].photo!:controller.experts[index].photo!,
                    fit: BoxFit.fill,
                    width: 0.15*Get.width,
                    height: 0.2*Get.width,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primaryLight,
                      child: Text('${controller.showSearchField?controller.filterExperts[index].name![0]:controller.experts[index].name![0]}'
                                '${controller.showSearchField?controller.filterExperts[index].name![1]:controller.experts[index].name![1]}',
                          style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ),
          ),),
      ),),
    );
  }
}
