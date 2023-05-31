
import 'package:vote/data/models/now_time.dart';

abstract class BaseRepository {
  Future<NowTimeModel> getTime();
}