import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/modules/home_page/home_state.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../router/router_utils.dart';
import '../web/web_page.dart';

class HomeBloc extends BaseCubit<HomeState> {
  HomeBloc() : super(HomeState(lContent: List.empty(growable: true))) {
    getData();
  }

  void onRefresh() {
    getData();
  }

  void inputData() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    var value = data?.text ?? '';
    if (value.isNotEmpty) {
      if (StorageUtils.saveData(value)) {
        state.lContent.insert(0, value);
        emit(state.copyOf(isRefreshUi: !state.isRefreshUi));
        toast("INPUT SUCCESS");
      } else {
        toast("IS EMPTY OR EXISTED");
      }
    }
  }

  void deleteOnClick(String value, index) {
    state.lContent.removeAt(index);
    emit(state.copyOf(isRefreshUi: !state.isRefreshUi));
    StorageUtils.removeData(value);
    toast("DELETE SUCCESS");
  }

  void copyBoardOnClick(String value, BuildContext context) {
    RouterUtils.pushTo(context, WebPage(url: value));
  }

  void getData() {
    var lContent = StorageUtils.getAllData();
    emit(state.copyOf(lContent: lContent));
  }
}
