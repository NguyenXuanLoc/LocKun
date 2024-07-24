import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_circle_image.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/data/model/instagram_info_model.dart';
import '../../generated/locale_keys.g.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoginDialog extends StatefulWidget {
  final InstagramInfoModel model;
  final VoidCallback loginOnclick;

  const LoginDialog({Key? key, required this.loginOnclick, required this.model})
      : super(key: key);

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: colorTransparent,
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17), color: colorWhite),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Column(children: [
              AppText(LocaleKeys.For_members_only.tr(),
                  textAlign: TextAlign.center,
                  style: typoW600.copyWith(fontSize: 16)),
              space(height: 7),
              Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text:
                          "${LocaleKeys.Connect_Instagram_to_claim_your_discount.tr()} ${widget.model.username} ? ",
                      style: typoW400.copyWith(fontSize: 14),
                      children: [
                        WidgetSpan(
                            child: AppCircleImage(
                                url: widget.model.profilePicUrl,
                                width: 20,
                                height: 20))
                      ])),
             /* AppText(
                  "${LocaleKeys.Connect_Instagram_to_claim_your_discount.tr()} ${widget.model.username} ?",
                  style: typoW400.copyWith(fontSize: 14),
                  textAlign: TextAlign.center),*/
              space(height: 15),
              Container(height: 1, color: HexColor('DDDDDD')),
              Row(children: [
                buttonWidget(LocaleKeys.ok.tr(), 16, () {
                  Navigator.pop(context);
                  widget.loginOnclick.call();
                }),
                buttonWidget(LocaleKeys.Later.tr(), 16, () {
                  Navigator.pop(context);
                })
              ])
            ])));
  }

  Widget buttonWidget(String title, double fontSize, VoidCallback onPress) =>
      Expanded(
          child: InkWell(
              onTap: () => onPress.call(),
              child: Container(
                height: 45,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: AppText(title,
                    style: typoW600.copyWith(
                        fontSize: fontSize, color: HexColor('329DCB'))),
              )));

  Widget space({double? height}) => SizedBox(height: height ?? 30);
}
