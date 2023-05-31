import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:vote/app/cache_helper.dart';
import 'package:vote/app/routes_manager.dart';
import 'package:vote/app/constant.dart';
import 'package:vote/data/models/user_model.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({super.key});

  ScrollController _controllerAnimation =  ScrollController();
  CollectionReference users =
      FirebaseFirestore.instance.collection(kUsersCollections);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(User.fromJson(snapshot.data!.docs[i]));
              
            }

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
                    icon: const Icon(Icons.arrow_back,color:Colors.white),
                    onPressed: () {
                      Get.offAllNamed(Routes.loginRoute);
                      CacheHelper.saveDataSharedPreference(
                          key: 'iaAdmin', value: false);
                    }),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, top: 4),
                            child: Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (_) => Image.network(
                                                    messagesList[index].image,
                                                    width: 100.w,
                                                    height: 100.h,
                                                  ));
                                        },
                                        child: Image.network(
                                          messagesList[index].image,
                                          width: 25.w,
                                          height: 25.w,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            messagesList[index].name,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryColor),
                                          ),
                                          SizedBox(
                                            height: 4.w,
                                          ),
                                          Text(
                                            messagesList[index].email,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                // fontWeight: FontWeight.bold,
                                                color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          users
                                              .doc(messagesList[index].email)
                                              .update({
                                            'verification': !messagesList[index]
                                                .verification
                                          });
                                        },
                                        icon: Icon(
                                          Icons.check_box,
                                          color:
                                              messagesList[index].verification
                                                  ? kPrimaryColor
                                                  : Colors.grey[400],
                                        ))
                                  ],
                                )),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  MyForm()
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                  child: Text(
                'Loading...',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              )),
            );
          }
        });
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Update Vote Date and Time',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () => _selectDate(context),
                  child: const Icon(
                    Icons.date_range,
                    color: kPrimaryColor,
                    size: 40,
                  )),
              GestureDetector(
                  onTap: () => _selectTime(context),
                  child: const Icon(
                    Icons.access_time,
                    color: kPrimaryColor,
                    size: 40,
                  )),
            ],
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey; // Color when the button is pressed
                  }
                  return kPrimaryColor; // Default color
                },
              ),
            ),
            onPressed: () {
              if (selectedTime != null && selectedDate != null) {
                // Form is valid, perform form submission
                AwesomeDialog(
                                context: context,
                                dialogType: DialogType.question,
                                animType: AnimType.bottomSlide,
                                title:
                                    'You Update Vote Time} ',
                                desc: 'Are You Sure? ',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  FirebaseFirestore.instance
                    .collection('voteTime')
                    .doc('voteTime')
                    .set({
                  'voteTime':
                      '${DateFormat("yyyy-MM-ddT").format(selectedDate!)}${selectedTime!.hour}:${selectedTime!.minute}'
                });
            
                                },
                              ).show();
                           
                  }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }
}
