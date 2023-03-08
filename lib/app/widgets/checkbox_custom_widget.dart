import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/global_variable.dart';

class CheckBoxCustom extends StatefulWidget {
  bool value;
  bool isWithShadow = false;
  void Function(bool) onChanged;
  double size;
  double shadowSize;
  double border;
  double borderRadius;
  double paddingLeft;
  double paddingTop;
  double paddingRight;
  double paddingBottom;
  Color disableBorderColor;
  CheckBoxCustom({
    this.value = false,
    this.isWithShadow = false,
    this.onChanged,
    this.size = 16,
    this.shadowSize = 24,
    this.border = 1,
    this.borderRadius = 5,
    this.paddingLeft = 8,
    this.paddingTop = 8,
    this.paddingRight = 8,
    this.paddingBottom = 8,
    this.disableBorderColor,
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
          padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(context) * widget.paddingLeft,
              GlobalVariable.ratioWidth(context) * widget.paddingTop,
              GlobalVariable.ratioWidth(context) * widget.paddingRight,
              GlobalVariable.ratioWidth(context) * widget.paddingBottom),
          child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              width: GlobalVariable.ratioWidth(context) * widget.size,
              height: GlobalVariable.ratioWidth(context) * widget.size,
              decoration: BoxDecoration(
                color:
                    widget.value ? Color(ListColor.color4) : Colors.transparent,
                border: Border.all(
                  width: GlobalVariable.ratioWidth(context) * widget.border,
                  color: widget.disableBorderColor == null ? Color(ListColor.color4) : widget.disableBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(
                    GlobalVariable.ratioWidth(context) * widget.borderRadius)),
                boxShadow: widget.value && widget.isWithShadow
                    ? [
                        BoxShadow(
                            color: Color(ListColor.color4),
                            spreadRadius:
                                GlobalVariable.ratioWidth(context) * 0,
                            blurRadius: GlobalVariable.ratioWidth(context) * 8,
                            offset: Offset(
                                GlobalVariable.ratioWidth(context) * 0,
                                GlobalVariable.ratioWidth(context) * 4))
                      ]
                    : null,
              ),
              child: Center(
                child: Container(
                    width: GlobalVariable.ratioWidth(context) * widget.size,
                    height: GlobalVariable.ratioWidth(context) * widget.size,
                    child: SvgPicture.asset(
                      "assets/ic_checkbox_1.svg",
                      color: widget.value ? Colors.white : Colors.transparent,
                      width: GlobalVariable.ratioWidth(context) * widget.size,
                      height: GlobalVariable.ratioWidth(context) * widget.size,
                    )
                    // Icon(
                    //   Icons.check,
                    //   color: widget.value ? Colors.white : Colors.transparent,
                    //   size: GlobalVariable.ratioWidth(context) * widget.size,
                    // ),
                    ),
              )),
        ));
  }
}

class CheckBoxCustom2 extends StatefulWidget {
  bool value;
  bool isWithShadow = false;
  void Function(bool) onChanged; //isi null untuk disable
  double size;
  double shadowSize;
  double border;
  Color borderColorNormal;
  Color borderColorActive;
  Color borderColorDisable;
  Color colorNormal;
  Color colorActive;
  Color colorDisable;
  Color colorIconNormal;
  Color colorIconActive;
  Color colorIconDisable;
  double borderRadius;
  double paddingLeft;
  double paddingTop;
  double paddingRight;
  double paddingBottom;
  CheckBoxCustom2({
    this.value = false,
    this.isWithShadow = false,
    @required this.onChanged,
    this.size = 16,
    this.shadowSize = 24,
    this.border = 1,
    this.borderColorNormal,
    this.borderColorActive,
    this.borderColorDisable,
    this.colorNormal,
    this.colorActive,
    this.colorDisable,
    this.colorIconNormal,
    this.colorIconActive,
    this.colorIconDisable,
    this.borderRadius = 4,
    this.paddingLeft = 0,
    this.paddingTop = 0,
    this.paddingRight = 0,
    this.paddingBottom = 0,
  });

  @override
  _CheckBoxCustomState2 createState() => _CheckBoxCustomState2();
}

class _CheckBoxCustomState2 extends State<CheckBoxCustom2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onChanged != null
            ? () {
                widget.value = !widget.value;
                setState(() {});
                // if (widget.onChanged != null)
                widget.onChanged(widget.value);
              }
            : null,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(context) * widget.paddingLeft,
              GlobalVariable.ratioWidth(context) * widget.paddingTop,
              GlobalVariable.ratioWidth(context) * widget.paddingRight,
              GlobalVariable.ratioWidth(context) * widget.paddingBottom),
          child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: GlobalVariable.ratioWidth(context) * widget.size,
              height: GlobalVariable.ratioWidth(context) * widget.size,
              decoration: BoxDecoration(
                color: widget.onChanged != null
                    ? widget.value
                        ? widget.colorActive ??
                            Color(ListColor.colorYellow) //aktif
                        : widget.colorNormal ??
                            Color(ListColor.colorWhite) //normal
                    : widget.colorDisable ??
                        Color(ListColor.colorStroke) //disable
                ,
                border: Border.all(
                    width: GlobalVariable.ratioWidth(context) * widget.border,
                    color: widget.onChanged != null
                        ? widget.value
                            ? widget.borderColorActive ??
                                Color(ListColor.colorYellow) //aktif
                            : widget.borderColorNormal ??
                                Color(ListColor.colorStroke) //normal
                        : widget.borderColorDisable ??
                            Color(ListColor.colorStroke) //disable
                    ),
                borderRadius: BorderRadius.all(Radius.circular(
                    GlobalVariable.ratioWidth(context) * widget.borderRadius)),
                boxShadow: widget.value && widget.isWithShadow
                    ? [
                        BoxShadow(
                            color: Color(ListColor.color4),
                            spreadRadius:
                                GlobalVariable.ratioWidth(context) * 1,
                            blurRadius: GlobalVariable.ratioWidth(context) * 5,
                            offset: Offset(
                                GlobalVariable.ratioWidth(context) * 0,
                                GlobalVariable.ratioWidth(context) * 4))
                      ]
                    : null,
              ),
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/ic_checkbox.svg",
                    width:
                        GlobalVariable.ratioWidth(context) * (widget.size - 1),
                    color: widget.onChanged != null
                        ? widget.value
                            ? widget.colorIconActive ??
                                Color(ListColor.colorBlue) //aktif
                            : widget.colorIconNormal ??
                                Colors.transparent //normal
                        : widget.colorIconDisable ??
                            Color(ListColor.colorStroke) //disable
                    ,
                  ),
                  //             Icon(
                  //   Icons.check,
                  //   color: widget.value ? Colors.white : Colors.transparent,
                  //   size: GlobalVariable.ratioWidth(context) * widget.size,
                  // ),
                ),
              )),
        ));
  }
}