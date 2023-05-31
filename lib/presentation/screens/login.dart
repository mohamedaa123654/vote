import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import 'package:vote/app/cache_helper.dart';
import 'package:vote/app/routes_manager.dart';
import 'package:vote/app/constant.dart';
import 'package:vote/presentation/widgets/custom_button.dart';
import 'package:vote/presentation/widgets/custom_text_button.dart';
import 'package:vote/presentation/widgets/custom_text_feild.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(height: 100, child: Image.asset(kLogo)),
                const Text(
                  'We Chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                  // height: SizeConfig.screenHeight! * 0.1,
                ),
                Row(
                  children: const [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                  prefix: Icons.email_outlined,
                  hint: 'Enter Your Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: 'Password',
                  onChanged: (data) {
                    password = data;
                  },
                  prefix: Icons.lock_outline,
                  hint: 'Enter Your Password',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Custom_Button(
                  text: 'Login',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      // await loginUser();

                      if (formKey.currentState!.validate()) {
                        try {
                          await loginUser();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('No user found for that email.'),
                            ));
                            // print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  'Wrong password provided for that user.'),
                            ));
                            // print('Wrong password provided for that user.');
                          }
                        } catch (ex) {
                          
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('There was an error'),
                          ));
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Are you a user? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    Custom_Text_Button(
                      onTap: () {
                        Get.offAllNamed(Routes.registerRoute);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => Register()));
                      },
                      text: 'Register',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      if (value.user!.uid == adminId) {
        Get.offAllNamed(Routes.adminRoute);
        CacheHelper.saveDataSharedPreference(key: 'iaAdmin', value: true);
        CacheHelper.saveDataSharedPreference(key: 'isLogined', value: true);
      } else {
        Get.bottomSheet(
          Padding(
            padding: EdgeInsets.all(4.0.w),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(2.sp),
              ),
              height: 5.h,
              width: 100.w,
              child: Padding(
                padding: EdgeInsets.all(2.w),
                child: const Text(
                  'you not an admin',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          barrierColor: Colors.transparent,
        );
      }
    });
  }

  // Future<void> loginUser() async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email!, password: password!);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('No user found for that email.'),
  //       ));

  //       // print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Wrong password provided for that user.'),
  //       ));

  //       // print('Wrong password provided for that user.');
  //     }
  //   }
  //   isLoading = false;
  //   setState(() {});
  // }
}
