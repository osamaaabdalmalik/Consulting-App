
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_shared_keys.dart';
import 'package:consultancy/core/constant/app_status_code_request.dart';
import 'package:consultancy/core/constant/app_status_views.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/core/functions/helper_function.dart';
import 'package:consultancy/core/services/shared_preferences_service.dart';
import 'package:consultancy/data/datasource/remote/user_remote.dart';
import 'package:consultancy/data/model/date_model.dart';
import 'package:consultancy/data/model/day_model.dart';
import 'package:consultancy/data/model/expert_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertsDetailsController extends GetxController{

  late SharedPreferencesService sharedService;
  late UserRemote userRemote;
  StatusView statusView=StatusView.loading;
  StatusView statusViewSheet=StatusView.loading;
  late ExpertDetailsModel expertDetails;
  String token='',name='';
  int expertId=0,userId=0;
  double rating=1;

  List<Day> workDays=[];
  List<DateModel> dates=[];
  List<DateModel> datesOfDaySelected=[];
  Day selectedDay=Day(id: 1,name: "Saturday");
  DateModel selectedDate=DateModel(id: 1 ,dayId: 1,time: "3:00 PM");

  @override
  void onInit() async {
    super.onInit();
    sharedService =Get.find();
    token=sharedService.sharedPreferences.getString(AppSharedKeys.rememberToken)??'';
    userId=sharedService.sharedPreferences.getInt(AppSharedKeys.userId) ?? 0;
    expertId=Get.arguments[AppSharedKeys.expertId];
    userRemote=UserRemote(Get.find(),token);

    await getExpert();
    workDays=expertDetails.workDays!;
    selectedDay=workDays[0];
  }

  getExpert() async {
    statusView = StatusView.loading;
    update();
    var response = await userRemote.getExpert(expertId);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        expertDetails=ExpertDetailsModel.fromJson(response['data']);
        statusView=StatusView.none;
      }
    }else{
      statusView=StatusView.serverFailure;
    }
    update();
  }
  getAvailableDates() async {
    statusViewSheet = StatusView.loading;
    update();
    var response = await userRemote.getAvailableDates(expertId);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        List datesRes=response['data'];
        dates.clear();
        for (var element in datesRes) {
          dates.add(DateModel.fromJson(element));
        }
        changeListDay(workDays[0]);
        statusViewSheet=StatusView.none;
      }
    }else{
      statusView=StatusView.serverFailure;
    }
    update();
  }
  addBooking() async {
    statusViewSheet = StatusView.loading;
    update();
    if(selectedDate.id==null){
      Get.snackbar(
        AppTranslationKeys.sorry.tr,
        AppTranslationKeys.yorMustDetectDate.tr,
        icon: const Icon(Icons.error,color: AppColors.white,),
        backgroundColor: AppColors.red,
      );
      statusView = StatusView.none;
      return;
    }
    var response = await userRemote.addBooking(userId,expertId,selectedDate.id!);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        statusViewSheet=StatusView.none;
        Get.back();
        datesOfDaySelected.clear();
        Get.snackbar(
          AppTranslationKeys.bookingDone.tr,
          "${AppTranslationKeys.timeBooking.tr}: ${selectedDate.time}",
          icon: const Icon(Icons.done,color: AppColors.white,),
          backgroundColor: AppColors.green,
        );
      }else{
        Get.snackbar(
          AppTranslationKeys.sorry.tr,
          AppTranslationKeys.yorMustDetectDate.tr,
          icon: const Icon(Icons.error,color: AppColors.white,),
          backgroundColor: AppColors.red,
        );
      }
    }
    update();
  }
  changeFavorite() async {
    statusView = StatusView.loading;
    update();
    var response = await userRemote.changeFavorite(userId,expertId);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        getExpert();
        if(response['data']['isFavorite']==1){
          Get.snackbar(
            AppTranslationKeys.addToFavoriteDone.tr,
            AppTranslationKeys.accessToFavorite.tr,
            icon: const Icon(Icons.done,color: AppColors.white,),
            backgroundColor: AppColors.green,
          );
        }else{
          Get.snackbar(
            AppTranslationKeys.removeToFavoriteDone.tr,
            AppTranslationKeys.cannotAccessToFavorite.tr,
            icon: const Icon(Icons.error,color: AppColors.white,),
            backgroundColor: AppColors.red,
          );
        }
        update();
      }
    }
  }
  ratingExpert() async {
    statusView = StatusView.loading;
    update();
    Get.back();
    var response = await userRemote.ratingExpert(userId,expertId,rating);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        printNote(response);
        getExpert();
        update();
      }
    }
  }

  changeListDay(day){
    selectedDay = day as Day;
    datesOfDaySelected.clear();
    datesOfDaySelected=dates.where((element) => element.dayId==day.id ).toList();
    selectedDate=datesOfDaySelected[0];
    update();
  }
  changeListDate(date){
    selectedDate= date as DateModel;
    update();
  }
}
