import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base/hex_color.dart';
import '../theme/colors.dart';

class AppCircleLoading extends StatelessWidget {
  const AppCircleLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        color: HexColor('25C869').withOpacity(0.9),
        strokeWidth: 2.0,
      ),
    );
  }
}
