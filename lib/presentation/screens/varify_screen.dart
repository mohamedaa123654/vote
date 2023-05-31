import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vote/app/cache_helper.dart';
import 'package:vote/app/constant.dart';
import 'package:vote/presentation/widgets/loading_widget.dart';
import 'package:vote/data/models/user_model.dart';
import 'package:vote/presentation/screens/main_screen.dart';

class VerifyScreen extends StatelessWidget {
  ScrollController _controllerAnimation = ScrollController();
  final DocumentReference itemRef = FirebaseFirestore.instance
      .collection(kUsersCollections)
      .doc(CacheHelper.getDataFromSharedPreference(key: 'email'));

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments.toString();
    return StreamBuilder<DocumentSnapshot>(
      stream: itemRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User userData = User.fromJson(snapshot.data);

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
            ),
            body: userData.verification == true
                ? MainScreen()
                : Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 100.w,
                                height: 40.h,
                                child: 
                                  const Center(child: CircularProgressIndicator(color: kPrimaryColor,strokeWidth: 20,)),
                                
                              ),
                              const Text(
                                'Please wait to verify your details',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
         
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}
