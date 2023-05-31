import 'package:vote/data/models/now_time.dart';
import 'package:vote/domain/repository/base_repository.dart';

class GetnowTimeUseCase {
  final BaseRepository repository;

  GetnowTimeUseCase(this.repository);

  Future<NowTimeModel> execute() async {
    return await repository.getTime();
  }
}
