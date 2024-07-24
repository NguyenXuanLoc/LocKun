import 'package:base_bloc/components/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

var typoW400 = TextStyle(
    letterSpacing: 0.1, fontWeight: FontWeight.w400);
var typoW500 = TextStyle(
    letterSpacing: 0.1, fontWeight: FontWeight.w500);
var typoW600 = TextStyle(
    letterSpacing: 0.1, fontWeight: FontWeight.w600);
var typoW700 = TextStyle(
    letterSpacing: 0.1, fontWeight: FontWeight.w700);
var typoW800 = TextStyle(
    letterSpacing: 0.1, fontWeight: FontWeight.w800);

void updateFontColor() {
  typoW400 = TextStyle(
      letterSpacing: 0.1,
     
      fontWeight: FontWeight.w400);
  typoW500 = TextStyle(
      letterSpacing: 0.1,
     
      fontWeight: FontWeight.w500);
  typoW600 = TextStyle(
      letterSpacing: 0.1,
     
      fontWeight: FontWeight.w600);
  typoW700 = TextStyle(
      letterSpacing: 0.1,
     
      fontWeight: FontWeight.w700);
  typoW800 = TextStyle(
      letterSpacing: 0.1,
     
      fontWeight: FontWeight.w800);
}

final styleTextField =
    typoSmallTextRegular.copyWith(color: colorNeutralDark100);

final styleTextFieldBold =
    typoSmallTextBold.copyWith(color: colorNeutralDark100);

final decorTextField = InputDecoration(
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorGreyBorder, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorGreyBorder, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorGreyBorder, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: colorGreyBorder, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
  contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
  hintStyle: typoNormalTextRegular.copyWith(
      color: colorNeutralDark40.withOpacity(0.4)),
  errorStyle: typoSmallTextRegular.copyWith(color: colorSemanticRed100),
  counterText: '',
  fillColor: Colors.white,
  filled: true,
);

final decorContainerBox = BoxDecoration(
  borderRadius: const BorderRadius.all(Radius.circular(10)),
  boxShadow: boxShadow,
  color: colorWhite,
);

final boxShadow = [
  BoxShadow(
    color: colorBlack.withOpacity(0.05),
    spreadRadius: 0,
    blurRadius: 10,
    offset: const Offset(0, 0),
  ),
];

final typoNormalTextBold = TextStyle(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 16,
  letterSpacing: 0.1,
  color: colorBlack,
);

final typoNormalTextRegular = TextStyle(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 16,
  letterSpacing: 0.1,
  color: colorBlack,
);

final typoNormalTextRegularNoSpacing = TextStyle(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: colorBlack,
);

final typoSmallTextBold = TextStyle(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  fontSize: 13.5,
  letterSpacing: 0.1,
  color: colorBlack,
);

final typoSmallTextRegular = TextStyle(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  fontSize: 13.5,
  letterSpacing: 0.1,
  color: colorBlack,
);
