import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vote/app/network_info.dart';
import 'package:vote/data/datasource/remote/remote_datasource.dart';
import 'package:vote/data/models/now_time.dart';
import 'package:vote/data/repository/repository.dart';
import 'package:vote/domain/repository/base_repository.dart';
import 'package:vote/domain/usecases/get_now_time_usecase.dart';

class DateTimeController extends GetxController {
  final NetworkInfo networkInfo;
  DateTimeController(this.networkInfo);
  RxBool hasPermission = false.obs;
  RxBool isConnected = false.obs;
  RxBool isDataLoaded = false.obs;
  // final formatNumber = NumberFormat.decimalPattern('ar');

  @override
  void onInit() async {
    // if (await networkInfo.isConnected) {
    //   getPrayTime(AppConstants.lat, AppConstants.long);

    //   isConnected.value = true;
    // } else {
    //   isConnected.value = false;
    // }
    await getNowTime();
    await getVoteTime();
    // startCountdown();
    super.onInit();
  }

  NowTimeModel? nowTimeModel;
  DateTime? timeNow;
  // --------------------------------------------------Get Time Now Data
  getNowTime() async {
    try {
      BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
      final BaseRepository baseRepository = Repository(baseRemoteDataSource);

      final model = await GetnowTimeUseCase(baseRepository).execute();

      if (model != null) {
        nowTimeModel = model;
        timeNow =
            DateFormat("yyyy-MM-ddTHH:mm").parse("${nowTimeModel!.datetime!}");
        print('///////// getNowTime ${nowTimeModel!.datetime.toString()}');
        print('///////// getNowTime ${timeNow}');
      }
    } catch (e) {
      print(e);
    }
  }

// --------------------------------------------------Get Vote Time Data

  DateTime? voteTimeDate;
  NowTimeModel? voteNowModel;
  RxBool isReminded = false.obs;
  Future<void> getVoteTime() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('voteTime')
          .doc('voteTime')
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        // Access the document fields using data['field']
        if (data['dateTime'] != '') {
          isReminded.value = true;
          String fieldValue = data['dateTime'] as String;
          voteTimeDate = DateFormat("yyyy-MM-ddTHH:mm").parse("${fieldValue}");

          await startCountdown();
        }
        print(data);
      } else {
        print('Document does not exist');
      }
    } catch (error) {
      print('Error retrieving document: $error');
    }
  }

  List<String>? nextPrayer;
  List<List<String>> allPrayers = [];
  List<String>? previousPrayer;
  DateTime? nextPrayerTime;
  DateTime? previousPrayerTime;
  double? counter;

  RxInt remainingSeconds = 0.obs;
  RxInt endTime = 2.obs;
  late Timer timer;
  int timeBetween = 0;
  RxDouble percentage = 0.0.obs;

  startCountdown() async {
    remainingSeconds.value = voteTimeDate!.difference(timeNow!).inSeconds;
    print('remainingSeconds.value${remainingSeconds.value}');

    timeBetween = voteTimeDate!.difference(timeNow!).inSeconds;
    endTime.value = voteTimeDate!.millisecondsSinceEpoch + 1000 * 30;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (remainingSeconds.value > 1) {
        remainingSeconds.value--;
        percentage.value = 1 - (remainingSeconds.value / timeBetween);
      } else if (remainingSeconds.value == 1) {
        timer.cancel();
      }
    });
  }
}
