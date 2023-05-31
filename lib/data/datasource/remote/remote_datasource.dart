import 'package:dio/dio.dart';
import 'package:vote/app/constant.dart';
import 'package:vote/data/models/now_time.dart';

abstract class BaseRemoteDataSource {
  Future<NowTimeModel?> getTime();
}

class RemoteDataSource implements BaseRemoteDataSource {
  @override
  Future<NowTimeModel?> getTime() async {
    try {
      var response = await Dio().get(baseUrl);

      return NowTimeModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
