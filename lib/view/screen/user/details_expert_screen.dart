
import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultancy/controller/user/experts_details_controller.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_status_views.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/view/widget/app/handling_data_request.dart';
import 'package:consultancy/view/widget/user/experts_details/sheet_booked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ExpertDetailsScreen extends StatelessWidget {
  ExpertDetailsScreen({Key? key}) : super(key: key);
  ExpertsDetailsController categoryExpertsController=Get.put(ExpertsDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await categoryExpertsController.getAvailableDates();
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => const SheetBooked());
        },
        child: const Icon(Icons.business_center_outlined),
      ),
      body: GetBuilder<ExpertsDetailsController>(
        builder: (controller) => HandlingDataRequest(
          statusView: controller.statusView,
          child:controller.statusView==StatusView.loading?
          const Center():
          CustomScrollView(
            slivers: [
              SliverAppBar(
                  pinned: true,
                  leading: Container(
                      margin: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryLight),
                      child: IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: AppTranslationKeys.addRating.tr,
                              content: RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  controller.rating=rating;
                                },
                              ),
                              actions: [
                                MaterialButton(
                                  onPressed: (){
                                    Get.back();
                                  },
                                  color: AppColors.grey,
                                  disabledColor: AppColors.grey,
                                  disabledTextColor: AppColors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30))
                                  ),
                                  child:  Text(AppTranslationKeys.cancel.tr,style:const TextStyle(fontSize: 20,color: AppColors.white),),
                                ),
                                const SizedBox(width: 5,),
                                MaterialButton(
                                  onPressed: (){
                                    controller.ratingExpert();
                                  },
                                  color: AppColors.primary,
                                  disabledColor: AppColors.red,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30))
                                  ),
                                  child: Text(AppTranslationKeys.save.tr,style: const TextStyle(fontSize: 20,color: AppColors.white),),
                                ),
                              ]
                            );
                          },
                          icon: const Icon(
                            Icons.star_outline,
                            color: AppColors.yellowAccent,
                          )
                      )
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: const EdgeInsets.symmetric(vertical: 10),
                    title: Text(
                      controller.expertDetails.name!,
                        style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)                    ),
                    background: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 70,left: 20,right: 20),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: controller.expertDetails.photo!,
                          width: 0.7*Get.width,
                          height: 0.7* Get.width,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.primaryLight,
                            child: Text('${controller.expertDetails.name![0]}${controller.expertDetails.name![1]}',
                                style:const TextStyle(fontSize: 70, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    Container(
                        margin: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryLight),
                        child: IconButton(
                            onPressed: () {
                              controller.changeFavorite();
                            },
                            icon: const Icon(
                              Icons.favorite_border,
                              color: AppColors.red,
                            )
                        )
                    ),
                  ],
                  expandedHeight: Get.width,
                  backgroundColor: AppColors.primary,
              ),
              SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 120,horizontal: 20),
                    height: Get.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppTranslationKeys.mainInfo.tr,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold,color: AppColors.primary),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.person_outlined,color: AppColors.primaryLight,),
                                  const SizedBox(width: 10,),
                                  Text(controller.expertDetails.name!,style: const TextStyle(fontSize:25 ,fontWeight: FontWeight.bold ),),
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
                                            Expanded(child: Text(controller.expertDetails.phoneNumber!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis))),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on_outlined,color: AppColors.primaryLight,),
                                            const SizedBox(width: 10,),
                                            Expanded(child: Text(controller.expertDetails.address!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis))),
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
                                            Text('${controller.expertDetails.ratingNumber!}',style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
                                            const SizedBox(width: 10,),
                                            const Icon(Icons.link_outlined,color: AppColors.primaryLight,),
                                            SizedBox(width:0.1* Get.width,),
                                          ],
                                        ),
                                        RatingBarIndicator(
                                          rating: controller.expertDetails.rating!,
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
                            Text(controller.expertDetails.startWork!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
                            const Icon(Icons.timer_off_outlined,color: AppColors.primaryLight,),
                            Text(controller.expertDetails.endWork!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
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
                                  children:List.generate(controller.expertDetails.workDays!.length, (index) =>
                                      Text(controller.expertDetails.workDays![index].name!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
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
                            Text(controller.expertDetails.category!.name!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
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
                                children: List.generate(controller.expertDetails.experiences!.length, (index) =>
                                    Text(controller.expertDetails.experiences![index].name!,style: const TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height:5,thickness: 1,),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
