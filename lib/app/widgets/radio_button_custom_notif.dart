import 'package:flutter/material.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/global_variable.dart';

class RadioButtonCustomNotif extends StatefulWidget {
  String groupValue;
  String value;
  bool isWithShadow = false;
  bool isDense = false;
  bool toggleable = false;
  double width;
  double height;
  void Function(String) onChanged;
  RadioButtonCustomNotif(
      {@required this.groupValue,
      @required this.value,
      this.isWithShadow = false,
      this.isDense = false,
      this.toggleable = false,
      this.width = 14,
      this.height = 14,
      @required this.onChanged});
  @override
  _RadioButtonCustomState createState() => _RadioButtonCustomState();
}

class _RadioButtonCustomState extends State<RadioButtonCustomNotif> {
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
          padding: EdgeInsets.all(widget.isDense ? 0 : 10),
          child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: widget.width,
              height: widget.height,
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
                            color: Color(ListColor.colorBlue).withOpacity(0.23),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 4))
                      ]
                    : null,
              ),
              child: Center(
                child: Container(
                  width: GlobalVariable.ratioWidth(context) * 10,
                  height: GlobalVariable.ratioWidth(context) * 10,
                  decoration: BoxDecoration(
                      color: isChoosen
                          ? Color(ListColor.color4)
                          : Colors.transparent,
                      shape: BoxShape.circle),
                ),
              )),
        ));
  }
}
