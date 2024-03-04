import 'package:consultancy/core/constant/app_pages_routes.dart';
import 'package:consultancy/core/constant/app_shared_keys.dart';
import 'package:consultancy/core/services/shared_preferences_service.dart';
import 'package:get/get.dart';

class ChoseGardeController extends GetxController {

  late SharedPreferencesService sharedService;
  @override
  void onInit() {
    sharedService = Get.find();
    super.onInit();
  }

  goToLogin(String garde){
    sharedService.sharedPreferences.setString(AppSharedKeys.garde, garde) ;
    Get.toNamed(AppPagesRoutes.login);
  }
}
