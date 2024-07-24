import 'package:base_bloc/data/eventbus/open_new_page_event.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../data/globals.dart' as globals;
import 'application.dart';

class RouterUtils {
  static void pushFromHomeTo(Widget newPage, {bool isReplace = false}) =>
      Utils.fireEvent(OpenNewPageEvent(newPage, isReplace: isReplace));

  static Future<dynamic> pushTo(BuildContext? context, Widget newPage,
      {bool isReplace = false,bool isFromBottomTopTop = false}) async {
    if(context==null) return;
    var begin =
        isFromBottomTopTop ? const Offset(0.0, 1.0) : const Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    if (isReplace) {
      return await Navigator.of(context).pushAndRemoveUntil<void>(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => newPage,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child);
            }),
          (Route<dynamic> route) => false);
    }
    return await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => newPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          if (animation.status == AnimationStatus.reverse && globals.isQrCode && globals.popWithNewAnimation) {
            var begin = const Offset(0.0, 1.0);
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
                position: animation.drive(tween), child: child);
          }
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  static push<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.router.navigateTo(context, route,
        transition: TransitionType.inFromBottom,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static Future<T> pushDeal<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.routerDeal.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static Future<T> pushMap<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.routerMap.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static Future<T> pushQr<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.routerQr.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static Future<T> pushNotify<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.routerNotify.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static Future<T> pushProfile<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.routerProfile.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }
}
