import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/onchange_textfield_number_ark.dart';
import 'package:muatmuat/app/core/function/onchange_textfield_phone_number.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class TextFormFieldWidget extends StatefulWidget {
  Function validator;
  Function onSaved;
  void Function(String) onChanged;
  bool isPassword;
  bool isEmail;
  bool isPhoneNumber;
  bool isCollapse;
  bool isShowCodePhoneNumber;
  bool isNumber;
  bool isName;
  bool isSetTitleToHint = false;
  bool isEnable;
  bool isNextEditText;
  bool isShort;
  bool isShowPassword;
  bool isMultiLine;
  bool isShowError;
  bool isCustomTitle;
  bool isReadOnly;
  bool isShowCursor;
  TextEditingController textEditingController;
  double width;
  double marginBottom;
  String title;
  Color titleColor;
  Color errorColor;
  Color focusedBorderColor;
  Color borderColor;
  Color fillColor;
  Color enableBorderColor;
  Color disableBorderColor;
  ValueChanged<bool> onClickShowButton;
  TextEditingController _textEditingControllerIDPhoneNumber =
      TextEditingController(text: "+62");
  TextStyle hintTextStyle;
  TextStyle titleTextStyle;
  TextStyle contentTextStyle;
  String hintText;
  Widget titleWidget;
  int maxLength;
  Widget prefixIcon;
  Widget suffixIcon;
  String initialValue;
  TextAlign textAlign;
  bool isDecimal;
  double customContentPaddingHorizontal;
  double customContentPaddingVertical;
  bool isDense;
  bool isSelectAllWhenOnClick;
  double textSize;
  BoxConstraints prefixIconConstraints;

  TextFormFieldWidget(
      {this.onChanged,
      this.validator,
      this.isPassword = false,
      this.isEmail = false,
      this.isPhoneNumber = false,
      this.isShowCodePhoneNumber = true,
      this.textEditingController,
      this.isCollapse = false,
      this.width,
      this.title = "",
      this.isEnable = true,
      this.isNextEditText = true,
      this.isShort = false,
      this.isName = false,
      this.titleColor = Colors.white,
      this.borderColor,
      this.errorColor = Colors.white,
      this.enableBorderColor,
      this.disableBorderColor,
      this.onClickShowButton,
      this.isShowPassword = false,
      this.isSetTitleToHint = false,
      this.isSelectAllWhenOnClick = false,
      this.marginBottom = 10,
      this.focusedBorderColor,
      this.fillColor = Colors.white,
      this.hintTextStyle,
      this.hintText = "",
      this.titleTextStyle,
      this.contentTextStyle,
      this.isMultiLine = false,
      this.isShowError = true,
      this.isNumber = false,
      this.isCustomTitle = false,
      this.isReadOnly = false,
      this.isShowCursor,
      this.titleWidget,
      this.maxLength,
      this.prefixIcon,
      this.suffixIcon,
      this.initialValue,
      this.textAlign = TextAlign.left,
      this.isDecimal = false,
      this.isDense = false,
      this.customContentPaddingHorizontal = 16,
      this.customContentPaddingVertical = 13,
      this.textSize = 14,
      this.prefixIconConstraints});
  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: EdgeInsets.only(bottom: widget.marginBottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (!widget.isSetTitleToHint
              ? Container(
                  margin: EdgeInsets.only(top: 0, bottom: 5),
                  padding: widget.titleWidget != null
                      ? EdgeInsets.only(top: FontTopPadding.getSize(12))
                      : null,
                  child: widget.isCustomTitle && widget.titleWidget != null
                      ? widget.titleWidget
                      : CustomText(widget.title,
                          color: widget.titleTextStyle == null
                              ? widget.titleColor
                              : widget.titleTextStyle.color,
                          fontSize: widget.titleTextStyle == null
                              ? 18
                              : widget.titleTextStyle.fontSize,
                          fontWeight: widget.titleTextStyle == null
                              ? FontWeight.w600
                              : widget.titleTextStyle.fontWeight))
              : Container()),
          Container(
              margin: EdgeInsets.only(
                  right: widget.isShort ? 100 : 0), //widget.isShort ? 100 : 0
              child: _textFormField()),
        ],
      ),
    );
  }

  Widget _textFormFieldWidget(
      {bool isNextEditText = true,
      bool isEnable = true,
      TextEditingController textEditingController,
      Color errorColor = Colors.white,
      bool isPassword,
      bool isShowPassword,
      Function validator,
      bool isPhoneNumber,
      bool isEmail,
      bool isName = false,
      bool isReadOnly = false,
      bool isShowCursor,
      bool isSelectAllWhenOnClick = false,
      int maxLength,
      EdgeInsets contentPadding}) {
    return CustomTextFormField(
        context: Get.context,
        textSize: widget.textSize,
        newContentPadding: EdgeInsets.all(12),
        // newContentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        onTap: isSelectAllWhenOnClick && textEditingController != null
            ? () {
                textEditingController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: textEditingController.value.text.length);
              }
            : null,
        readOnly: isReadOnly,
        showCursor: isShowCursor,
        inputFormatters: maxLength == null
            ? null
            : [LengthLimitingTextInputFormatter(maxLength)],
        initialValue: widget.initialValue,
        textInputAction:
            isNextEditText ? TextInputAction.next : TextInputAction.done,
        enabled: isEnable,
        controller: textEditingController,
        style: widget.contentTextStyle,
        textAlign: widget.textAlign,
        newInputDecoration: InputDecoration(
            isCollapsed: widget.isCollapse,
            isDense: widget.isDense,
            hintText: widget.isSetTitleToHint ? widget.title : widget.hintText,
            hintStyle: widget.hintTextStyle,
            fillColor: widget.fillColor,
            errorStyle: TextStyle(
                height: widget.isShowError ? null : 0,
                color: errorColor,
                fontSize: widget.isShowError ? 14 : 0),
            errorMaxLines: 2,
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.customContentPaddingVertical,
                horizontal: widget.customContentPaddingHorizontal),
            filled: true,
            // disabledBorder: widget.disableBorderColor != null
            //     ? OutlineInputBorder(
            //         borderSide: BorderSide(
            //             color: widget.disableBorderColor, width: 1.0),
            //         borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
            //       )
            //     : null,
            // enabledBorder: widget.enableBorderColor != null
            //     ? OutlineInputBorder(
            //         borderSide:
            //             BorderSide(color: widget.enableBorderColor, width: 1.0),
            //         borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
            //       )
            //     : null,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.borderColor == null
                      ? Color(ListColor.color4)
                      : widget.borderColor,
                  width: 1.0),
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.focusedBorderColor == null
                      ? Color(ListColor.colorYellow)
                      : widget.focusedBorderColor,
                  width: 2.0),
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6),
            ),
            errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color(ListColor.colorRed), width: 2.0),
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: widget.prefixIcon != null ? widget.prefixIcon : null,
            prefixIconConstraints: widget.prefixIconConstraints != null
                ? widget.prefixIconConstraints
                : null,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      if (widget.onClickShowButton != null)
                        widget.onClickShowButton(!widget.isShowPassword);
                    },
                    child: widget.isShowPassword
                        ? Icon(Icons.visibility, color: Color(ListColor.color4))
                        : Icon(Icons.visibility_off,
                            color: Color(ListColor.colorGrey)),
                  )
                : widget.suffixIcon),
        obscureText: isPassword && !isShowPassword,
        validator: validator,
        onChanged: (value) {
          if (isPhoneNumber) {
            OnChangeTextFieldPhoneNumber.checkPhoneNumber(
                () => textEditingController, value);
          } else if (widget.isNumber) {
            if (widget.isDecimal) {
              OnChangeTextFieldNumber.checkDecimal(
                  () => textEditingController, value);
            } else {
              OnChangeTextFieldNumber.checkNumber(
                  () => textEditingController, value);
            }
          }
          if (widget.onChanged != null) {
            widget.onChanged(value);
          }
        },
        maxLines: widget.isMultiLine ? 6 : 1,
        keyboardType: widget.isMultiLine
            ? TextInputType.multiline
            : isPhoneNumber
                ? TextInputType.phone
                : widget.isNumber
                    ? TextInputType.numberWithOptions(decimal: widget.isDecimal)
                    : (isEmail
                        ? TextInputType.emailAddress
                        : isName
                            ? TextInputType.name
                            : TextInputType.text));
  }

  Widget _textFormFieldDefault() {
    return _textFormFieldWidget(
        isEnable: widget.isEnable,
        isNextEditText: widget.isNextEditText,
        textEditingController: widget.textEditingController,
        errorColor: widget.errorColor,
        isPassword: widget.isPassword,
        isShowPassword: widget.isShowPassword,
        validator: widget.validator,
        isPhoneNumber: widget.isPhoneNumber,
        isEmail: widget.isEmail,
        isName: widget.isName,
        isReadOnly: widget.isReadOnly,
        isShowCursor: widget.isShowCursor,
        maxLength: widget.maxLength,
        isSelectAllWhenOnClick: widget.isSelectAllWhenOnClick);
  }

  Widget _textFormField() {
    return widget.isPhoneNumber && widget.isShowCodePhoneNumber
        ? Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 70,
                child: _textFormFieldWidget(
                    textEditingController:
                        widget._textEditingControllerIDPhoneNumber,
                    isEnable: false,
                    isPassword: false,
                    validator: (String value) {
                      return null;
                    },
                    isPhoneNumber: false,
                    isEmail: false,
                    isName: true),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(child: _textFormFieldDefault()),
            ],
          )
        : _textFormFieldDefault();
  }
}
