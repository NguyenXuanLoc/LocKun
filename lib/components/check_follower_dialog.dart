import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_button.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class CheckFollowerDialog extends StatefulWidget {
  final VoidCallback checkOnClick;

  const CheckFollowerDialog({Key? key, required this.checkOnClick})
      : super(key: key);

  @override
  State<CheckFollowerDialog> createState() => _CheckFollowerDialogState();
}

class _CheckFollowerDialogState extends State<CheckFollowerDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(contentPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7), color: colorWhite),
        child: Column(children: [
          AppText(ConstantKey.appName, style: typoW700.copyWith(fontSize: 18)),
          space(),
          AppText(
              '${LocaleKeys.Your_account_is_inactive_Click_Check_if_your_account_has_more_than_250_followers_already.tr()}\n\n${LocaleKeys.This_process_may_takes_for_few_minutes_We_will_notify_you_when_we_have_the_results.tr()}',
              style: typoW400.copyWith(fontSize: 14),
              textAlign: TextAlign.center),
          space(height: 35),
          Row(children: [
            const SizedBox(width: 40),
            Expanded(
                child: button(LocaleKeys.Check.tr(), HexColor('25C769'),
                    colorWhite, () => widget.checkOnClick.call())),
            const SizedBox(width: 14),
            Expanded(
                child: button(LocaleKeys.Cancel.tr(), HexColor('EFEFEF'),
                    colorBlack, () => Navigator.pop(context))),
            const SizedBox(width: 40)
          ])
        ]));
  }

  Widget button(String title, Color backgroundColor, Color colorText,
          VoidCallback callback) =>
      AppButton(
          title: title,
          width: MediaQuery.of(context).size.width,
          onPress: () => callback.call(),
          height: 43,
          borderRadius: 10,
          backgroundColor: backgroundColor,
          textStyle: typoW600.copyWith(fontSize: 16, color: colorText));

  Widget space({double? height}) => SizedBox(height: height ?? 15);
}
