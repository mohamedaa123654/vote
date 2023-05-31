import 'package:get/get.dart';
import 'package:vote/pages/admin_screen.dart';
import 'package:vote/pages/controller/date_time_binding.dart';
import 'package:vote/pages/controller/date_time_controller.dart';
import 'package:vote/pages/login.dart';
import 'package:vote/pages/main_screen.dart';
import 'package:vote/pages/register.dart';
import 'package:vote/pages/splash_view.dart';
import 'package:vote/pages/varify_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String registerRoute = "/register";
  static const String loginRoute = "/login";
  static const String adminRoute = "/admin";
  static const String mainRoute = "/main";
  static const String varifyRoute = "/varify";
}

List<GetPage<dynamic>>? getPages = [
  GetPage(
    name: Routes.splashRoute,
    page: () => const SplashView(),
  ),
  GetPage(
    name: Routes.registerRoute,
    page: () => Register(),
  ),
  GetPage(
    name: Routes.loginRoute,
    page: () => Login(),
  ),
  GetPage(
    name: Routes.adminRoute,
    page: () =>  AdminScreen(),
  ),
  GetPage(
      name: Routes.mainRoute,
      page: () => MainScreen(),
      binding: DateTimeBinding()),
  GetPage(
    name: Routes.varifyRoute,
    page: () => VerifyScreen(),
  ),
];
