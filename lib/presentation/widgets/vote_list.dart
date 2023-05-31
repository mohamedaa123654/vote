import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vote/app/cache_helper.dart';
import 'package:vote/app/constant.dart';
import 'package:vote/presentation/widgets/loading_widget.dart';
import 'package:vote/data/models/vote_model.dart';
import 'package:vote/presentation/screens/finish_screen.dart';

class MyListPage extends StatefulWidget {
  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  VoteModel? voteModel;
  int selectedIndex = -1;

  CollectionReference vote = FirebaseFirestore.instance.collection('vote');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: vote.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<VoteModel> voteList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              voteList.add(VoteModel.fromJson(snapshot.data!.docs[i]));
            }
            return Column(
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          'Choose',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                              fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 40.h,
                          child: ListView.builder(
                            itemCount: voteList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(voteList[index].name),
                                leading: const Icon(Icons.check_circle_outline),
                                trailing: selectedIndex == index
                                    ? const Icon(Icons.check_circle)
                                    : null,
                                tileColor: index == selectedIndex
                                    ? kPrimaryColor
                                    : null,
                                selected: index == selectedIndex,
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    voteModel = voteList[index];
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (selectedIndex == -1) {
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
                                        'you should vote first',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                                barrierColor: Colors.transparent,
                              );
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.question,
                                animType: AnimType.bottomSlide,
                                title:
                                    'you vote ${voteModel?.name.toString()} ',
                                desc: 'Are You Sure? ',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  FirebaseFirestore.instance
                                      .collection('isVoted')
                                      .doc(CacheHelper
                                          .getDataFromSharedPreference(
                                              key: 'email'))
                                      .set({'isVoted': true});
                                  vote.doc('${voteModel!.id}').set({
                                    'id': voteModel!.id,
                                    'name': voteModel!.name,
                                    'count': voteModel!.count + 1
                                  });
                                  Get.offAll(const FinishScreen());
                                },
                              ).show();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors
                                      .grey; // Color when the button is pressed
                                }
                                return kPrimaryColor; // Default color
                              },
                            ),
                          ),
                          child:  const Text(
                            'Confirm',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    );
            
          } else {
            return const LoadingWidget();
          }
        });
  }
}
