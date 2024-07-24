import '../../generated/locale_keys.g.dart';
import 'package:base_bloc/utils/permission_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../base/hex_color.dart';
import '../gen/assets.gen.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';
import 'app_button.dart';
import 'app_scalford.dart';
import 'app_text.dart';

class LocationPermissionWidget extends StatefulWidget {
  final VoidCallback locationOnclick;

  const LocationPermissionWidget({Key? key, required this.locationOnclick})
      : super(key: key);

  @override
  State<LocationPermissionWidget> createState() =>
      _LocationPermissionWidgetState();
}

class _LocationPermissionWidgetState extends State<LocationPermissionWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Spacer(),
      SvgPicture.asset(Assets.svg.icLocationWithCircleBackground),
      space(),
          AppText(LocaleKeys.Enable_location.tr(),
              textAlign: TextAlign.center,
              style: typoW700.copyWith(fontSize: 24)),
          space(height: 30),
          AppText(
              LocaleKeys
                      .To_suggest_nearby_restaurants_we_need_to_know_your_location
                  .tr(),
              textAlign: TextAlign.center,
              style: typoW400.copyWith(fontSize: 14)),
          space(height: 30),
      AppText(LocaleKeys.Open_Settings_and_allow_location.tr(),
          textAlign: TextAlign.center,
          style: typoW400.copyWith(fontSize: 14)),
          space(height: 40),
          AppButton(
              textAlign: TextAlign.center,
              title: LocaleKeys.Reload.tr(),
          textStyle: typoW500.copyWith(fontSize: 14, color: colorWhite),
          onPress: () =>widget.locationOnclick.call(),
          width: MediaQuery.of(context).size.width,
          borderRadius: 10,
          backgroundColor: HexColor('25C769'),
          height: 50),
      const Spacer(),
      const Spacer(),
      const Spacer()
    ]));
  }

  Widget space({double? height}) => SizedBox(height: height ?? 60);
}
