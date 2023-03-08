import 'package:flutter/material.dart';
import 'package:muatmuat/app/style/list_colors.dart';

class ContainerShadowWidget extends StatelessWidget {

  final double height;
  final Widget child;

  ContainerShadowWidget({this.height, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.shadowColor4),
            blurRadius: 2,
            offset: Offset(0, height / 5),
          ),
        ],
      ),
      child: child,
    );
  }
}