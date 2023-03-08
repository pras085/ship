import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class CheckBoxCustom extends StatefulWidget {
  bool value;
  bool isWithShadow = false;
  void Function(bool) onChanged;
  double size;
  double paddingSize;
  double shadowSize;
  int borderColor;
  double borderWidth;
  CheckBoxCustom({
    this.value = false,
    this.isWithShadow = false,
    this.onChanged,
    this.size = 20,
    this.paddingSize = 10,
    this.shadowSize = 24,
    this.borderColor = -1,
    this.borderWidth = 2,
  });

  @override
  _CheckBoxCustomState createState() => _CheckBoxCustomState();
}

class _CheckBoxCustomState extends State<CheckBoxCustom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.value = !widget.value;
          setState(() {});
          if (widget.onChanged != null) widget.onChanged(widget.value);
        },
        child: Container(
          padding: EdgeInsets.only(
            left: GlobalVariable.ratioWidth(Get.context) * widget.paddingSize,
            right: GlobalVariable.ratioWidth(Get.context) * widget.paddingSize,
          ),
          child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: widget.shadowSize,
              height: widget.shadowSize,
              decoration: BoxDecoration(
                color:
                    widget.value ? Color(ListColor.color4) : Colors.transparent,
                border: Border.all(
                    width: widget.borderWidth,
                    color: widget.value
                        ? Color(ListColor.color4)
                        : Color(widget.borderColor > 0
                            ? widget.borderColor
                            : ListColor.colorLightGrey11)),
                borderRadius: BorderRadius.all(Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 5)),
                boxShadow: widget.value && widget.isWithShadow
                    ? [
                        BoxShadow(
                            color: Color(ListColor.color4),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 4))
                      ]
                    : null,
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: widget.value ? Colors.white : Colors.transparent,
                  size: widget.size,
                ),
              )),
        ));
  }
}
