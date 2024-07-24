import 'package:base_bloc/components/read_more.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../generated/locale_keys.g.dart';

class ReadMoreWidget extends StatelessWidget {
  final String message;
  final TextStyle? style;
  final TextStyle? moreStyle;

  const ReadMoreWidget(
      {Key? key, required this.message, this.style, this.moreStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(message,
        trimLines: 3,
        style: style ?? typoW400,
        textAlign: TextAlign.start,
        colorClickableText: colorGreen60,
        trimMode: TrimMode.Line,
        lessStyle: moreStyle,
        moreStyle: moreStyle,
        trimCollapsedText: '\n${LocaleKeys.show_more.tr()}',
        trimExpandedText: '\n${LocaleKeys.show_less.tr()}',
        delimiter: '...');
  }
}
