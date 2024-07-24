import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/gen/assets.gen.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../base/hex_color.dart';

PreferredSizeWidget AppbarWidget(
        {VoidCallback? goBack,
        ShapeBorder? shapeBorder,
        BuildContext? context,
        Widget? titleWidget,
        Widget? leading,
        double? leadingWidth,
        double? elevation,
        Color? backgroundColor,
        Color? shadowColor,
        Color? backColor,
        String? title,
        List<Widget>? action,
        bool landingMaxSize = false,
        bool isBoldTitle = false,
        bool enableGoBack = true,
        bool? isCenterTitle}) =>
    AppBar(
        toolbarHeight: context != null
            ? ((AppBarTheme.of(context).toolbarHeight ?? 56) + 10)
            : null,
        shape: shapeBorder,
        actions: action,
        leadingWidth: leadingWidth ?? 30,
        backgroundColor: backgroundColor ?? colorBlack,
        leading: leading ??
            (enableGoBack
                ? InkWell(
                    onTap: () => goBack?.call(),
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: landingMaxSize ? 16 : 18,
                            left: contentPadding,
                            bottom: landingMaxSize ? 16 : 18),
                        child: SvgPicture.asset(Assets.svg.icBack,
                            color: colorBlack)))
                : const SizedBox()),
        centerTitle: isCenterTitle ?? false,
        elevation: elevation,
        shadowColor: shadowColor,
        title: titleWidget ??
            AppText(title ?? '',
                style: isBoldTitle
                    ? typoW700.copyWith(fontSize: 25, color: colorBlack)
                    : typoW400.copyWith(fontSize: 25, color: colorBlack)));

Widget AppbarInsideColumnWidget(Widget appbar) =>
    Padding(padding: const EdgeInsets.only(top: 10, bottom: 10), child: appbar);
