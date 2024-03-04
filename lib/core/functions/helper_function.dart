
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExitApp() {
    Get.defaultDialog(
        title: "تنبيه",
        titleStyle: const TextStyle(color: AppColors.primary , fontWeight: FontWeight.bold),
        middleText: "هل تريد الخروج من التطبيق",
        actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(AppColors.primary)),
                onPressed: () {
                    exit(0);
                },
                child:const Text("تاكيد",style: TextStyle( fontWeight: FontWeight.bold),)),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(AppColors.primary)),
                onPressed: () {
                    Get.back();
                },
                child:const Text("الغاء",style: TextStyle( fontWeight: FontWeight.bold),))
        ]);
    return Future.value(true);
}

Future<String> encodeImage(File image) async{
  Uint8List imageBytes=await image.readAsBytes();
  return base64.encode(imageBytes);
}
Future<String> decodeImage(File image) async{
  Uint8List imageBytes=await image.readAsBytes();
  return base64.encode(imageBytes);
}

printNote(Object note){
    print("=========================== $note ============================");
}