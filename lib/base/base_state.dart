import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../data/eventbus/app_theme_event.dart';
import '../data/eventbus/change_language_event.dart';
import '../data/eventbus/switch_tab_event.dart';
import '../utils/app_utils.dart';
import 'bloc.dart';

abstract class BaseState<T extends StatefulWidget, X extends Cubit>
    extends BaseSetState<T> {
  StreamSubscription<ChangeLanguageEvent>? changeLanguageEvent;
  StreamSubscription<AppThemeEvent>? pppThemeEvent;
  late X bloc;

  void init();

  X createCubit();

  @override
  void dispose() {
    changeLanguageEvent?.cancel();
    pppThemeEvent?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    changeLanguageEvent = Utils.eventBus
        .on<ChangeLanguageEvent>()
        .listen((event) => setState(() {}));
    pppThemeEvent =
        Utils.eventBus.on<AppThemeEvent>().listen((event) => setState(() {}));
    bloc = createCubit();
    super.initState();
    init();
  }

}

abstract class BasePopState<T extends StatefulWidget, X extends Cubit>
    extends BaseState<T, X> {

  StreamSubscription<SwitchTabEvent>? _goRoot;

  Widget buildWidget(BuildContext context);

  int get tabIndex;

  bool get isWeb => false;

  final BasePopBloc _basePopBloc = BasePopBloc();

  // Handle visibility of this page
  Key? _key;
  double _isVisible = 0;

  @override
  void initState() {
    super.initState();
    _key = Key(hashCode.toString());
    BackButtonInterceptor.add(backInterceptor);
    subscribeGoRoot();
  }

  @override
  void dispose() {
    _basePopBloc.close();
    BackButtonInterceptor.remove(backInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key!,
      onVisibilityChanged: (info) {
        _isVisible = info.visibleFraction;
      },
      child: BlocListener(
        bloc: _basePopBloc,
        child: buildWidget(context),
        listener: (context, state) {
          if (state is BackBasePopState) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void subscribeGoRoot() {
    _goRoot = Utils.eventBus.on<SwitchTabEvent>().listen((event) {
      if (event.index != tabIndex || _isVisible <= 0) {
        return;
      }
      _goRoot!.cancel();
      if (isWeb) {
        onBackPressed(true);
      } else {
        _basePopBloc.emit(BackBasePopState());
      }
    });
  }

  bool onBackPressed(bool stopDefaultButtonEvent) {
    return true;
  }

  bool backInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    var backPress = true;
    if (_isVisible > 0) {
      if (!stopDefaultButtonEvent) {
        if (isWeb) {
          backPress = onBackPressed(false);
        } else {
          _basePopBloc.emit(BackBasePopState());
        }
      }
    } else {
      backPress = false;
    }

    return backPress;
  }
}

abstract class BaseSetState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(fn) {
    if (!mounted) {
      return;
    }
    super.setState(fn);
  }
}
