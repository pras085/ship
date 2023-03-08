import 'package:flutter/material.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/global_variable.dart';

class RadioButtonCustomWithText extends StatefulWidget {
  String groupValue;
  String value;
  bool isWithShadow = false;
  bool isDense = false;
  bool toggleable = false;
  bool isTextOnRightOfCheckBox = true;
  double radioSize;
  Widget customTextWidget;
  void Function(String) onChanged;
  RadioButtonCustomWithText(
      {@required this.groupValue,
      @required this.value,
      this.radioSize = 12,
      this.isWithShadow = false,
      this.isDense = false,
      this.toggleable = false,
      this.isTextOnRightOfCheckBox = true,
      @required this.customTextWidget,
      @required this.onChanged});
  @override
  _RadioButtonCustomWithTextState createState() =>
      _RadioButtonCustomWithTextState();
}

class _RadioButtonCustomWithTextState extends State<RadioButtonCustomWithText> {
  double _separatorWidth = 8.0;
  @override
  Widget build(BuildContext context) {
    bool isChoosen = widget.groupValue == widget.value;
    return GestureDetector(
        onTap: () {
          widget.groupValue =
              widget.toggleable && isChoosen ? "" : widget.value;
          setState(() {});
          if (widget.onChanged != null) widget.onChanged(widget.groupValue);
        },
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
              vertical: widget.isDense ? 0 : 10,
              horizontal: widget.isDense ? 0 : 10),
          child: Row(children: [
            widget.isTextOnRightOfCheckBox
                ? SizedBox.shrink()
                : Row(mainAxisSize: MainAxisSize.min, children: [
                    widget.customTextWidget,
                    SizedBox(
                      width: _separatorWidth,
                    ),
                  ]),
            AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: widget.radioSize,
                height: widget.radioSize + 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                      width: 1,
                      color: isChoosen
                          ? Color(ListColor.color4)
                          : Color(ListColor.colorLightGrey7)),
                  boxShadow: isChoosen && widget.isWithShadow
                      ? [
                          BoxShadow(
                              color:
                                  Color(ListColor.colorBlue).withOpacity(0.23),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 4))
                        ]
                      : null,
                ),
                child: Center(
                  child: Container(
                    width: (widget.radioSize + 2) / 2,
                    height: (widget.radioSize + 2) / 2,
                    decoration: BoxDecoration(
                        color: isChoosen
                            ? Color(ListColor.color4)
                            : Colors.transparent,
                        shape: BoxShape.circle),
                  ),
                )),
            widget.isTextOnRightOfCheckBox
                ? Row(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      width: _separatorWidth,
                    ),
                    widget.customTextWidget
                  ])
                : SizedBox.shrink()
          ]),
        ));
  }
}
