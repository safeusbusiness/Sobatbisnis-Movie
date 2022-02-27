import 'package:flutter/material.dart';

class MainClickCustomWidget extends StatelessWidget {
  Function() onTap;
  Widget child;
  MainClickCustomWidget({Key? key, required this.onTap, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: child,
    );
  }
}
