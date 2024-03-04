
import 'package:consultancy/core/constant/app_api_routes.dart';
import 'package:consultancy/core/functions/helper_function.dart';
import 'package:consultancy/core/services/api_service.dart';

class UserRemote
{
  ApiService apiService;
  String token;
  UserRemote(this.apiService,this.token);

  getCategories() async {
    printNote('Start getCategories Remote');
    var response = await apiService.get(AppApiRoute.getCategories, {
      'Authorization': 'Bearer $token',
    });
    printNote('End getCategories Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  getFavorites(int id) async {
    printNote('Start getFavorites Remote');
    var response = await apiService.post(AppApiRoute.getFavorites, {
      'user_id':'$id'
    },headers: {
      'Authorization': 'Bearer $token',
    });
    printNote('End getFavorites Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  getUserBookings(int id) async {
    printNote('Start getUserBookings Remote');
    var response = await apiService.post(AppApiRoute.getUserBookings,{
      'user_id':'$id'
    },headers: {
      'Authorization': 'Bearer $token',
    });
    printNote('End getUserBookings Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  getUserInfo(int userId) async {
    printNote('Start mainCategory Remote');
    var response = await apiService.post(AppApiRoute.getUserInfo, {
      'user_id':'$userId'
    },
    headers:{
      'Authorization': 'Bearer $token',
    });
    printNote('End mainCategory Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  getCategoryExperts(int categoryId) async {
    printNote('Start getCategoryExperts Remote');
    var response = await apiService.post(AppApiRoute.getCategoryExperts,{
      'category_id':'$categoryId'
    },headers: {
      'Authorization': 'Bearer $token',
    });
    printNote('End getCategoryExperts Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  changeFavorite(int userId,int expertId) async {
    printNote('Start mainCategory Remote');
    var response = await apiService.post(AppApiRoute.addExpertFavorite, {
      'user_id':'$userId',
      'expert_id':'$expertId'
    },
        headers:{
          'Authorization': 'Bearer $token',
        });
    printNote('End mainCategory Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  ratingExpert(int userId,int expertId,double rating) async {
    printNote('Start mainCategory Remote');
    var response = await apiService.post(AppApiRoute.addRating, {
      'user_id':'$userId',
      'expert_id':'$expertId',
      'rating':'$rating',
    },
        headers:{
          'Authorization': 'Bearer $token',
        });
    printNote('End mainCategory Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  getExpert(int expertId) async {
    printNote('Start getFavorites Remote');
    var response = await apiService.post(AppApiRoute.getExpert, {
      'expert_id':'$expertId'
    },headers: {
      'Authorization': 'Bearer $token',
    });
    printNote('End getFavorites Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  getAvailableDates(int expertId) async {
    printNote('Start getFavorites Remote');
    var response = await apiService.post(AppApiRoute.getAvailable, {
      'expert_id':'$expertId'
    },headers: {
      'Authorization': 'Bearer $token',
    });
    printNote('End getFavorites Remote: $response');
    return response.fold((l) => l, (r) => r);
  }
  addBooking(int userId, int expertId,int dateId) async {
    printNote('Start getFavorites Remote');
    var response = await apiService.post(AppApiRoute.addBooking, {
      'user_id':'$userId',
      'expert_id':'$expertId',
      'date_id':'$dateId',
    },headers: {
      'Authorization': 'Bearer $token',
    });
    printNote('End getFavorites Remote: $response');
    return response.fold((l) => l, (r) => r);
  }

}
