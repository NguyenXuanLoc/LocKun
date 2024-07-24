import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../gen/assets.gen.dart';

class CongratulationWidget extends StatefulWidget {
  const CongratulationWidget({Key? key}) : super(key: key);

  @override
  State<CongratulationWidget> createState() => _CongratulationWidgetState();
}

class _CongratulationWidgetState extends State<CongratulationWidget>
    with TickerProviderStateMixin {
  var isAnimation = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => setState(() => isAnimation = !isAnimation));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: contentPadding, right: contentPadding),
      child: Stack(children: <Widget>[
        AnimatedPositioned(
            top: isAnimation ? -500 : MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 7000),
            curve: Curves.easeOut,
            child: AnimatedOpacity(
                curve: Curves.easeOut,
                opacity: isAnimation ? 1 : 0.0,
                duration: const Duration(seconds: 6),
                child: ShakeAnimatedWidget(
                    duration: const Duration(milliseconds: 600),
                    shakeAngle: Rotation.deg(z: 0.7),
                    curve: Curves.easeOut,
                    child: SvgPicture.asset(Assets.svg.icCongratulation,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width)))),
        AnimatedPositioned(
            onEnd: () {},
            top: isAnimation ? -500 : MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 6300),
            curve: Curves.easeOut,
            child: ShakeAnimatedWidget(
                duration: const Duration(milliseconds: 1000),
                shakeAngle: Rotation.deg(z: 0.7),
                curve: Curves.easeOut,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: contentPadding, right: contentPadding),
                    child: SvgPicture.asset(Assets.svg.icDefaultCongratulation,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width))))
      ]),
    );
  }
}
