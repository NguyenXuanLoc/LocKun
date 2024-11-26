import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/modules/pass/pass_bloc.dart';
import 'package:base_bloc/modules/pass/pass_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../base/base_state.dart';

class PassPage extends StatefulWidget {
  const PassPage({super.key});

  @override
  State<PassPage> createState() => _PassPageState();
}

class _PassPageState extends BaseState<PassPage, PassBloc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          const SizedBox(height: 250),
          BlocBuilder<PassBloc, PassState>(
              builder: (c, state) => AppText(state.input,
                  style: typoW500.copyWith(color: colorWhite)),
              bloc: bloc),
          CustomKeyBoard(
              onChanged: (s) => bloc.onPassChange(s, context),
              keysTextStyle: typoW700.copyWith(fontSize: 34),
              controller: bloc.controller,
              pinTheme: PinTheme(keysColor: Colors.white),
              maxLength: 10),
          const SizedBox(height: 250),
        ]));
  }

  @override
  PassBloc createCubit() => PassBloc();

  @override
  void init() {}
}
