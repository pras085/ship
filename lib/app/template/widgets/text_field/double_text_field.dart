import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/thousand_separator.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class DoubleTextField extends StatefulWidget {
  final String groupTitle;
  final EditTextProperty editTextProperty1;
  final EditTextProperty editTextProperty2;

  const DoubleTextField({ 
    this.groupTitle, 
    this.editTextProperty1, 
    this.editTextProperty2 
  });

  @override
  State<DoubleTextField> createState() => _DoubleTextFieldState();
}

class _DoubleTextFieldState extends State<DoubleTextField> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller1.text = widget.editTextProperty1.hintText;
    _controller2.text = widget.editTextProperty2.hintText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.groupTitle != null && widget.groupTitle.isNotEmpty) ...[
          CustomText(
            widget.groupTitle,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            height: 1.2,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 12)
        ],
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    widget.editTextProperty1.title,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.2
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
                  EditText(
                    controller: _controller1, 
                    editTextProperty: widget.editTextProperty1
                  )
                ],
              ),
            ),
            SizedBox(width: GlobalVariable.ratioWidth(context) * 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    widget.editTextProperty2.title,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.2
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
                  EditText(
                    controller: _controller2, 
                    editTextProperty: widget.editTextProperty2
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class EditTextProperty {
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final NumberType numberType;
  final Function(String) onChanged;
  
  EditTextProperty({
    @required this.title,
    this.hintText = "",
    this.keyboardType = TextInputType.text,
    this.numberType = NumberType.PRICE,
    this.onChanged
  });
}

class EditText extends StatelessWidget {
  final TextEditingController controller;
  final EditTextProperty editTextProperty;

  EditText({@required this.controller, @required this.editTextProperty});

  @override
  Widget build(BuildContext context) {
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
                hintText: editTextProperty.hintText,
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
              keyboardType: editTextProperty.keyboardType,
              inputFormatters: editTextProperty.keyboardType == TextInputType.number ? [
                if (editTextProperty.numberType == NumberType.PRICE) ThousandSeparatorFormatter(), 
                if (editTextProperty.numberType == NumberType.YEAR) LengthLimitingTextInputFormatter(4)
              ] : null,
              onChanged: editTextProperty.onChanged,
            ),
          ),
          if (controller.text.isNotEmpty) ...[
            GestureDetector(
              onTap: () {
                controller.clear();
              },
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