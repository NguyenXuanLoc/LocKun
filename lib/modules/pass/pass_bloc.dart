import 'package:base_bloc/modules/home_page/home_page.dart';
import 'package:base_bloc/modules/pass/pass_state.dart';
import 'package:base_bloc/modules/web/web_page.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

class PassBloc extends Cubit<PassState> {
  final TextEditingController controller = TextEditingController();

  PassBloc() : super(PassState());

  Future<void> onPassChange(String text, BuildContext context) async {
    emit(state.copyOf(input: text));
    if (text.length >= 15 && text != state.pass) {
      controller.text = '';
      emit(state.copyOf(input: ''));
      toast("TRY AGAIN");
    }
    if (text == state.pass) {
      emit(state.copyOf(input: ''));
      controller.text = '';
      var isAuth = await _authenticateWithBiometrics();
      if (isAuth) {
        RouterUtils.pushTo(context, HomePage());
      }
    }
  }

  void webViewOnClick(BuildContext context) async {
    var isAuth = await _authenticateWithBiometrics();
    if (isAuth) {
      RouterUtils.pushTo(context, WebPage());
    }
  }

  Future<bool> _authenticateWithBiometrics() async {
    try {
      return await LocalAuthentication().authenticate(
          localizedReason: 'Nhanh ko Cúk',
          authMessages: [],
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: true));
    } on PlatformException catch (e) {
      return false;
    }
  }
}
