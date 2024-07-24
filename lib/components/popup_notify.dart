import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base/hex_color.dart';
import '../data/globals.dart';
import '../../generated/locale_keys.g.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';
import 'app_text.dart';

class PopupNotifyWidget extends StatelessWidget {
  final VoidCallback dismissCallback;
  final RemoteMessage? remoteMessage;
  final bool isNotify;

  const PopupNotifyWidget(
      {Key? key,
      required this.remoteMessage,
      required this.dismissCallback,
      required this.isNotify})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        width: MediaQuery.of(context).size.width,
        top: !isNotify ? -500 : MediaQuery.of(context).padding.top,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeOut,
        child: Material(
            color: colorTransparent,
            child: InkWell(
                child: Container(
                    margin: EdgeInsets.only(
                        left: contentPadding, right: contentPadding),
                    decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        decoration: BoxDecoration(
                            color: colorBlack.withOpacity(0.055),
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.all(contentPadding),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                  AppText(
                                      maxLine: 1,
                                      overflow: TextOverflow.ellipsis,
                                      remoteMessage?.notification?.title ?? '',
                                      style: typoW700.copyWith(fontSize: 14)),
                                  const SizedBox(height: 3),
                                  AppText(
                                      maxLine: 2,
                                      overflow: TextOverflow.ellipsis,
                                      remoteMessage?.notification?.body ?? '',
                                      style: typoW400.copyWith(fontSize: 14))
                                ])),
                            const SizedBox(width: 10),
                            AppText(LocaleKeys.now.tr().toLowerCase(),
                                style: typoW400.copyWith(
                                      fontSize: 14, color: HexColor('C4C4C4')))
                            ]))),
                onTap: () => dismissCallback.call())));
  }
}
