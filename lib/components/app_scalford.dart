import 'package:base_bloc/data/globals.dart' as globals;
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appbar;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Widget? bottomNavigationBar;
  final bool isTabToHideKeyboard;
  final bool isPadding;
  final bool isFullScreen;
  final bool isResume; // check for appear screen
  final bool resizeToAvoidBottomInset;
  final VoidCallback? onFocusGained;
  final VoidCallback? onFocusLost;
  final bool? extendBody;

  const AppScaffold(
      {Key? key,
      this.extendBody,
      this.isFullScreen = false,
      this.resizeToAvoidBottomInset = false,
      this.onFocusLost,
      this.onFocusGained,
      required this.body,
      this.appbar,
      this.isResume = false,
      this.isTabToHideKeyboard = false,
      this.backgroundColor,
      this.padding,
      this.bottomNavigationBar,
      this.isPadding = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var content = MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Scaffold(
            extendBody: extendBody ?? false,
            backgroundColor: backgroundColor ?? colorBackgroundColor,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            appBar: appbar,
            body: isFullScreen
                ? SizedBox(
                    width: MediaQuery.of(context).size.width, child: body)
                : SafeArea(
                    minimum: padding ??
                        (isPadding
                            ? EdgeInsets.only(
                                left: globals.contentPadding,
                                right: globals.contentPadding)
                            : EdgeInsets.zero),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width, child: body),
                  ),
            bottomNavigationBar: bottomNavigationBar));
    if (isResume) {
      return FocusDetector(
          onFocusGained: () => onFocusGained?.call(),
          onFocusLost: () => onFocusLost?.call(),
          child: isTabToHideKeyboard
              ? Material(
                  child: GestureDetector(
                      onTap: () => Utils.hideKeyboard(context), child: content))
              : content);
    }
    return isTabToHideKeyboard
        ? Material(
            child: GestureDetector(
                onTap: () => Utils.hideKeyboard(context), child: content))
        : content;
  }
}
