import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPemenangLelangSearchBar extends GetView<ZoPemenangLelangController> {
  final bool isSearchActive;

  ZoPemenangLelangSearchBar({
    Key key,
    @required this.isSearchActive,
  }) : super(key: key);

  InputBorder _getBorder(bool isWithBorder) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: isWithBorder
          ? BorderSide(
              color: Color(ListColor.colorLightGrey10),
              width: GlobalVariable.ratioWidth(Get.context) * 1.0,
            )
          : BorderSide.none);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Obx(
        () => Container(
          color: Color(
              isSearchActive ? ListColor.colorWhite : ListColor.colorBlue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: ClipOval(
                  child: Material(
                    shape: const CircleBorder(),
                    color: Color(isSearchActive
                        ? ListColor.colorBlue
                        : ListColor.colorWhite),
                    child: InkWell(
                      onTap: () {
                        controller.reset();
                        controller.searchRefreshController.refreshCompleted();
                        Get.back();
                      },
                      child: Container(
                        width: GlobalVariable.ratioFontSize(context) * 24,
                        height: GlobalVariable.ratioFontSize(context) * 24,
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: GlobalVariable.ratioFontSize(context) * 14,
                            color: Color(isSearchActive
                                ? ListColor.colorWhite
                                : ListColor.colorBlue),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // Obx(
                    //   () =>
                    GestureDetector(
                      onTap: isSearchActive
                          ? null
                          : () {
                              controller.isSearchActive.value = true;
                              controller.isSortEnabled.value =
                                  controller.searchQueryObs.isNotEmpty;
                              Get.toNamed(Routes.ZO_PEMENANG_LELANG +
                                  "/${controller.bidID}/search");
                            },
                      child: CustomTextField(
                        context: Get.context,
                        controller: isSearchActive
                            ? controller.searchController
                            : TextEditingController(),
                        enabled: isSearchActive,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          FocusManager.instance.primaryFocus.unfocus();
                          // controller.doSearch(value);
                        },
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        newContentPadding: EdgeInsets.symmetric(
                          horizontal: GlobalVariable.ratioWidth(context) * 42,
                          vertical: GlobalVariable.ratioWidth(context) * 6,
                        ),
                        textSize: GlobalVariable.ratioFontSize(context) * 14,
                        newInputDecoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          hintText:
                              "LelangMuatPesertaLelangPesertaLelangLabelTitleCariPemenangLelang"
                                  .tr,
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey2),
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: _getBorder(isSearchActive),
                          border: _getBorder(isSearchActive),
                          focusedBorder: _getBorder(isSearchActive),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(context) * 7,
                      ),
                      child: SvgPicture.asset(
                        "assets/search_magnifition_icon.svg",
                        width: GlobalVariable.ratioFontSize(context) * 20,
                        height: GlobalVariable.ratioFontSize(context) * 20,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child:
                          //  Obx(() => controller.isShowClearSearch.value
                          //     ? GestureDetector(
                          //         onTap: () {
                          //           controller.onClearSearch();
                          //         },
                          //         child: Container(
                          //             margin: EdgeInsets.only(right: 10),
                          //             child: Icon(
                          //               Icons.close_rounded,
                          //               color: Color(ListColor.colorGrey3),
                          //               size:
                          //                   GlobalVariable.ratioWidth(Get.context) *
                          //                       24,
                          //             )),
                          //       )
                          //     :
                          SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              // controller.isSearchActive.isTrue
              //     ? Expanded(child: _buildSearchFieldWidget(context))
              //     : GestureDetector(
              //         onTap: controller.isSearchActive.isFalse ? null : () {
              //           controller.isSearchActive.value = true;
              //           Get.toNamed(Routes.ZO_PEMENANG_LELANG +
              //               "/${controller.bidID}/search");
              //         },
              //         child: Expanded(child: _buildSearchFieldWidget(context)),
              //       ),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
              ClipOval(
                child: Material(
                  shape: const CircleBorder(),
                  color: controller.isSortEnabled.isFalse ||
                          controller.sortMapObs.isEmpty
                      ? Colors.transparent
                      : isSearchActive
                          ? Colors.black
                          : Color(ListColor.colorWhite),
                  child: InkWell(
                    onTap: controller.isSortEnabled.isFalse
                        ? null
                        : () {
                            FocusManager.instance.primaryFocus.unfocus();
                            controller.showSort();
                          },
                    child: Container(
                      width: GlobalVariable.ratioFontSize(context) * 24,
                      height: GlobalVariable.ratioFontSize(context) * 24,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/sorting_icon.svg",
                        color: controller.isSortEnabled.isTrue
                            ? controller.sortMapObs.isEmpty
                                ? isSearchActive
                                    ? Colors.black
                                    : Color(ListColor.colorWhite)
                                : isSearchActive
                                    ? Color(ListColor.colorWhite)
                                    : Color(ListColor.colorBlue)
                            : Color(ListColor.colorLightGrey2),
                        height: GlobalVariable.ratioFontSize(context) * 24,
                        width: GlobalVariable.ratioFontSize(context) * 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
