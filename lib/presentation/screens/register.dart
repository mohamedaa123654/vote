import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import 'package:vote/app/cache_helper.dart';
import 'package:vote/app/routes_manager.dart';
import 'package:vote/app/constant.dart';
import 'package:vote/presentation/widgets/custom_button.dart';
import 'package:vote/presentation/widgets/custom_text_button.dart';
import 'package:vote/presentation/widgets/custom_text_feild.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);
  CollectionReference user =
      FirebaseFirestore.instance.collection(kUsersCollections);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;
  String? name;
  String? imageUrl;
  XFile? imageFile;
  String? password;
  RxString fileName = ''.obs;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController imageController =
      TextEditingController(text: 'Open Camera');
  XFile? file;

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
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 45.sp,
                    ),
                    const Text(
                      'Vote',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: const [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: userNameController,
                  label: 'UserName',
                  onChanged: (data) {
                    name = data;
                  },
                  prefix: Icons.person_outline,
                  hint: 'Enter Your name',
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: emailController,
                  label: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                  prefix: Icons.email_outlined,
                  hint: 'Enter Your Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  label: 'Password',
                  onChanged: (data) {
                    password = data;
                  },
                  prefix: Icons.lock_outline,
                  hint: 'Enter Your Password',
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    setState(() {});
                    imageFile = await pickImage();
                    fileName.value = imageFile!.name;
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3),
                            child: Icon(
                              Icons.image_outlined,
                              color: kPrimaryColor,
                              size: 48,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Obx(() {
                        return Expanded(
                          child: Text(
                            fileName.value == ''
                                ? 'Open Camera'
                                : fileName.value,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Custom_Button(
                  onTap: () async {
                    if (fileName.value != '') {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        await registerUser(context);
                        imageUrl = await upload(imageFile);
                        if (imageUrl != null) {
                          widget.user.doc('$email').set({
                            'name': name,
                            'user': email,
                            'image': imageUrl,
                            'verification': false,
                          });
                          Get.offAllNamed(Routes.varifyRoute);
                        }
                      }
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
                              child: Text(
                                'you should pick an image for your id',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        barrierColor: Colors.transparent,
                      );
                    }
                  },
                  text: 'Register',
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Are You An Admin? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    Custom_Text_Button(
                      text: 'Login',
                      onTap: () {
                        Get.offAllNamed(Routes.loginRoute);
                      },
                    )
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  registerUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      CacheHelper.saveDataSharedPreference(key: 'isLogined', value: true);
      CacheHelper.saveDataSharedPreference(key: 'email', value: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The password provided is too weak.')),
        );
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    setState(() {});
  }
}

Future<String> upload(pickedFile) async {
  if (pickedFile != null) {
    File image = File(pickedFile.path);
    String fileName = DateTime.now().toString();

    try {
      // Uploading the image to Firebase Storage
      TaskSnapshot snapshot =
          await FirebaseStorage.instance.ref('images/$fileName').putFile(image);

      // Getting the image URL from Firebase Storage
      // String imageUrl = await snapshot.ref.getDownloadURL();

      print('Image uploaded successfully!');
      return await snapshot.ref.getDownloadURL();
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
  } else {
    return '';
  }
}

Future<XFile?> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  return pickedFile;
}
