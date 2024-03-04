
import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultancy/controller/user/home_user_controller.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/view/widget/app/handling_data_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class FavoritePage extends GetView<HomeUserController> {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GetBuilder<HomeUserController>(builder: (controller) => HandlingDataRequest(
        statusView: controller.statusView,
        child: ListView.builder(
          itemCount: controller.favoriteExperts.length,
          itemBuilder: (context, index) => Card(
            child: InkWell(
              onTap: (){
                controller.toExpertDetails(controller.favoriteExperts[index].id!);
              },
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () async{
                      await controller.removeFromFavorite(controller.favoriteExperts[index].id!);
                    }, icon: const Icon(Icons.favorite, size: 20,color: AppColors.red,)),
                    Text(controller.favoriteExperts[index].name!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBarIndicator(
                      rating: controller.favoriteExperts[index].rating!,
                      direction: Axis.horizontal,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: AppColors.yellow,
                      ),
                      itemCount: 5,
                      itemSize: 20,
                    ),
                    Text(controller.favoriteExperts[index].phoneNumber!),
                  ],
                ),
                trailing: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: controller.favoriteExperts[index].photo!,
                    fit: BoxFit.fill,
                    width: 0.15*Get.width,
                    height: 0.2*Get.width,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),),
      ),),
    );
  }
}
