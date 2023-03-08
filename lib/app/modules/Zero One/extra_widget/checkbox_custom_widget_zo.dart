import 'package:flutter/material.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';

class CheckBoxCustom extends StatefulWidget {
  bool value;
  bool isWithShadow = false;
  void Function(bool) onChanged;
  double size;
  double shadowSize;
  double border;
  Color borderColor;
  Color colorBG;
  double paddingT;
  double paddingL;
  double paddingB;
  double paddingR;
  CheckBoxCustom(
      {this.value = false,
      this.isWithShadow = false,
      this.onChanged,
      this.size = 20,
      this.paddingT = 10,
      this.paddingL = 10,
      this.paddingB = 10,
      this.paddingR = 10,
      @required this.borderColor,
      this.colorBG = Colors.transparent,
      this.shadowSize = 24,
      this.border = 2});

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
          padding: EdgeInsets.fromLTRB(widget.paddingL, widget.paddingT,
              widget.paddingR, widget.paddingB),
          child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: widget.shadowSize,
              height: widget.shadowSize,
              decoration: BoxDecoration(
                color: widget.value ? Color(ListColor.color4) : widget.colorBG,
                border: Border.all(
                    width: widget.border,
                    color: widget.value
                        ? Color(ListColor.color4)
                        : widget.borderColor),
                borderRadius: BorderRadius.all(Radius.circular(5)),
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
