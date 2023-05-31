import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:vote/app/network_info.dart';
import 'package:vote/pages/controller/date_time_controller.dart';

class DateTimeBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(DateTimeController(
      Get.put<NetworkInfo>(
          NetworkInfoImpl(Get.put(InternetConnectionChecker())))));
   
  }
}