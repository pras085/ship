import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:muatmuat/app/widgets/back_button.dart';

class AppBarCustom2 extends PreferredSize {
  TextEditingController searchInput;
  String hintText;
  List<Widget> listOption;
  Function(String) onSearch;
  Function(String) onChange;
  Function() onSelect;
  Function() onClear;
  bool isEnableSearchTextField;
  bool showClear;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: preferredSize.height,
      child: Container(
          height: preferredSize.height,
          color: Color(ListColor.color4),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
              top: 5,
              right: 0,
              child: Image(
                image: AssetImage("assets/fallin_star_3_icon.png"),
                height: preferredSize.height,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomBackButton(
                      context: Get.context,
                      onTap: () {
                        Get.back();
                      }),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) * 8,
                              top: GlobalVariable.ratioWidth(Get.context) * 12,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 8))),
                          child: Center(
                            child: onSelect != null && !isEnableSearchTextField
                                ? GestureDetector(
                                    onTap: onSelect, child: _searchTextField)
                                : _searchTextField,
                          ))),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: listOption,
                  )
                ],
              ),
            )
          ])),
    ));
  }

  Widget get _searchTextField => Stack(
        alignment: Alignment.centerLeft,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextField(
                context: Get.context,
                enabled: isEnableSearchTextField,
                controller: searchInput,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                textInputAction: TextInputAction.go,
                style: TextStyle(
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "AvenirNext",
                    color: Colors.black),
                newInputDecoration: InputDecoration(
                    fillColor: Colors.transparent,
                    hintStyle: TextStyle(
                        height: 1.2,
                        fontSize: GlobalVariable.ratioWidth(Get.context) * 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorLightGrey2)),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    // prefixIcon: Icon(
                    //   Icons.search,
                    //   color: Colors.grey,
                    // ),
                    hintText: hintText,
                    filled: true,
                    isDense: true,
                    isCollapsed: true,
                    contentPadding: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioWidth(Get.context) * 36,
                        GlobalVariable.ratioWidth(Get.context) * 9,
                        GlobalVariable.ratioWidth(Get.context) * 32,
                        GlobalVariable.ratioWidth(Get.context) * 0)),
                onSubmitted: (String str) async {
                  await onSearch(str);
                },
                onChanged: (String str) async {
                  await onChange(str);
                },
                onTap: () async {
                  if (onSelect != null) await onSelect();
                },
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 6),
            child: SvgPicture.asset(
              "assets/ic_search.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 24,
              height: GlobalVariable.ratioWidth(Get.context) * 24,
            ),
          ),
          showClear
              ? Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.grey),
                    onPressed: () async {
                      searchInput.clear();
                      await onClear();
                    },
                  ))
              : SizedBox.shrink()
        ],
      );

  AppBarCustom2({
    this.hintText = "Search",
    this.preferredSize,
    this.searchInput,
    this.listOption,
    this.onSearch,
    this.onChange,
    this.onClear,
    this.onSelect,
    this.isEnableSearchTextField = true,
    this.showClear = false,
  });
}
