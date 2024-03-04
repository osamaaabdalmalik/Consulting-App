
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_pages_routes.dart';
import 'package:consultancy/core/constant/app_shared_keys.dart';
import 'package:consultancy/core/constant/app_status_code_request.dart';
import 'package:consultancy/core/constant/app_status_views.dart';
import 'package:consultancy/core/functions/helper_function.dart';
import 'package:consultancy/core/services/shared_preferences_service.dart';
import 'package:consultancy/data/datasource/remote/auth_remote.dart';
import 'package:consultancy/data/datasource/remote/expert_remote.dart';
import 'package:consultancy/data/model/expert_booking_model.dart';
import 'package:consultancy/data/model/expert_info_model.dart';
import 'package:consultancy/data/model/expert_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeExpertController extends GetxController{

  late SharedPreferencesService sharedService;
  late ExpertRemote expertRemote;
  late AuthRemote authRemote;
  StatusView statusView=StatusView.loading;
  int selectedBottomNavBarItem=1;
  ExpertInfoModel expertInfo=ExpertInfoModel();

  List<ExpertBookingModel> expertBookings=[];
  List<UserModel> expertFollows=[];
  int expertId=0,money=0;
  String token='',name='Yasser',phone='096857482',lang='ar';

  @override
  void onInit() async {
    super.onInit();
    sharedService = Get.find();
    authRemote = AuthRemote(Get.find());
    lang=sharedService.sharedPreferences.getString(AppSharedKeys.lang)??'';
    token = sharedService.sharedPreferences.getString(AppSharedKeys.rememberToken) ?? '';
    expertId = sharedService.sharedPreferences.getInt(AppSharedKeys.expertId) ?? 0;
    money = sharedService.sharedPreferences.getInt(AppSharedKeys.money) ?? 0;
    name = sharedService.sharedPreferences.getString(AppSharedKeys.name) ?? name;
    phone = sharedService.sharedPreferences.getString(AppSharedKeys.phoneNumber) ?? '';
    expertRemote = ExpertRemote(Get.find(), token);
    expertInfo=ExpertInfoModel(name: name,phoneNumber: phone,id: expertId,money: money);
    await getExpertInfo();
    await getExpertBookings();
  }

  getExpertInfo() async {
    statusView = StatusView.loading;
    update();
    var response = await expertRemote.getExpertInfo(expertId);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        expertInfo=ExpertInfoModel.fromJson(response['data'],lang);
        appendExpertData(response);
        statusView = StatusView.none;
      }
    }else{
      statusView = StatusView.serverFailure;
    }
    update();
  }
  void appendExpertData(response){
    sharedService.sharedPreferences.setInt(AppSharedKeys.expertId, response['data']['id']) ;
    sharedService.sharedPreferences.setString(AppSharedKeys.name, response['data']['name']) ;
    sharedService.sharedPreferences.setInt(AppSharedKeys.money, response['data']['money']) ;
    sharedService.sharedPreferences.setString(AppSharedKeys.phoneNumber, response['data']['phone_number']) ;
    sharedService.sharedPreferences.setString(AppSharedKeys.rememberToken, response['data']['remember_token']) ;
  }
  getExpertBookings() async {
    statusView = StatusView.loading;
    update();
    var response = await expertRemote.getExpertBookings(expertId);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        List bookingsRes=response['data'];
        expertBookings.clear();
        for (var element in bookingsRes) {
          expertBookings.add(ExpertBookingModel.fromJson(element));
        }
        if(expertBookings.isEmpty){
          statusView = StatusView.noContent;
        } else{
          statusView = StatusView.none;
        }
      }
    }else{
      statusView = StatusView.serverFailure;
    }
    update();
  }
  getFollows() async {
    statusView = StatusView.loading;
    update();
    var response = await expertRemote.getFollows(expertId);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        List expertsRes=response['data'];
        expertFollows.clear();
        for (var element in expertsRes) {
          expertFollows.add(UserModel.fromJson(element));
        }
        if(expertFollows.isEmpty){
          statusView = StatusView.noContent;
        }
        else{
          statusView = StatusView.none;
        }
      }
    }else{
      statusView = StatusView.serverFailure;
    }
    update();
  }

  logout() async {
    printNote('Start logout Controller');
    statusView = StatusView.loading;
    var response = await authRemote.logoutExpert(token);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        sharedService.sharedPreferences.setBool(AppSharedKeys.isAuthenticated, false);
        sharedService.sharedPreferences.setString(AppSharedKeys.rememberToken,'');
        Get.offNamed(AppPagesRoutes.choseGarde);
      } else if (response['status'] == StatusCodeRequest.badRequest){
        Get.snackbar('Data not valid', "${response['message']}",
          icon: const Icon(Icons.error,color: AppColors.white,),
          backgroundColor: AppColors.red,
        );
      }
    }else{
      statusView = StatusView.serverFailure;
    }
    update();
  }

  changeButtonNavBar(int index) async {
    selectedBottomNavBarItem = index;
    if(index==0){
      await getExpertInfo();
    } else if(index==1){
      await getExpertBookings();
    } else if(index==2){
      await getFollows();
    }
  }
}