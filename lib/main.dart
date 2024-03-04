
import 'package:consultancy/controller/local_controller.dart';
import 'package:consultancy/core/bindings/intial_bindings.dart';
import 'package:consultancy/core/constant/app_colors.dart';
import 'package:consultancy/core/constant/app_pages_routes.dart';
import 'package:consultancy/core/localization/app_translation.dart';
import 'package:consultancy/core/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => SharedPreferencesService().init());
  InitialBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      translations: AppTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'Consultancy',
      color: AppColors.primary,
      locale: controller.language,
      theme: controller.appTheme,
      initialBinding: InitialBindings(),
      getPages: AppPagesRoutes.appPages,
    );
  }
}
