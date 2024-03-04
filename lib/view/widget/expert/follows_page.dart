
import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultancy/controller/expert/home_expert_controller.dart';
import 'package:consultancy/core/constant/app_assets.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/view/widget/app/handling_data_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowsPage extends GetView<HomeExpertController> {
  const FollowsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GetBuilder<HomeExpertController>(builder: (controller) => HandlingDataRequest(
        statusView: controller.statusView,
        child: ListView.builder(
          itemCount: controller.expertFollows.length,
          itemBuilder: (context, index) => Card(
            child: InkWell(
              onTap: (){

              },
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {},
                    icon: const Icon(Icons.favorite, size: 20,color: AppColors.red,)),
                    Text(controller.expertFollows[index].name!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                ),
                subtitle: Text(controller.expertFollows[index].phoneNumber!),
                trailing: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: controller.expertFollows[index].photo!,
                    fit: BoxFit.fill,
                    width: 0.15*Get.width,
                    height: 0.2*Get.width,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(AppAssets.profile),
                  ),
                ),
              ),
            ),
          ),),
      ),),
    );
  }
}
