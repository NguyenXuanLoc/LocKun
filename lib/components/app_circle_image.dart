import 'dart:io';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_network_image.dart';

class AppCircleImage extends StatelessWidget {
  final String? url;
  final String? svgUrl;
  final String urlError;
  final double? height;
  final double? width;
  final Color? backgroundColor;

  const AppCircleImage(
      {Key? key,
      required this.url,
      this.urlError = ';',
      this.height,
      this.backgroundColor,
      this.width,
      this.svgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (svgUrl != null && svgUrl!.isNotEmpty) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: backgroundColor ?? colorBlack.withOpacity(0.2)),
        child: ClipOval(
          child: SizedBox(
            width: height ?? 46,
            height: width ?? 46,
            child: SvgPicture.asset(
              svgUrl ?? '',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (url != null && url!.isNotEmpty) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: backgroundColor ?? colorBlack.withOpacity(0.2)),
        child: ClipOval(
          child: SizedBox(
            width: height ?? 46,
            height: width ?? 46,
            child: AppNetworkImage(
              source: url,
              errorSource: urlError,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: colorBlack.withOpacity(0.2)),
        child: ClipOval(
          child: SizedBox(
            width: height ?? 46,
            height: width ?? 46,
            child: const AppNetworkImage(
              source: '',
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
