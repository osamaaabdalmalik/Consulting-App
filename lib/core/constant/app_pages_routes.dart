

import 'package:consultancy/core/middleware/start_middleware.dart';
import 'package:consultancy/view/screen/auth/chose_garde_screen.dart';
import 'package:consultancy/view/screen/auth/login_screen.dart';
import 'package:consultancy/view/screen/auth/register_screen.dart';
import 'package:consultancy/view/screen/expert/home_expert_screen.dart';
import 'package:consultancy/view/screen/expert/info_expert_screen.dart';
import 'package:consultancy/view/screen/user/category_experts_screen.dart';
import 'package:consultancy/view/screen/user/details_expert_screen.dart';
import 'package:consultancy/view/screen/user/home_user_screen.dart';
import 'package:get/get.dart';


abstract class AppPagesRoutes{
  // Auth
  static const String onBoarding = "/onBoarding";
  static const String choseGarde = "/";
  static const String register = "/register";
  static const String login = "/login";

  // User
  static const String userHome = "/userHome";
  static const String categoryExperts = "/categoryExperts";
  static const String expertDetails = "/expertDetails";

  // Expert
  static const String expertHome = "/expertHome";
  static const String addInfo = "/addInfo";

  static List<GetPage<dynamic>> appPages = [
    // Auth
    GetPage(name: choseGarde, page: () => ChoseGardeScreen(),middlewares: [StartMiddleWare()]),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),

    // User
    GetPage(name: userHome, page: () => HomeUserScreen()),
    GetPage(name: categoryExperts, page: () => CategoryExpertsScreen()),
    GetPage(name: expertDetails, page: () => ExpertDetailsScreen()),

    // Expert
    GetPage(name: expertHome, page: () => HomeExpertScreen()),
    GetPage(name: addInfo, page: () => InfoExpertScreen()),
  ];
}


