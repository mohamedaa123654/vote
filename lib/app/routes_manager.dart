import 'package:get/get.dart';
import 'package:vote/presentation/screens/admin_screen.dart';
import 'package:vote/presentation/controller/date_time_binding.dart';
import 'package:vote/presentation/screens/login.dart';
import 'package:vote/presentation/screens/main_screen.dart';
import 'package:vote/presentation/screens/register.dart';
import 'package:vote/presentation/screens/splash_view.dart';
import 'package:vote/presentation/screens/varify_screen.dart';

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
