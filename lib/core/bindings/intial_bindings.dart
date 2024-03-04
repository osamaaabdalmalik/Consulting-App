
// import 'package:consultancy/controller/local_controller.dart';
// import 'package:consultancy/core/services/shared_preferences_service.dart';
import 'package:consultancy/core/services/api_service.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() async{
    // await Get.putAsync(() => SharedPreferencesService().init());
    Get.put(ApiService());
    // Get.put(LocaleController());
  }
}
