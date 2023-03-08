import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ContainerShadowWidget extends StatelessWidget {
  final double height;
  final Widget child;

  ContainerShadowWidget({this.height, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 40),
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
