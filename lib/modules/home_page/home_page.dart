import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_bar_widget.dart';
import 'package:base_bloc/components/app_not_data_widget.dart';
import 'package:base_bloc/components/app_refresh_widget.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/item_content_widget.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/gen/assets.gen.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/modules/home_page/home_bloc.dart';
import 'package:base_bloc/modules/home_page/home_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      AppRefreshWidget(
          onRefresh: () => bloc.onRefresh(),
          child: AppScaffold(
              appbar: AppbarWidget(action: [
                InkWell(
                    onTap: () => bloc.inputData(),
                    child: SvgPicture.asset(Assets.svg.icCopy)),
                SizedBox(width: contentPadding)
              ]),
              extendBody: true,
              backgroundColor: colorBlack,
              isFullScreen: true,
              isPadding: false,
              body: BlocBuilder<HomeBloc, HomeState>(
                  builder: (c, state) => state.lContent.isEmpty
                      ? Center(child: AppNotDataWidget(isStack: true))
                      : ListView.separated(
                          itemBuilder: (c, i) => ItemContentWidget(
                              content: state.lContent[i],
                              index: i,
                              deleteOnClick: () =>
                                  bloc.deleteOnClick(state.lContent[i], i),
                              copyBoardOnClick: () => bloc.copyBoardOnClick(
                                  state.lContent[i], context)),
                          itemCount: state.lContent.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 10)),
                  bloc: bloc)))
    ]);
  }

  @override
  HomeBloc createCubit() => HomeBloc();
}
