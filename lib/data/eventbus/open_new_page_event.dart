import 'package:flutter/cupertino.dart';

class OpenNewPageEvent {
  final Widget newPage;
  final bool isReplace;

  OpenNewPageEvent(this.newPage, {this.isReplace = false});
}
