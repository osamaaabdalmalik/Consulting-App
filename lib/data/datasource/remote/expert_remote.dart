
import 'dart:convert';
import 'dart:io';

import 'package:consultancy/core/constant/app_api_routes.dart';
import 'package:consultancy/core/functions/helper_function.dart';
import 'package:consultancy/core/services/api_service.dart';

class ExpertRemote
{
  ApiService apiService;
  String token;
  ExpertRemote(this.apiService,this.token);

  getCategoriesAndDays() async {
    printNote('Start getCategoriesAndDays Remote');
    var response = await apiService.get(AppApiRoute.getCategoriesAndDays, {
      'Authorization': 'Bearer $token',
    });
    printNote('End getCategoriesAndDays Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  addExpertInfo(int expertId,int categoryId, String address,String startWork,String endWork,File photo,List<int> workDays,List<String> experiences) async {
    printNote('Start addExpertInfo Remote');
    var response = await apiService.postMultiPart(AppApiRoute.addInfo, {
        'expert_id':'$expertId',
        'address':address,
        'category_id':'$categoryId',
        'start_work':startWork,
        'end_work':endWork,
        'work_days':json.encode(workDays),
        'experiences':json.encode(experiences),
      },{
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      }
      ,photo
    );
    printNote('End addExpertInfo Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  getExpertInfo(int expertId) async {
    printNote('Start getExpertInfo Remote');
    var response = await apiService.post(AppApiRoute.getExpertInfo, {
      'expert_id':'$expertId'
    },headers: {
      'Authorization': 'Bearer $token',
    });
    printNote('End getExpertInfo Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  getExpertBookings(int expertId) async {
    printNote('Start getExpertBookings Remote');
    var response = await apiService.post(AppApiRoute.getExpertBookings,{
      'expert_id':'$expertId'
    },headers: {
      'Authorization': 'Bearer $token',
    });
    printNote('End getExpertBookings Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  getFollows(int expertId) async {
    printNote('Start getExpertBookings Remote');
    var response = await apiService.post(AppApiRoute.getFollows,{
      'expert_id':'$expertId'
    },headers: {
      'Authorization': 'Bearer $token',
    });
    printNote('End getExpertBookings Remote: $response');
    return response.fold((l) => l, (r) => r);
  }


}
