import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/thousand_separator.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

/// Widget Range merupakan widget untuk mengatur rentang nilai.
/// Untuk mengatur nilai terendah dan nilai tertinggi dapat dilakukan dengan cara memasukkan nilai pada TextField atau menggeser Slider.
class RangeBuyer extends StatefulWidget {
  /// Judul rentang nilai
  final String title;
  /// nilai awal
  final String start;
  /// nilai akhir
  final String end;
  /// Nilai terendah pada rentang nilai
  final double minValue;
  /// Nilai tertinggi pada rentang nilai
  final double maxValue;
  /// Pembagian digunakan pada saat menggeser slider, setiap berkurang/bertambah akan sebanyak berapa kali.
  /// 
  /// Contoh:
  /// Jika nilai minimal 0 dan maksimal 10000 dengan pembagian 10 maka akan berkurang/bertambah sebanyak 1000.
  final int divisions;
  // fungsi untuk melihat perubahan data
  final Function(RangeValues values) onChange;
  final NumberType numberType;
  final FontWeight fontWeight;

  RangeBuyer({
    @required this.title, 
    @required this.start, 
    @required this.end, 
    @required this.minValue, 
    @required this.maxValue, 
    @required this.divisions, 
    @required this.onChange,
    this.numberType,
    this.fontWeight = FontWeight.w600
  });

  @override
  _RangeBuyerState createState() => _RangeBuyerState();
}

class _RangeBuyerState extends State<RangeBuyer> {
  TextEditingController controllerStart = TextEditingController();
  TextEditingController controllerEnd = TextEditingController();
  double _start;
  double _end;
  RangeValues _rangeValues;
  NumberType numberType;

  @override
  void initState() {
    super.initState();
    numberType = widget.numberType ?? NumberType.PRICE;
    if (widget.start != null) controllerStart.text = widget.numberType != NumberType.YEAR ? "${Utils.delimeter(widget.start)}" : widget.start;
    if (widget.end != null) controllerEnd.text = widget.numberType != NumberType.YEAR ? "${Utils.delimeter(widget.end)}" : widget.end;
    _start = widget.start != null ? double.parse(widget.start) : widget.minValue;
    _end = widget.end != null ? double.parse(widget.end) : widget.maxValue;
    if (_end < _start) _end = _start;
    _rangeValues = RangeValues(_start, _end);
  }

  @override
    void dispose() {
      super.dispose();
      controllerStart.dispose();
      controllerEnd.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          widget.title,
          fontWeight: widget.fontWeight,
          fontSize: 14,
          height: 1.2,
        ),
        SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EditText(
              controller: controllerStart,
              hintText: widget.numberType != NumberType.YEAR ? "${Utils.delimeter(widget.minValue.toString())}" : widget.minValue.toInt().toString(),
              numberType: numberType,
              onChanged: (value) {
                _start = controllerStart.text.isEmpty ? widget.minValue : double.parse(Utils.removeNumberFormat(controllerStart.text));
                _end = controllerEnd.text.isEmpty ? widget.maxValue : double.parse(Utils.removeNumberFormat(controllerEnd.text));
                if (_start < widget.minValue) _start = widget.minValue;
                if (_start > _end) {
                  _start = _end;
                  // Kenapa pakai remove number? Karena ada yang menggunakan thousand separator. Pengecekan hanya untuk nilai aslinya saja tanpa disertai titik.
                  if (Utils.removeNumberFormat(controllerStart.text).length <= Utils.removeNumberFormat(controllerEnd.text).length) {
                    controllerStart.text = numberType == NumberType.YEAR ? _start.toInt().toString() : Utils.delimeter(_start.toString());
                    controllerStart.selection = TextSelection.fromPosition(TextPosition(offset: controllerStart.text.length));
                  }
                }
                if (_start < widget.minValue || _start > widget.maxValue) {
                  _start = widget.minValue;
                  controllerStart.text = numberType == NumberType.YEAR ? _start.toInt().toString() : Utils.delimeter(_start.toString());
                  controllerStart.selection = TextSelection.fromPosition(TextPosition(offset: controllerStart.text.length));
                }
                if (_end < widget.minValue || _end > widget.maxValue) {
                  _end = widget.maxValue;
                  controllerEnd.text = numberType == NumberType.YEAR ? _end.toInt().toString() : Utils.delimeter(_end.toString());
                  controllerStart.selection = TextSelection.fromPosition(TextPosition(offset: controllerStart.text.length));
                }
                _rangeValues = RangeValues(_start, _end);
                widget.onChange(_rangeValues);
                setState(() {});
              },
              onClear: () {
                controllerStart.clear();
                _rangeValues = RangeValues(widget.minValue, _end);
                widget.onChange(_rangeValues);
                setState(() {});
              },
            ),
            Container(
              width: GlobalVariable.ratioWidth(context) * 44,
              alignment: Alignment.center,
              child: CustomText(
                's/d',
                fontSize: 12,
                textAlign: TextAlign.center,
                color: Color(ListColor.colorGreyTemplate3),
              ),
            ),
            EditText(
              controller: controllerEnd,
              hintText: widget.numberType != NumberType.YEAR ? "${Utils.delimeter(widget.maxValue.toString())}" : widget.maxValue.toInt().toString(),
              numberType: numberType,
              onChanged: (value) {
                _start = controllerStart.text.isEmpty ? widget.minValue : double.parse(Utils.removeNumberFormat(controllerStart.text));
                _end = controllerEnd.text.isEmpty ? widget.maxValue : double.parse(Utils.removeNumberFormat(controllerEnd.text));
                if (_end > widget.maxValue) _end = widget.maxValue;
                if (_end < _start) {
                  _end = _start;
                  // Kenapa pakai remove number? Karena ada yang menggunakan thousand separator. Pengecekan hanya untuk nilai aslinya saja tanpa disertai titik.
                  if (Utils.removeNumberFormat(controllerEnd.text).length >= Utils.removeNumberFormat(controllerStart.text).length) {
                    controllerEnd.text = numberType == NumberType.YEAR ? _end.toInt().toString() : Utils.delimeter(_end.toString());
                    controllerEnd.selection = TextSelection.fromPosition(TextPosition(offset: controllerEnd.text.length));
                  }
                }
                if (_end < widget.minValue || _end > widget.maxValue) {
                  _end = widget.maxValue;
                  controllerEnd.text = numberType == NumberType.YEAR ? _end.toInt().toString() : Utils.delimeter(_end.toString());
                  controllerEnd.selection = TextSelection.fromPosition(TextPosition(offset: controllerEnd.text.length));
                }
                if (_start < widget.minValue || _start > widget.maxValue) {
                  _start = widget.minValue;
                  controllerStart.text = numberType == NumberType.YEAR ? _start.toInt().toString() : Utils.delimeter(_start.toString());
                  controllerEnd.selection = TextSelection.fromPosition(TextPosition(offset: controllerEnd.text.length));
                }
                _rangeValues = RangeValues(_start, _end);
                widget.onChange(_rangeValues);
                setState(() {});
              },
              onClear: () {
                controllerEnd.clear();
                _rangeValues = RangeValues(_start, widget.maxValue);
                widget.onChange(_rangeValues);
                setState(() {});
              },
            )
          ],
        ),
        SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
        Container(
          // padding: EdgeInsets.only(
          //   left: _rangeValues.start == widget.minValue ? GlobalVariable.ratioWidth(context) * 8 : 0,
          //   right: _rangeValues.end == widget.maxValue ? GlobalVariable.ratioWidth(context) * 8 : 0
          // ),
          padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(context) * 8),
          height: GlobalVariable.ratioWidth(context) * 16,
          child: Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(ListColor.colorGreyTemplate3),
                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 2)
                  ),
                  height: GlobalVariable.ratioWidth(context) * 2,
                  width: double.infinity,
                ),
              ),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: GlobalVariable.ratioWidth(context) * 1,
                  activeTrackColor: Color(ListColor.colorBlueTemplate1),
                  inactiveTrackColor: Color(ListColor.colorGreyTemplate3),
                  thumbColor: Color(ListColor.colorWhite),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: GlobalVariable.ratioWidth(context) * 16.0),
                  overlayShape: SliderComponentShape.noOverlay,
                  activeTickMarkColor: Colors.transparent
                ),
                child: RangeSlider(
                  min: widget.minValue,
                  max: widget.maxValue,
                  divisions: widget.divisions,
                  values: _rangeValues,
                  onChanged: (values) {
                    _rangeValues = RangeValues(double.parse("${values.start.round()}"), double.parse("${values.end.round()}"));
                    controllerStart.text = widget.numberType != NumberType.YEAR ? Utils.delimeter(values.start.round().toString()) : values.start.round().toString();
                    controllerEnd.text = widget.numberType != NumberType.YEAR ? Utils.delimeter(values.end.round().toString()) : values.end.round().toString();
                    widget.onChange(_rangeValues);
                    setState(() {});
                  }
                )
              ),
            ],
          ),
        ),
      ]
    );
  }
}

class EditText extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function() onClear;
  final String hintText;
  final NumberType numberType;

  EditText({@required this.controller, this.onChanged, this.onClear, @required this.hintText, this.numberType});

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> textInputFormatter = [];

    if (numberType == NumberType.PRICE) {
      textInputFormatter.add(ThousandSeparatorFormatter());
    } else if (numberType == NumberType.YEAR) {
      textInputFormatter.add(LengthLimitingTextInputFormatter(4));
    }

    return Container(
      width: GlobalVariable.ratioWidth(context) * 142,
      height: GlobalVariable.ratioWidth(context) * 32,
      padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(ListColor.colorGreyTemplate5),
          width: GlobalVariable.ratioWidth(context) * 1
        ),
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              context: context,
              textInputAction: TextInputAction.done,
              controller: controller,
              style: TextStyle(
                fontSize: GlobalVariable.ratioWidth(context) * 12,
                fontWeight: FontWeight.w600,
                color: Colors.black
              ),
              cursorColor: Colors.black,
              newInputDecoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: GlobalVariable.ratioWidth(context) * 12,
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorGreyTemplate3)
                ),
                fillColor: Colors.transparent,
                filled: true,
                isDense: true,
                isCollapsed: true,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(context) * 2,
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: textInputFormatter,
              onChanged: onChanged,
            ),
          ),
          if (controller.text.isNotEmpty) ...[
            GestureDetector(
              onTap: onClear,
              child: SvgPicture.asset(
                GlobalVariable.urlImageTemplateBuyer + "ic_close_grey.svg",
                width: GlobalVariable.ratioWidth(context) * 20,
                height: GlobalVariable.ratioWidth(context) * 20,
              ),
            ),
          ]
        ],
      )
    );
  }
}