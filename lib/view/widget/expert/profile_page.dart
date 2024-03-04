
import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultancy/controller/expert/home_expert_controller.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/view/widget/app/handling_data_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<HomeExpertController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeExpertController>(
      builder: (controller) => HandlingDataRequest(
        statusView: controller.statusView,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Container(
                height: 0.6*Get.width,
                width: 0.6*Get.width,
                alignment: Alignment.center,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: controller.expertInfo.photo!,
                    width: 0.6*Get.width,
                    height: 0.6*Get.width,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>  CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primaryLight,
                      child: Text('${controller.expertInfo.name![0]}${controller.expertInfo.name![1]}',
                          style:const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(AppTranslationKeys.mainInfo.tr,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold,color: AppColors.primary),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person_outlined,color: AppColors.primaryLight,),
                        const SizedBox(width: 10,),
                        Text(controller.expertInfo.name!,style: const TextStyle(fontSize:25 ,fontWeight: FontWeight.bold ),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.phone_android,color: AppColors.primaryLight,),
                                  const SizedBox(width: 10,),
                                  Text(controller.expertInfo.phoneNumber!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined,color: AppColors.primaryLight,),
                                  const SizedBox(width: 10,),
                                  Text(controller.expertInfo.address!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('${controller.expertInfo.ratingNumber!}',style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 10,),
                                  const Icon(Icons.link_outlined,color: AppColors.primaryLight,),
                                  SizedBox(width:0.1* Get.width,),
                                ],
                              ),
                              RatingBarIndicator(
                                rating: controller.expertInfo.rating!,
                                direction: Axis.horizontal,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: AppColors.yellow,
                                ),
                                itemCount: 5,
                                itemSize: 25,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height:4,thickness: 1,),
              Text(AppTranslationKeys.workDays.tr,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold,color: AppColors.primary),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.timer_outlined,color: AppColors.primaryLight,),
                  Text(controller.expertInfo.startWork!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
                  const Icon(Icons.timer_off_outlined,color: AppColors.primaryLight,),
                  Text(controller.expertInfo.endWork!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
                  const SizedBox(width: 10,),
                ],
              ),// work time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Expanded(
                      flex: 1,
                      child: Icon(Icons.calendar_today,color: AppColors.primaryLight,)
                  ),

                  Expanded(
                    flex: 5,
                    child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 20,
                        children:List.generate(controller.expertInfo.workDays!.length, (index) =>
                            Text(controller.expertInfo.workDays![index].name!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
                        )
                    ),
                  ),
                ],
              ),
              const Divider(height:5,thickness: 1,),
              Text(AppTranslationKeys.categoryAndExperiences.tr,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold,color: AppColors.primary),),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 20,),
                  const Icon(Icons.category_outlined,color: AppColors.primaryLight,),
                  const SizedBox(width: 15,),
                  Text(controller.expertInfo.category!.name!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
                ],
              ),// work time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Expanded(
                      flex: 1,
                      child: Icon(Icons.business_center_outlined,color: AppColors.primaryLight,)
                  ),
                  Expanded(
                    flex: 5,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 20,
                      children: List.generate(controller.expertInfo.experiences!.length, (index) =>
                          Text(controller.expertInfo.experiences![index].name!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
