import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vote/componants/constant.dart';
import 'package:vote/pages/controller/date_time_controller.dart';

class CounterDown extends StatelessWidget {
  CounterDown({
    super.key,
    required this.controller,
    // this.onEnd
  });

  final DateTimeController controller;
  // void Function()? onEnd;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: CountdownTimer(
          endTime: controller.endTime.value,
          onEnd: () {
            // onEnd;
            print('end');
          },
          textStyle: TextStyle(
              // fontWeight: FontWeight.bold,
              fontFamily: 'Maghribi',
              color: kPrimaryColor,
              fontSize: 16.sp),
        ),
      );
    });
    // }
  }
}
