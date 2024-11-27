import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/modules/web/web_state.dart';

class WebBloc extends BaseCubit<WebState> {
  WebBloc() : super(WebState());

  void setLoading(bool value) => emit(state.copyOf(isLoading: value));

  void onProgressChange(int value) {
    emit(state.copyOf(value: value));
  }
}
