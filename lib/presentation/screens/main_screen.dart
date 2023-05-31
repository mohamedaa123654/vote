import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:vote/app/network_info.dart';
import 'package:vote/app/constant.dart';
import 'package:vote/presentation/widgets/counter.dart';
import 'package:vote/presentation/widgets/loading_widget.dart';
import 'package:vote/presentation/widgets/vote_list.dart';
import 'package:vote/presentation/controller/date_time_controller.dart';

class MainScreen extends StatelessWidget {
  // final _controllerAnimation = ScrollController();
  DateTimeController controller = Get.put(DateTimeController(
      Get.put<NetworkInfo>(
          NetworkInfoImpl(Get.put(InternetConnectionChecker())))));
  ScrollController _controllerAnimation = ScrollController();

  final DocumentReference voteTime =
      FirebaseFirestore.instance.collection('voteTime').doc('voteTime');

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments.toString();

    return StreamBuilder<DocumentSnapshot>(
        stream: voteTime.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String dateTime = snapshot.data!['voteTime'];

            return Column(
              children: [
                Expanded(
                    child: Center(
                        child: dateTime == ''
                            ? Column(
                                children: const [
                                  CircularProgressIndicator(
                                    color: kPrimaryColor,
                                    strokeWidth: 20,
                                  ),
                                  Text(
                                    'The voting time Not Reminded',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ],
                              )
                            : Obx(() {
                                return controller.percentage.value > 0
                                    ? CircularPercentIndicator(
                                        radius: 40.w,
                                        lineWidth: 6.sp,
                                        percent: controller.percentage.value,
                                        
                                        center: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'The voting will star after',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: kPrimaryColor,
                                                  fontSize: 16.sp),
                                            ),
                                            CounterDown(controller: controller),
                                          ],
                                        ),
                                        progressColor: kPrimaryColor,
                                      )
                                    : MyListPage();
                              }))),
              ],
            );
          } else {
            return LoadingWidget();
          }
        });
  }
}
