
import 'package:consultancy/core/constant/app_pages_routes.dart';
import 'package:consultancy/core/constant/app_shared_keys.dart';
import 'package:consultancy/core/constant/app_status_code_request.dart';
import 'package:consultancy/core/constant/app_status_views.dart';
import 'package:consultancy/core/services/shared_preferences_service.dart';
import 'package:consultancy/data/datasource/remote/user_remote.dart';
import 'package:consultancy/data/model/expert_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryExpertsController extends GetxController{

  late SharedPreferencesService sharedService;
  late UserRemote userRemote;
  StatusView statusView= StatusView.loading;
  List<ExpertModel> experts=[];
  List<ExpertModel> filterExperts=[];
  TextEditingController showSearchFieldController=TextEditingController();
  bool showSearchField=false;
  String token='',name='';
  int categoryId=0;

  List<String> names=[];
  List<int> ids=[];

  @override
  void onInit() async {
    super.onInit();
    sharedService =Get.find();
    token=sharedService.sharedPreferences.getString(AppSharedKeys.rememberToken)??'';
    userRemote=UserRemote(Get.find(),token);
    categoryId=Get.arguments[AppSharedKeys.passId];
    name=Get.arguments[AppSharedKeys.name];
    await getCategoryExpert();
  }

  showSearch(){
    showSearchField=!showSearchField;
    update();
  }
  search(String name){
    filterExperts=experts.where((element) => element.name!.toLowerCase().contains(name.toLowerCase())).toList();
    update();
  }
  getCategoryExpert() async {
    statusView = StatusView.loading;
    update();
    var response = await userRemote.getCategoryExperts(categoryId);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        List categoriesRes=response['data'];
        experts.clear();
        for (var element in categoriesRes) {
          experts.add(ExpertModel.fromJson(element));
        }
        if(experts.isEmpty){
          statusView = StatusView.noContent;
        }
        else{
          statusView = StatusView.none;
        }
      }
    }
    update();
  }

  toExpertDetails(int expertId){
    Get.toNamed(AppPagesRoutes.expertDetails,arguments: {AppSharedKeys.expertId:expertId});
  }
}
