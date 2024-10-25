import 'package:base_bloc/modules/home_page/home_page.dart';
import 'package:base_bloc/modules/pass/pass_state.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassBloc extends Cubit<PassState> {
  final TextEditingController controller = TextEditingController();

  PassBloc() : super(PassState());

  void onPassChange(String text, BuildContext context) {
    if (text.length >= 8 && text != state.pass) {
      controller.text = '';
      toast("TRY AGAIN");
    }
    if (text == state.pass) {
      controller.text = '';
      RouterUtils.pushTo(context, HomePage());
    }
  }
}
