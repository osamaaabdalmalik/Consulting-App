
import 'package:consultancy/core/constant/app_pages_routes.dart';
import 'package:consultancy/core/constant/app_shared_keys.dart';
import 'package:consultancy/core/constant/app_status_code_request.dart';
import 'package:consultancy/core/constant/app_status_views.dart';
import 'package:consultancy/core/functions/helper_function.dart';
import 'package:consultancy/core/services/shared_preferences_service.dart';
import 'package:consultancy/data/datasource/remote/user_remote.dart';
import 'package:consultancy/data/model/category_model.dart';
import 'package:consultancy/data/model/expert_model.dart';
import 'package:consultancy/data/datasource/remote/auth_remote.dart';
import 'package:consultancy/data/model/user_booking_model.dart';
import 'package:consultancy/data/model/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeUserController extends GetxController{

  late SharedPreferencesService sharedService;
  late UserRemote userRemote;
  late AuthRemote authRemote;
  bool showSearchField=false;
  TextEditingController showSearchFieldController=TextEditingController();
  int selectedBottomNavigationBarItem=1;
  StatusView statusView= StatusView.loading;
  List<CategoryModel> categories=[];
  List<CategoryModel> filterCategories=[];
  List<ExpertModel> favoriteExperts=[];
  List<UserBookingModel> userBookings=[];
  UserInfo userInfo=UserInfo();
  String token='',name='osama',phoneNumber='0999558423',photo='',lang='ar';
  int userId=0,money=0;

  List<String> names=[];
  List<int> ids=[];

  @override
  void onInit() async {
    super.onInit();
    sharedService = Get.find();
    authRemote = AuthRemote(Get.find());
    lang=sharedService.sharedPreferences.getString(AppSharedKeys.lang)??'';
    token=sharedService.sharedPreferences.getString(AppSharedKeys.rememberToken)??'';
    userId=sharedService.sharedPreferences.getInt(AppSharedKeys.userId)??0;
    money=sharedService.sharedPreferences.getInt(AppSharedKeys.money)??0;
    name=sharedService.sharedPreferences.getString(AppSharedKeys.name)??name;
    phoneNumber=sharedService.sharedPreferences.getString(AppSharedKeys.phoneNumber)??phoneNumber;
    userRemote=UserRemote(Get.find(),token);
    userInfo=UserInfo(id: userId,name: name,phoneNumber: phoneNumber,money: money);

    await getUserInfo();
    await getCategories();
    getDataSearch();
  }

  showSearch() {
    showSearchField=!showSearchField;
    update();
  }
  search(String name) {
    filterCategories=categories.where((element) => element.name!.toLowerCase().contains(name.toLowerCase())).toList();
    update();
  }

  getUserInfo() async {
    statusView = StatusView.loading;
    update();
    var response = await userRemote.getUserInfo(userId);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        userInfo=UserInfo.fromJson(response['data']);
        appendUserData(response);
        statusView = StatusView.none;
      }
    }else{
      statusView = StatusView.serverFailure;
    }
    update();
  }
  void appendUserData(response){
    sharedService.sharedPreferences.setInt(AppSharedKeys.userId, response['data']['id']) ;
    sharedService.sharedPreferences.setString(AppSharedKeys.name, response['data']['name']) ;
    sharedService.sharedPreferences.setString(AppSharedKeys.phoneNumber, response['data']['phone_number']) ;
    sharedService.sharedPreferences.setInt(AppSharedKeys.money, response['data']['money']) ;
    sharedService.sharedPreferences.setString(AppSharedKeys.rememberToken, response['data']['remember_token']) ;
    sharedService.sharedPreferences.setBool(AppSharedKeys.isAuthenticated, true);
  }
  getCategories() async {
    statusView = StatusView.loading;
    update();
    await getUserInfo();
    var response = await userRemote.getCategories();
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        List categoriesRes=response['data'];
        categories.clear();
        for (var element in categoriesRes) {
            categories.add(CategoryModel.fromJson(element,lang));
        }
        if(categories.isEmpty){
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
  getFavorites() async {
    statusView = StatusView.loading;
    update();
    await getUserInfo();
    var response = await userRemote.getFavorites(userId);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        List expertsRes=response['data'];
        favoriteExperts.clear();
        for (var element in expertsRes) {
          favoriteExperts.add(ExpertModel.fromJson(element));
        }
        if(favoriteExperts.isEmpty){
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
  getUserBookings() async {
    statusView = StatusView.loading;
    update();
    await getUserInfo();
    var response = await userRemote.getUserBookings(userId);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        List bookingsRes=response['data'];
        userBookings.clear();
        for (var element in bookingsRes) {
          userBookings.add(UserBookingModel.fromJson(element));
        }
        if(userBookings.isEmpty){
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
  removeFromFavorite(int expertId) async {
    statusView = StatusView.loading;
    update();
    var response = await userRemote.changeFavorite(userId,expertId);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        await getFavorites();
        update();
      }
    }
  }
  logout() async {
    statusView = StatusView.loading;
    var response = await authRemote.logoutExpert(token);
    if(response is! StatusView){
      if (response['status'] == StatusCodeRequest.ok) {
        sharedService.sharedPreferences.setBool(AppSharedKeys.isAuthenticated, false);
        sharedService.sharedPreferences.setString(AppSharedKeys.rememberToken,'');
        Get.offNamed(AppPagesRoutes.choseGarde);
      }
    }else{
      statusView = StatusView.serverFailure;
    }
    update();
  }

  getDataSearch(){
    for (var element in categories) {
      names.add(element.name!);
      ids.add(element.id!);
    }
  }
  changeButtonNavBar(int index) async {
    selectedBottomNavigationBarItem = index;
    if(index==0){
      await getFavorites();
      showSearchField=false;
    } else if(index==1){
      await getCategories();
    } else if(index==2){
      await getUserBookings();
      showSearchField=false;
    }
    update();
  }
  toCategoryExperts(CategoryModel category){
    Get.toNamed(AppPagesRoutes.categoryExperts, arguments: {AppSharedKeys.passId:category.id,AppSharedKeys.name:category.name});
  }
  toExpertDetails(int expertId){
    Get.toNamed(AppPagesRoutes.expertDetails,arguments: {AppSharedKeys.expertId:expertId});
  }
}