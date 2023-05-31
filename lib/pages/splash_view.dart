import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vote/app/cache_helper.dart';
import 'package:vote/app/routes_manager.dart';
import 'package:vote/pages/finish_screen.dart';
import '../componants/constant.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  bool isVoted = false;
  _goNext() async {
    print(CacheHelper.getDataFromSharedPreference(key: 'email'));
    await FirebaseFirestore.instance
        .collection('isVoted')
        .doc(CacheHelper.getDataFromSharedPreference(key: 'email'))
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;

        // Access specific fields from the document
        isVoted = data['isVoted'];
      }
    });
    if (CacheHelper.getDataFromSharedPreference(key: 'iaAdmin') != null &&
        CacheHelper.getDataFromSharedPreference(key: 'iaAdmin')) {
      Get.offAllNamed(Routes.adminRoute);
        }else
    if (CacheHelper.getDataFromSharedPreference(key: 'isLogined') != null &&
        CacheHelper.getDataFromSharedPreference(key: 'isLogined') &&
        !isVoted) {
      Get.offAllNamed(Routes.varifyRoute);
    } else if (isVoted) {
      Get.offAll(FinishScreen());
    } else {
      Get.offAllNamed(Routes.registerRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(child: Image(image: AssetImage(kLogo))),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
