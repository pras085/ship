import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import '../../../../global_variable.dart';

class PageCheckboxBuyer extends StatefulWidget {

  final String title;
  final List listCheckbox;
  final List listAliasCheckbox;
  final List selectedListCheckbox;

  const PageCheckboxBuyer({
    @required this.title,
    @required this.listCheckbox,
    this.listAliasCheckbox,
    @required this.selectedListCheckbox,
  });

  @override
  _PageCheckboxBuyerState createState() => _PageCheckboxBuyerState();
}

class _PageCheckboxBuyerState extends State<PageCheckboxBuyer> {

  List selectedList = [];

  @override
  void initState() {
    super.initState();
    selectedList = [...widget.selectedListCheckbox];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetail(
        title: widget.title,
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: GlobalVariable.ratioWidth(context) * 20,
          horizontal: GlobalVariable.ratioWidth(context) * 16,
        ),
        itemCount: widget.listCheckbox.length,
        separatorBuilder: (_, __) {
          return Container(
            margin: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(context) * 4,
            ),
            width: double.infinity,
            height: GlobalVariable.ratioWidth(context) * 0.5,
            color: Color(ListColor.colorGreyTemplate6),
          );
        },
        itemBuilder: (ctx, i) {
          return InkWell(
            onTap: () {
              if (!selectedList.contains(widget.listCheckbox[i])) {
                selectedList.add(widget.listCheckbox[i]);
              } else {
                selectedList.remove(widget.listCheckbox[i]);
              }
              setState(() {});
            },
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    "${widget.listAliasCheckbox != null ? widget.listAliasCheckbox[i] : widget.listCheckbox[i]}",
                    fontSize: 14,
                    color: Color(ListColor.colorGreyTemplate3),
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(context) * 12,
                ),
                IgnorePointer(
                  ignoring: true,
                  child: CheckBoxCustom(
                    border: 1,
                    size: 20,
                    isWithShadow: true,
                    onChanged: null,
                    value: selectedList.contains(widget.listCheckbox[i]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
            topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, GlobalVariable.ratioWidth(context) * -3),
              blurRadius: GlobalVariable.ratioWidth(context) * 55,
              color: Colors.black.withOpacity(0.16),
            ),
          ],
        ),
        height: GlobalVariable.ratioWidth(context) * 56,
        padding: EdgeInsets.symmetric(
          vertical: GlobalVariable.ratioWidth(context) * 12,
          horizontal: GlobalVariable.ratioWidth(context) * 16,
        ),
        child: Row(
          children: [
            _button(
              onTap: () {
                Get.back(
                  result: <String>[],
                );
              },
              width: 160,
              height: 32,
              text: "Reset",
              color: Color(ListColor.colorBlueTemplate1),
              backgroundColor: Colors.white,
              borderSize: 1.5,
              borderColor: Color(ListColor.colorBlueTemplate1),
              borderRadius: 26,
              useBorder: true,
            ),
            SizedBox(
              width: GlobalVariable.ratioWidth(context) * 8,
            ),
            _button(
              onTap: () {
                Get.back(
                  result: selectedList,
                );
              },
              width: 160,
              height: 32,
              text: "Terapkan",
              color: Colors.white,
              backgroundColor: Color(ListColor.colorBlueTemplate1),
              borderRadius: 26,
            ),
          ],
        ),
      ),
    );
  }

  // PRIVATE CUSTOM BUTTON 
  Widget _button({
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * marginLeft,
        GlobalVariable.ratioWidth(Get.context) * marginTop,
        GlobalVariable.ratioWidth(Get.context) * marginRight,
        GlobalVariable.ratioWidth(Get.context) * marginBottom
      ),
      width: width == null ? maxWidth ? MediaQuery.of(Get.context).size.width : null : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null ? null : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: useShadow
          ? <BoxShadow>[
              BoxShadow(
                color: Color(ListColor.shadowColor).withOpacity(0.08),
                blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                spreadRadius: 0,
                offset:
                    Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
              ),
            ]
          : null,
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        border: useBorder
          ? Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * borderSize,
              color: borderColor ?? Color(ListColor.colorBlue),
            )
          : null
      ),
      child: Material(
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
          ),
          onTap: () {
            onTap();
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * paddingLeft,
              GlobalVariable.ratioWidth(Get.context) * paddingTop,
              GlobalVariable.ratioWidth(Get.context) * paddingRight,
              GlobalVariable.ratioWidth(Get.context) * paddingBottom
            ),
            width: maxWidth ? double.infinity : null,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius)
            ),
            child: customWidget == null
              ? CustomText(
                  text ?? "",
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                )
              : customWidget,
          )
        ),
      ),
    );
  }

}