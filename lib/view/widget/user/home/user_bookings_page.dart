
import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultancy/controller/user/home_user_controller.dart';
import 'package:consultancy/view/widget/app/handling_data_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserBookingsPage extends GetView<HomeUserController> {
  const UserBookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GetBuilder<HomeUserController>(builder: (controller) => HandlingDataRequest(
        statusView: controller.statusView,
        child: ListView.builder(
          itemCount: controller.userBookings.length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.userBookings[index].date!.day!.name!,style: const TextStyle(fontSize: 18),),
                  Text(controller.userBookings[index].expert!.name!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(controller.userBookings[index].date!.time!),
                  ),
                ],
              ),
              trailing: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: controller.userBookings[index].expert!.photo!,
                  fit: BoxFit.fill,
                  width: 0.15*Get.width,
                  height: 0.2*Get.width,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),),
      ),),
    );
  }
}
