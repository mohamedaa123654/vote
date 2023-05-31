import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vote/app/constant.dart';
import 'package:vote/presentation/controller/date_time_controller.dart';

class CounterDown extends StatefulWidget {
  CounterDown({
    super.key,
    required this.controller,
    // this.onEnd
  });

  final DateTimeController controller;

  @override
  State<CounterDown> createState() => _CounterDownState();
}

class _CounterDownState extends State<CounterDown> {
  // void Function()? onEnd;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: CountdownTimer(
          endTime: widget.controller.endTime.value,
          onEnd: () {
            // onEnd;
            setState(() {
              // widget.controller.percentage.value = 0.0;
            });
            
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
