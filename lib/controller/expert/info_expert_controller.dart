
import 'dart:io';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_pages_routes.dart';
import 'package:consultancy/core/constant/app_shared_keys.dart';
import 'package:consultancy/core/constant/app_status_code_request.dart';
import 'package:consultancy/core/constant/app_status_views.dart';
import 'package:consultancy/core/constant/app_translation_keys.dart';
import 'package:consultancy/core/services/shared_preferences_service.dart';
import 'package:consultancy/data/datasource/remote/expert_remote.dart';
import 'package:consultancy/data/model/category_model.dart';
import 'package:consultancy/data/model/day_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoExpertController extends GetxController{

  late SharedPreferencesService sharedService;
  late ExpertRemote expertRemote;
  GlobalKey<FormState> formKeyCreate= GlobalKey<FormState>();
  TextEditingController addressFieldController=TextEditingController();
  List<TextEditingController> experiencesFieldController=[];
  StatusView statusView= StatusView.loading;
  String token='';
  int expertId=0;


  File? image;
  PickedFile? pickedImage;
  final picker =ImagePicker();

  List<CategoryModel> categories=[];
  List<Day?> days=[];
  List<Day?> selectedDays=[];
  CategoryModel? selectedCategory;
  String selectedStartTime='8:00 AM',selectedEndTime='4:00 PM',lang='ar';

  @override
  void onInit() async {
    super.onInit();
    sharedService = Get.find();
    lang=sharedService.sharedPreferences.getString(AppSharedKeys.lang)??'';
    token=sharedService.sharedPreferences.getString(AppSharedKeys.rememberToken)??'';
    expertId=sharedService.sharedPreferences.getInt(AppSharedKeys.expertId) ?? 0;
    expertRemote=ExpertRemote(Get.find(),token);
    addExperienceField();
    await getCategoriesAndDays();
  }
  getCategoriesAndDays() async {
    statusView = StatusView.loading;
    update();
    var response = await expertRemote.getCategoriesAndDays();
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        List categoriesRes=response['data']['categories'];
        categories.clear();
        for (var element in categoriesRes) {
          categories.add(CategoryModel.fromJson(element,lang));
        }
        List daysRes=response['data']['days'];
        days.clear();
        for (var element in daysRes) {
          days.add(Day.fromJson(element));
        }
        statusView = StatusView.none;
      }
    }else{
      statusView = StatusView.serverFailure;
    }
    update();
  }
  addExpertInfo() async {
    List<String> experiences=getExperiences();
    List<int> workDayIds=getWorkDayIds();
    if(formKeyCreate.currentState!.validate() && validateExpertInfo()){
      statusView = StatusView.loading;
      update();
      var response = await expertRemote.addExpertInfo(expertId,selectedCategory!.id!,
          addressFieldController.text, selectedStartTime,
          selectedEndTime,image!, workDayIds,experiences);
      if(response is! StatusView){
        if (response['status'] == StatusCodeRequest.ok) {
          sharedService.sharedPreferences.setBool(AppSharedKeys.isPassAddInfo, true);
          Get.offNamed(AppPagesRoutes.expertHome);
        }
      }else{
        statusView = StatusView.serverFailure;
      }
    }
    update();
  }

  getExperiences() {
    List<String> experiences=[];
    for (var element in experiencesFieldController) {
      experiences.add(element.text);
    }
    return experiences;
  }
  getWorkDayIds() {
    List<int> workDayIds=[];
    for (var element in selectedDays) {
      workDayIds.add(element!.id!);
    }
    return workDayIds;
  }
  pickImage()async {
    pickedImage=await picker.getImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      image=File(pickedImage!.path);
      update();
    }
  }

  addExperienceField() async {
    if(experiencesFieldController.length>=8){
      Get.snackbar(AppTranslationKeys.cannotAddMoreThan8.tr,"",
        icon: const Icon(Icons.error,color: AppColors.white,),
        backgroundColor: AppColors.red,
      );
    }else{
      experiencesFieldController.add(TextEditingController());
    }
    update();
  }
  removeExperienceField() async {
    if(experiencesFieldController.length<=1){
      Get.snackbar(AppTranslationKeys.cannotAddLessThan1.tr, '',
        icon: const Icon(Icons.error,color: AppColors.white,),
        backgroundColor: AppColors.red,
      );
    }else{
      experiencesFieldController.removeLast();
    }
    update();
  }

  onChangeCategory(CategoryModel category) {
    selectedCategory=category;
    update();
  }
  onChangeStartTime(String startTime) {
    selectedStartTime=startTime;
    update();
  }
  onChangeEndTime(String endTime) {
    selectedEndTime=endTime;
    update();
  }

  validateExpertInfo(){
    if(image==null){
      Get.snackbar(AppTranslationKeys.youMustAddImage.tr, "",
        icon: const Icon(Icons.error,color: AppColors.white,),
        backgroundColor: AppColors.red,
      );
      return false;
    } if(selectedDays.isEmpty){
      Get.snackbar(AppTranslationKeys.youMustSelectDay.tr, '',
        icon: const Icon(Icons.error,color: AppColors.white,),
        backgroundColor: AppColors.red,
      );
      return false;
    }
    return true;
  }
}