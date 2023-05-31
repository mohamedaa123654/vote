import 'package:vote/data/datasource/remote/remote_datasource.dart';
import 'package:vote/data/models/now_time.dart';
import 'package:vote/domain/repository/base_repository.dart';

class Repository implements BaseRepository {
  final BaseRemoteDataSource baseRemoteDataSource;

  Repository(this.baseRemoteDataSource);

  
  @override
  Future<NowTimeModel> getTime()async {
        return (await baseRemoteDataSource.getTime())!;

  }
}