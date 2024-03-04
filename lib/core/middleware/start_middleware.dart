import 'package:consultancy/core/constant/app_pages_routes.dart';
import 'package:consultancy/core/constant/app_shared_keys.dart';
import 'package:consultancy/core/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  SharedPreferencesService sharedServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    bool isAuthenticated=sharedServices.sharedPreferences.getBool(AppSharedKeys.isAuthenticated)??false;
    if (isAuthenticated) {
      if(sharedServices.sharedPreferences.getString(AppSharedKeys.garde) == "Expert") {
        bool isPass=sharedServices.sharedPreferences.getBool(AppSharedKeys.isPassAddInfo) ?? false;
        if(isPass){
          return const RouteSettings(name: AppPagesRoutes.expertHome);
        }else{
          return const RouteSettings(name: AppPagesRoutes.addInfo);
        }
      }else{
        return const RouteSettings(name: AppPagesRoutes.userHome);
      }
    }
    return null;
  }
}
