import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vote/app/cache_helper.dart';
import 'package:vote/app/routes_manager.dart';
import 'package:vote/componants/constant.dart';

class FinishScreen extends StatelessWidget {
  const FinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kLogo,
                height: 45,
              ),
              const Text(
                'Vote',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
          leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.offAllNamed(Routes.loginRoute);
                      CacheHelper.saveDataSharedPreference(
                          key: 'isLogined', value: false);
                    }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.mood,
                  color: kPrimaryColor,
                  size: 200,
                ),
                SizedBox(
                  height: 5.h,
                ),
                const Text(
                  'Thank you For Your vote.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ));
  }
}
