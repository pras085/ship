import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class TextFieldRegisNama extends StatelessWidget {
  final TextEditingController tec;
  final String hint;
  final bool isValid;
  final Function(String) onChanged;
  
  TextFieldRegisNama({
    this.tec,
    this.hint,
    this.isValid,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 0,
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 14,
      ),
      height: GlobalVariable.ratioWidth(context) * 40,
      // TARUH BORDER TEXTFIELD DISINI
      decoration: BoxDecoration(
          border: Border.all(
              width: GlobalVariable.ratioWidth(context) * 1,
              color: isValid
                  ? Color(ListColor.colorLightGrey10)
                  : Color(ListColor.colorRed)),
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(context) * 6)),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextFormField(
                context: context,
                autofocus: false,
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(255)
                ],
                onChanged: (value) {
                  onChanged(value);
                },
                controller: tec,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: 1.2,
                ),
                textSize: 14,
                newInputDecoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(ListColor.colorLightGrey2)),
                  fillColor: Colors.transparent,
                  filled: true,
                  isDense: true,
                  isCollapsed: true,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(context) * 46,
                    GlobalVariable.ratioWidth(context) * 11.5,
                    GlobalVariable.ratioWidth(context) * 48,
                    GlobalVariable.ratioWidth(context) * 0,
                  ),
                ),
              ),
            ],
          ),
          // TARUH ICON DISINI
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(context) * 12),
            child: SvgPicture.asset(
              "assets/ic_username_seller.svg",
              width: GlobalVariable.ratioWidth(context) * 24,
              height: GlobalVariable.ratioWidth(context) * 24,
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldRegisNamaBlack extends StatelessWidget {
  final TextEditingController tec;
  final String hint;
  final bool isValid;
  final Function(String) onChanged;

  TextFieldRegisNamaBlack({
    this.tec,
    this.hint,
    this.isValid,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(context) * 16,
          GlobalVariable.ratioWidth(context) * 0,
          GlobalVariable.ratioWidth(context) * 16,
          GlobalVariable.ratioWidth(context) * 14),
      height: GlobalVariable.ratioWidth(context) * 40,
      // TARUH BORDER TEXTFIELD DISINI
      decoration: BoxDecoration(
        border: Border.all(
          width: GlobalVariable.ratioWidth(context) * 1,
          color: isValid
              ? Color(ListColor.colorLightGrey10)
              : Color(ListColor.colorRed),
        ),
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(context) * 6),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextFormField(
                maxLength: 14,
                isShowCounter: false,
                context: context,
                autofocus: false,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(14)
                ],
                onChanged: (value) {
                 onChanged(value);
                },
                controller: tec,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: 1.2,
                ),
                textSize: 14,
                newInputDecoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(ListColor.colorLightGrey2)),
                  fillColor: Colors.transparent,
                  filled: true,
                  isDense: true,
                  isCollapsed: true,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(context) * 46,
                    GlobalVariable.ratioWidth(context) * 11.5,
                    GlobalVariable.ratioWidth(context) * 48,
                    GlobalVariable.ratioWidth(context) * 0,
                  ),
                ),
              ),
            ],
          ),
          // TARUH ICON DISINI
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(context) * 12),
            child: SvgPicture.asset(
              "assets/ic_whatsapp_seller.svg",
              width: GlobalVariable.ratioWidth(context) * 24,
              height: GlobalVariable.ratioWidth(context) * 24,
            ),
          ),
        ],
      ),
    );
  }
}


class TextFieldRegisWa extends StatelessWidget {
  final TextEditingController tec;
  final String hint;
  final bool isValid;
  final Function(String) onChanged;
  
  TextFieldRegisWa({
    this.tec,
    this.hint,
    this.isValid,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(context) * 16,
          GlobalVariable.ratioWidth(context) * 0,
          GlobalVariable.ratioWidth(context) * 16,
          GlobalVariable.ratioWidth(context) * 14),
      height: GlobalVariable.ratioWidth(context) * 40,
      // TARUH BORDER TEXTFIELD DISINI
      decoration: BoxDecoration(
        border: Border.all(
          width: GlobalVariable.ratioWidth(context) * 1,
          color: isValid
              ? Color(ListColor.colorLightGrey10)
              : Color(ListColor.colorRed),
        ),
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(context) * 6),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextFormField(
                maxLength: 14,
                isShowCounter: false,
                context: context,
                autofocus: false,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(14)
                ],
                onChanged: (value) {
                 onChanged(value);
                },
                controller: tec,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: 1.2,
                ),
                textSize: 14,
                newInputDecoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(ListColor.colorLightGrey2)),
                  fillColor: Colors.transparent,
                  filled: true,
                  isDense: true,
                  isCollapsed: true,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(context) * 46,
                    GlobalVariable.ratioWidth(context) * 11.5,
                    GlobalVariable.ratioWidth(context) * 48,
                    GlobalVariable.ratioWidth(context) * 0,
                  ),
                ),
              ),
            ],
          ),
          // TARUH ICON DISINI
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(context) * 12),
            child: SvgPicture.asset(
              "assets/ic_whatsapp_seller.svg",
              width: GlobalVariable.ratioWidth(context) * 24,
              height: GlobalVariable.ratioWidth(context) * 24,
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldRegisWaBlack extends StatelessWidget {
  final TextEditingController tec;
  final String hint;
  final bool isValid;
  final Function(String) onChanged;

  TextFieldRegisWaBlack({
    this.tec,
    this.hint,
    this.isValid,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(context) * 16,
          GlobalVariable.ratioWidth(context) * 0,
          GlobalVariable.ratioWidth(context) * 16,
          GlobalVariable.ratioWidth(context) * 14),
      height: GlobalVariable.ratioWidth(context) * 40,
      // TARUH BORDER TEXTFIELD DISINI
      decoration: BoxDecoration(
        border: Border.all(
          width: GlobalVariable.ratioWidth(context) * 1,
          color: isValid
              ? Color(ListColor.colorLightGrey10)
              : Color(ListColor.colorRed),
        ),
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(context) * 6),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextFormField(
                maxLength: 14,
                isShowCounter: false,
                context: context,
                autofocus: false,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(14)
                ],
                onChanged: (value) {
                 onChanged(value);
                },
                controller: tec,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: 1.2,
                ),
                textSize: 14,
                newInputDecoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(ListColor.colorLightGrey2)),
                  fillColor: Colors.transparent,
                  filled: true,
                  isDense: true,
                  isCollapsed: true,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(context) * 46,
                    GlobalVariable.ratioWidth(context) * 11.5,
                    GlobalVariable.ratioWidth(context) * 48,
                    GlobalVariable.ratioWidth(context) * 0,
                  ),
                ),
              ),
            ],
          ),
          // TARUH ICON DISINI
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(context) * 12),
            child: SvgPicture.asset(
              "assets/ic_whatsapp_seller.svg",
              width: GlobalVariable.ratioWidth(context) * 24,
              height: GlobalVariable.ratioWidth(context) * 24,
            ),
          ),
        ],
      ),
    );
  }
}

