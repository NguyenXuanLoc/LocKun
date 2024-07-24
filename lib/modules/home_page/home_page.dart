import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/modules/home_page/home_bloc.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final bool isOpenLoginScreen;

  const HomePage({Key? key, this.isOpenLoginScreen = false}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeBloc> {
  @override
  void init() {}

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AppScaffold(
          extendBody: true,
          backgroundColor: colorTransparent,
          isFullScreen: true,
          isPadding: false,
          body: Container(color: colorWhite))
    ]);
  }

  @override
  HomeBloc createCubit() => HomeBloc();
}
