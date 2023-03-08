import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_with_text_widget.dart';
import 'package:muatmuat/global_variable.dart';

class SortingController extends GetxController {
  var _phoneheight = MediaQuery.of(Get.context).size.height * 4 / 5;
  final void Function(Map<String, dynamic> sort) onRefreshData;

  GlobalKey _containerKeyCustom1 = GlobalKey();
  GlobalKey _containerKeyCustom2 = GlobalKey();
  GlobalKey _containerKeyCustom3 = GlobalKey();
  GlobalKey _containerKeyCustom4 = GlobalKey();
  double _heightContainer1 = 0;
  double _heightContainer2 = 0;
  double _heightContainer3 = 0;
  double _heightContainer4 = 0;
  final double _fontSizeNumber = 10;
  final double _fontSizeTitle = 14;
  final double _fontSizeValue = 12;
  final _isShrinkWrapCustomSort = true.obs;
  // final groupValueTransporter = "".obs;
  // final groupValueKota = "".obs;
  // final groupValueTahun = "".obs;
  // final groupValueJumlahTruk = "".obs;
  // final groupValueLainnya = "".obs;

  Map<String, dynamic> _sortMap = Map();
  var _customSortMap = Map<String, dynamic>().obs;
  var _customSortMapTemp = Map<String, dynamic>().obs;
  var initMap = Map<String, dynamic>();
  bool enableCustomSort;

  final listSortingModel = [].obs;
  List<DataListSortingModel> listSort;

  SortingController(
      {this.onRefreshData,
      @required this.listSort,
      this.initMap = null,
      this.enableCustomSort = true});

  @override
  void onInit() {
    listSortingModel.addAll(listSort);
    if (initMap != null && initMap.length > 0) {
      if (initMap.keys.length == 1) {
        _sortMap = Map.from(initMap);
      } else {
        _customSortMap.value = Map.from(initMap);
      }
    }
  }

  void _setExpandList() {
    for (int i = 0; i < listSortingModel.length; i++)
      listSortingModel[i].isExpand = listSortingModel[i].groupValue.value != "";
  }

  showSort() async {
    _setExpandList();
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20),
                topRight: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: GlobalVariable.ratioHeight(Get.context) * 4,
                        bottom: GlobalVariable.ratioHeight(Get.context) * 17),
                    child: Container(
                      width: GlobalVariable.ratioHeight(Get.context) * 38,
                      height: GlobalVariable.ratioHeight(Get.context) * 3,
                      decoration: BoxDecoration(
                          color: Color(ListColor.colorLightGrey16),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )),
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: CustomText("GlobalSortingTitle".tr,
                              fontWeight: FontWeight.w700,
                              color: Color(ListColor.colorBlue),
                              fontSize: 14),
                        )),
                    Container(
                        margin: EdgeInsets.only(
                            top: FontTopPadding.getSize(14),
                            left: GlobalVariable.ratioWidth(Get.context) * 20),
                        child: GestureDetector(
                          child: Container(
                              child: SvgPicture.asset(
                            "assets/ic_close1,5.svg",
                            color: Color(ListColor.colorBlack),
                            width: GlobalVariable.ratioWidth(Get.context) * 15,
                            height: GlobalVariable.ratioWidth(Get.context) * 15,
                          )),
                          onTap: () {
                            Get.back();
                          },
                        )),
                  ],
                ),
                Wrap(children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: _phoneheight,
                          minHeight: 0,
                          minWidth: double.infinity),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: GlobalVariable.ratioHeight(Get.context) * 10),
                        child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listSortingModel.length > 0
                                ? enableCustomSort
                                    ? listSortingModel.length + 1
                                    : listSortingModel.length
                                : 0,
                            itemBuilder: (context, index) {
                              if (!enableCustomSort ||
                                  (enableCustomSort &&
                                      index < listSortingModel.length)) {
                                return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent,
                                        ),
                                        child: ListTileTheme(
                                          dense: true,
                                          minVerticalPadding: 0,
                                          contentPadding: EdgeInsets.zero,
                                          iconColor: Colors.black,
                                          child: Obx(
                                            () => ExpansionTile(
                                              trailing: Icon(
                                                listSortingModel[index].isExpand
                                                    ? Icons
                                                        .keyboard_arrow_up_rounded
                                                    : Icons
                                                        .keyboard_arrow_down_rounded,
                                                color: Colors.black,
                                                size: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    24,
                                              ),
                                              tilePadding: EdgeInsets.symmetric(
                                                  vertical: 0,
                                                  horizontal:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16),
                                              key: GlobalKey(),
                                              initiallyExpanded:
                                                  listSortingModel[index]
                                                      .isExpand,
                                              onExpansionChanged: (value) {
                                                if (value)
                                                  _onExpandSorting(index);
                                                listSortingModel[index]
                                                    .isExpand = value;
                                                listSortingModel.refresh();
                                              },
                                              title: CustomText(
                                                  listSortingModel[index].title,
                                                  fontSize: _textStyleTitle()
                                                      .fontSize,
                                                  color: Color(
                                                      listSortingModel[index]
                                                              .isExpand
                                                          ? ListColor.color4
                                                          : ListColor
                                                              .colorLightGrey4),
                                                  fontWeight: _textStyleTitle()
                                                      .fontWeight),
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16,
                                                      bottom: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          9),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: _itemSortingDetailWidget(
                                                            listSortingModel[index]
                                                                .groupValue
                                                                .value,
                                                            listSortingModel[index]
                                                                    .isTitleASCFirst
                                                                ? listSortingModel[
                                                                        index]
                                                                    .titleASC
                                                                : listSortingModel[
                                                                        index]
                                                                    .titleDESC,
                                                            (value) {
                                                          _onChooseSorting(
                                                              index, value);
                                                        }),
                                                      ),
                                                      Expanded(
                                                        child: _itemSortingDetailWidget(
                                                            listSortingModel[
                                                                    index]
                                                                .groupValue
                                                                .value,
                                                            listSortingModel[
                                                                        index]
                                                                    .isTitleASCFirst
                                                                ? listSortingModel[
                                                                        index]
                                                                    .titleDESC
                                                                : listSortingModel[
                                                                        index]
                                                                    .titleASC,
                                                            (value) {
                                                          _onChooseSorting(
                                                              index, value);
                                                        }),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      _lineSaparator()
                                    ]);
                              }
                              if (enableCustomSort) {
                                var theme = Theme.of(Get.context);
                                return Container(
                                  width: MediaQuery.of(Get.context).size.width,
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          showCustomSort();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      16,
                                              vertical:
                                                  GlobalVariable.ratioHeight(
                                                          Get.context) *
                                                      12),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                CustomText(
                                                    "GlobalSortingLabelOther"
                                                        .tr,
                                                    color: Color(ListColor
                                                        .colorLightGrey4),
                                                    fontSize: _textStyleTitle()
                                                        .fontSize,
                                                    fontWeight:
                                                        _textStyleTitle()
                                                            .fontWeight),
                                                Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: Colors.black,
                                                  size:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                )
                                              ]),
                                        ),
                                      )),
                                );
                              }
                              return null;
                            }),
                      )),
                ]),
              ],
            ),
          );
        });
  }

  Widget _itemSortingDetailWidget(
      String groupValue, String value, void Function(String) onChanged) {
    return Container(
      child: RadioButtonCustomWithText(
        isWithShadow: true,
        toggleable: true,
        isDense: true,
        radioSize: GlobalVariable.ratioWidth(Get.context) * 16,
        groupValue: groupValue,
        value: value,
        onChanged: onChanged,
        customTextWidget: Container(
          margin:
              EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 9),
          child: CustomText(value,
              fontSize: _fontSizeValue,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4)),
        ),
      ),
    );
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     RadioButtonCustom(
    //       toggleable: true,
    //       groupValue: groupValue,
    //       value: value,
    //       onChanged: onChanged,
    //     ),
    //     SizedBox(width: 5),
    //     Text(value),
    //   ],
    // );
  }

  void _onExpandSorting(int index) {
    for (int i = 0; i < listSortingModel.length; i++) {
      if (i != index)
        listSortingModel[i].isExpand = false;
      else
        listSortingModel[i].isExpand = true;
    }
    listSortingModel.refresh();
  }

  void _onChooseSorting(int index, String value) {
    value = value ?? "";
    _customSortMapTemp.clear();
    _customSortMap.clear();
    for (int i = 0; i < listSortingModel.length; i++) {
      if (i != index)
        listSortingModel[i].groupValue.value = "";
      else
        listSortingModel[i].groupValue.value = value;
    }
    listSortingModel.refresh();
    _sortMap.clear();
    if (value != "") {
      _sortMap[listSortingModel[index].keyParam] =
          value == listSortingModel[index].titleASC ? "ASC" : "DESC";
    }
    onRefreshData(_sortMap);
    Get.back();
  }

  void clearSorting() {
    _sortMap.clear();
    for (int i = 0; i < listSortingModel.length; i++) {
      listSortingModel[i].groupValue.value = "";
    }
  }

  void _onCompleteBuildCustomSort() {
    if (_heightContainer1 == 0) {
      final renderBox1 =
          _containerKeyCustom1.currentContext.findRenderObject() as RenderBox;
      final renderBox2 =
          _containerKeyCustom2.currentContext.findRenderObject() as RenderBox;
      final renderBox3 =
          _containerKeyCustom3.currentContext.findRenderObject() as RenderBox;
      final renderBox4 =
          _containerKeyCustom4.currentContext.findRenderObject() as RenderBox;
      _heightContainer1 = renderBox1.size.height;
      _heightContainer2 = renderBox2.size.height;
      _heightContainer3 = renderBox3.size.height;
      _heightContainer4 = renderBox4.size.height;
      double total = _heightContainer1 +
          _heightContainer2 +
          _heightContainer3 +
          _heightContainer4;
      if (total >= _phoneheight) {
        _isShrinkWrapCustomSort.value = false;
        listSortingModel.refresh();
      }
    }
  }

  void showCustomSort() {
    _customSortMapTemp.clear();
    _customSortMapTemp.addAll(Map.from(_customSortMap.value));
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20),
                topRight: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => _onCompleteBuildCustomSort());
          return Obx(
            () => Column(
              mainAxisSize: _isShrinkWrapCustomSort.value
                  ? MainAxisSize.min
                  : MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: GlobalVariable.ratioHeight(Get.context) * 3),
                    child: Container(
                      width: GlobalVariable.ratioHeight(Get.context) * 38,
                      height: 3,
                      decoration: BoxDecoration(
                          color: Color(ListColor.colorLightGrey16),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )),
                Container(
                    key: _containerKeyCustom2,
                    padding: EdgeInsets.only(
                      top: GlobalVariable.ratioHeight(Get.context) * 20,
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 13,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.close_rounded,
                            size: GlobalVariable.ratioWidth(Get.context) * 16,
                          ),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 13,
                        ),
                        CustomText("GlobalSortingLabelOther".tr,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 14),
                      ],
                    )),
                Obx(() => _isShrinkWrapCustomSort.value
                    ? _listSortCustom()
                    : Expanded(child: _listSortCustom())),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 9,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 12),
                  key: _containerKeyCustom4,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(ListColor.color4),
                        side: BorderSide(
                            width: 1, color: Color(ListColor.color4)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 26)),
                        )),
                    onPressed: () {
                      for (int i = 0; i < listSortingModel.length; i++) {
                        listSortingModel[i].isExpand = false;
                        listSortingModel[i].groupValue.value = "";
                      }
                      listSortingModel.refresh();
                      _sortMap.clear();
                      _customSortMap.clear();
                      _customSortMap.addAll(_customSortMapTemp);
                      _customSortMapTemp.clear();
                      onRefreshData(_customSortMap);
                      Get.back();
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 54,
                          vertical:
                              GlobalVariable.ratioHeight(Get.context) * 8),
                      child: CustomText("ListTransporterLabelFilter".tr,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _listSortCustom() {
    return
        // Container(
        //   height: _isShrinkWrapCustomSort.value ? null : double.infinity,
        //   key: _containerKeyCustom3,
        //   padding: EdgeInsets.fromLTRB(
        //       GlobalVariable.ratioWidth(Get.context) * 11,
        //       0,
        //       GlobalVariable.ratioWidth(Get.context) * 11,
        //       GlobalVariable.ratioWidth(Get.context) * 12),
        //   child:
        Wrap(children: [
      ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: _phoneheight, minHeight: 0, minWidth: double.infinity),
          child: Container(
            padding: EdgeInsets.only(
                top: GlobalVariable.ratioHeight(Get.context) * 10,
                left: GlobalVariable.ratioWidth(Get.context) * 16),
            child: Obx(
              () => ListView.builder(
                shrinkWrap: _isShrinkWrapCustomSort.value,
                itemCount: listSortingModel.length,
                itemBuilder: (context, index) {
                  DataListSortingModel data = listSortingModel[index];
                  return customSortChoice(
                      data.title,
                      data.keyParam,
                      data.titleASC,
                      data.titleDESC,
                      index == listSortingModel.length - 1,
                      data.isTitleASCFirst,
                      index == (listSortingModel.length - 1));
                },
              ),
            ),
          ))
    ]);
  }

  Widget customSortChoice(String word, String choiceValue, String titleAsc,
      String titleDesc, bool isLastData, bool isTitleASCFirst, bool isLast) {
    return GestureDetector(
      onTap: () {
        if (_customSortMapTemp.keys.contains(choiceValue)) {
          _customSortMapTemp.removeWhere((key, value) => key == choiceValue);
        } else {
          _customSortMapTemp[choiceValue] = "ASC";
        }
      },
      child: Container(
        child: Obx(() => Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: GlobalVariable.ratioWidth(Get.context) * 16,
                    height: GlobalVariable.ratioWidth(Get.context) * 16,
                    margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 13,
                        right: GlobalVariable.ratioWidth(Get.context) * 4),
                    child: _customSortMapTemp.keys.contains(choiceValue)
                        ? SvgPicture.asset(
                            "assets/${(_customSortMapTemp.keys.toList().indexOf(choiceValue) % 10) + 1}.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 16,
                            height: GlobalVariable.ratioWidth(Get.context) * 16,
                          )
                        : SizedBox.shrink()),
                Expanded(
                  child: Container(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Container(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          13),
                                  CustomText(word,
                                      fontWeight: FontWeight.w600,
                                      fontSize: _fontSizeTitle,
                                      color: Colors.black),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: GlobalVariable.ratioHeight(
                                                Get.context) *
                                            12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                            child: isTitleASCFirst
                                                ? _perRadioButtonCustomSort(
                                                    choiceValue,
                                                    "ASC",
                                                    titleAsc)
                                                : _perRadioButtonCustomSort(
                                                    choiceValue,
                                                    "DESC",
                                                    titleDesc)),
                                        Expanded(
                                            child: isTitleASCFirst
                                                ? _perRadioButtonCustomSort(
                                                    choiceValue,
                                                    "DESC",
                                                    titleDesc)
                                                : _perRadioButtonCustomSort(
                                                    choiceValue,
                                                    "ASC",
                                                    titleAsc)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          13)
                                ]),
                          )),
                          Container(
                              margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          6),
                              alignment: Alignment.center,
                              child: CheckBoxCustom(
                                  size: 16,
                                  shadowSize: 19,
                                  isWithShadow: true,
                                  value: _customSortMapTemp.keys
                                      .contains(choiceValue),
                                  onChanged: (value) {
                                    if (value) {
                                      _customSortMapTemp[choiceValue] = "ASC";
                                      // sortChoice.value = "ASC";
                                    } else {
                                      _customSortMapTemp.removeWhere(
                                          (key, value) => key == choiceValue);
                                      // sortChoice.value = "";
                                    }
                                  })),
                        ],
                      ),
                      isLast
                          ? SizedBox.shrink()
                          : Container(
                              height:
                                  GlobalVariable.ratioHeight(Get.context) * 0.5,
                              margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16),
                              width: MediaQuery.of(Get.context).size.width,
                              color: Color(ListColor.colorLightGrey10))
                      // : SizedBox.shrink()
                    ]),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _perRadioButtonCustomSort(
      String choiceValue, String val, String title) {
    return GestureDetector(
        onTap: () {
          _onChooseRadioButtonCustomSort(choiceValue, val);
        },
        child: RadioButtonCustomWithText(
          isWithShadow: true,
          isDense: true,
          toggleable: true,
          groupValue: _customSortMapTemp[choiceValue],
          value: val,
          onChanged: (val) {
            _onChooseRadioButtonCustomSort(choiceValue, val);
          },
          customTextWidget: CustomText(title,
              fontSize: _fontSizeValue,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4)),
        )
        // Row(
        //   mainAxisSize: MainAxisSize.max,
        //   children: [
        //     Radio(
        //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //       groupValue: _customSortMapTemp[choiceValue],
        //       // groupValue: sortChoice.value,
        //       value: val,
        //       onChanged: (val) {
        //         _onChooseRadioButtonCustomSort(choiceValue, val);
        //       },
        //     ),
        //     Text(title),
        //   ],
        // ),
        );
  }

  void _onChooseRadioButtonCustomSort(String choiceValue, String val) {
    if (val == "")
      _customSortMapTemp.remove(choiceValue);
    else
      _customSortMapTemp[choiceValue] = val;
  }

  Widget _lineSaparator() {
    return Container(
        height: GlobalVariable.ratioHeight(Get.context) * 0.5,
        margin: EdgeInsets.only(
            left: GlobalVariable.ratioWidth(Get.context) * 16,
            right: GlobalVariable.ratioWidth(Get.context) * 16),
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey10));
  }

  TextStyle _textStyleTitle() =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
}
