import 'package:base_bloc/utils/log_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../config/constant.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    Key? key,
    this.loadStateCallBack,
    this.enableLoadState = false,
    this.source,
    this.style = "none",
    this.fit = BoxFit.cover,
    this.decoration,
    this.errorSource =
        'https://platform-static-files.s3.amazonaws.com/premierleague/photos/players/250x250/Photo-Missing.png',
  }) : super(key: key);
  final String errorSource;
  final String? source;
  final String? style;
  final BoxFit? fit;
  final BoxDecoration? decoration;
  final Function(LoadState)? loadStateCallBack;
  final bool enableLoadState;

  @override
  Widget build(BuildContext context) {
    return (source != null && (source ?? '').isNotEmpty)
        ? ExtendedImage.network(
            gaplessPlayback: true,
            (source ?? ""),
            enableLoadState: false, loadStateChanged: (state) {
            if (state.extendedImageLoadState == LoadState.completed) {
              if (loadStateCallBack != null) {
                loadStateCallBack?.call(state.extendedImageLoadState);
              }
              return state.completedWidget;
            }
            return const SizedBox();
          }, fit: fit ?? BoxFit.cover)
        : const SizedBox();
  }
}
