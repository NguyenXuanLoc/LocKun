import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Color colorBlur;
  final Widget child;

  const CardWidget({Key? key, required this.colorBlur, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(color: colorBlur, blurRadius: 32, spreadRadius: 10),
        ],
      ),
    );
  }
}
