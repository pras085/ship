import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class AppBarCustom2 extends PreferredSize {
  TextEditingController searchInput;
  String hintText;
  List<Widget> listOption;
  Function(String) onSearch;
  Function(String) onChange;
  Function() onSelect;
  Function() onClear;
  bool isEnableSearchTextField;

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
                image: AssetImage(
                    GlobalVariable.imagePath + "fallin_star_3_icon.png"),
                height: preferredSize.height,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: ClipOval(
                      child: Material(
                          shape: CircleBorder(),
                          color: Colors.white,
                          child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                      child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: 30 * 0.7,
                                    color: Color(ListColor.color4),
                                  ))))),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          margin:
                              EdgeInsets.only(left: 13, top: 11, bottom: 11),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12))),
                          child: onSelect != null && !isEnableSearchTextField
                              ? GestureDetector(
                                  onTap: onSelect, child: _searchTextField)
                              : _searchTextField)),
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
        alignment: Alignment.center,
        children: [
          TextField(
            enabled: isEnableSearchTextField,
            controller: searchInput,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            textInputAction: TextInputAction.go,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintText: hintText,
                filled: true,
                contentPadding: EdgeInsets.all(10)),
            onSubmitted: (String str) async {
              await onSearch(str);
            },
            onChanged: (String str) async {
              await onChange(str);
            },
            onTap: () async {
              if (!onSelect.isNull) await onSelect();
            },
          ),
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.grey),
                onPressed: () async {
                  searchInput.clear();
                  await onClear();
                },
              ))
        ],
      );

  AppBarCustom2(
      {this.hintText = "Search",
      this.preferredSize,
      this.searchInput,
      this.listOption,
      this.onSearch,
      this.onChange,
      this.onClear,
      this.onSelect,
      this.isEnableSearchTextField = true});
}
