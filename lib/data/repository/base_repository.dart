import 'package:base_bloc/data/repository/base_service.dart';

class BaseRepository extends BaseService {
  static BaseRepository instance = BaseRepository._init();

  factory BaseRepository() {
    return instance;
  }

  BaseRepository._init();
}
