import 'package:flutter/material.dart';

class BuildCircleWidget extends StatelessWidget {
  const BuildCircleWidget(
      {Key? key, required this.child, required this.all, required this.color})
      : super(key: key);
  final Widget child;
  final double all;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }
}
