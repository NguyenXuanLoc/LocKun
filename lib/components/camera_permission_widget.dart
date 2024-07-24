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
import '../utils/log_utils.dart';
import 'app_button.dart';
import 'app_scalford.dart';
import 'app_text.dart';

class CameraPermissionWidget extends StatefulWidget {
  final Function(bool) cameraPermissionCallback;
  final VoidCallback permissionOnclickWidget;

  const CameraPermissionWidget(
      {Key? key,
      required this.permissionOnclickWidget,
      required this.cameraPermissionCallback})
      : super(key: key);

  @override
  State<CameraPermissionWidget> createState() => _CameraPermissionWidgetState();
}

class _CameraPermissionWidgetState extends State<CameraPermissionWidget>
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
        isResume: true,
        onFocusGained: () async {
          var isCamera =
              await PermissionUtils.isRequestPermission(Permission.camera);
          widget.cameraPermissionCallback.call(isCamera);
        },
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Spacer(),
      SvgPicture.asset(Assets.svg.icCameraWithCircleBackground),
      space(),
      AppText(LocaleKeys.Turn_on_the_camera.tr(),
          style: typoW700.copyWith(fontSize: 24)),
      space(height: 30),
      AppText(LocaleKeys.To_scan_the_QR_code_we_need_access_to.tr(),
          textAlign: TextAlign.center, style: typoW400.copyWith(fontSize: 14)),
      space(height: 30),
      AppText(LocaleKeys.Open_Settings_and_allow_camera.tr(),
          style: typoW400.copyWith(fontSize: 14)),
      space(height: 40),
      AppButton(
          title: LocaleKeys.Reload.tr(),
          textStyle: typoW500.copyWith(fontSize: 14, color: colorWhite),
          onPress: () => widget.permissionOnclickWidget.call(),
          width: MediaQuery.of(context).size.width,
          borderRadius: 10,
          backgroundColor: HexColor('25C769'),
          height: 47),
      const Spacer(),
      const Spacer(),
      const Spacer()
    ]));
  }

  Widget space({double? height}) => SizedBox(height: height ?? 60);
}
