import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/modules/home_page/home_state.dart';

class HomeBloc extends BaseCubit<HomeState> {
  HomeBloc() : super(HomeState()) {}
}
