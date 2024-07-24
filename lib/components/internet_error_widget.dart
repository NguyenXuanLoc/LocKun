import 'package:base_bloc/config/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';
import 'app_text.dart';

class InternetErrorWidget extends StatelessWidget {
  const InternetErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: EdgeInsets.only(bottom: 7 + ConstantKey.BottonNavHeight),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
            decoration: BoxDecoration(
                color: colorGrey40.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20)),
            child: AppText(
              LocaleKeys.Network_error_Pull_to_refresh_and_try_again.tr(),
              style: typoW500.copyWith(fontSize: 12),
            )));
  }
}
