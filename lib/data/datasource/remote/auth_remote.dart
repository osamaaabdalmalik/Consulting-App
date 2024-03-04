
import 'package:consultancy/core/constant/app_api_routes.dart';
import 'package:consultancy/core/functions/helper_function.dart';
import 'package:consultancy/core/services/api_service.dart';

class AuthRemote
{
    ApiService apiService;
    AuthRemote(this.apiService);

    loginUser(String phoneNumber ,String password) async {
      printNote('Start loginUser Remote');
      var response = await apiService.post(AppApiRoute.loginUser, {
        "phone_number" : phoneNumber ,
        "password" : password
      });
      printNote('End loginUser Remote: $response');
      return response.fold((l) => l, (r) => r);
    }
    loginExpert(String phoneNumber ,String password) async {
      printNote('Start loginExpert Remote');
      var response = await apiService.post(AppApiRoute.loginExpert, {
        "phone_number" : phoneNumber ,
        "password" : password
      });
      printNote('End loginExpert Remote: $response');
      return response.fold((l) => l, (r) => r);
    }
    registerUser(String name ,String phoneNumber,String password,String confirmPassword) async {
      printNote('Start registerUser Remote');
      var response = await apiService.post(AppApiRoute.registerUser, {
        "name" : name ,
        "phone_number" : phoneNumber  ,
        "password" : password  ,
        "password confirmation" : confirmPassword  ,
      });
      printNote('End registerUser Remote: $response');
      return response.fold((l) => l, (r) => r);
    }
    registerExpert(String name ,String phoneNumber,String password,String confirmPassword  ) async {
      printNote('Start registerExpert Remote');
      var response = await apiService.post(AppApiRoute.registerExpert, {
        "name" : name ,
        "phone_number" : phoneNumber  ,
        "password" : password  ,
        "password confirmation" : confirmPassword  ,
      });
      printNote('End registerExpert Remote: $response');
      return response.fold((l) => l, (r) => r);
    }
    logoutUser(token) async {
      printNote('Start registerUser Remote');
      var response = await apiService.post(AppApiRoute.logoutUser, {},
          headers:{
            'Authorization': 'Bearer $token}',
          } );
      printNote('End registerUser Remote: $response');
      return response.fold((l) => l, (r) => r);
    }
    logoutExpert(token) async {
      printNote('Start registerExpert Remote');
      var response = await apiService.post(AppApiRoute.logoutExpert, {},
          headers:{
            'Authorization': 'Bearer $token',
          } );
      printNote('End registerExpert Remote: $response');
      return response.fold((l) => l, (r) => r);
    }

}
