import 'package:base_bloc/data/repository/base_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState);

  var repository = BaseRepository();
}
