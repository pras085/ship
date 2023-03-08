import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'search_manajemen_lokasi_info_permintaan_muat_controller.dart';

class SearchManajemenLokasiInfoPermintaanMuatView
    extends GetView<SearchManajemenLokasiInfoPermintaanMuatController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(65),
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 8)),
              ], color: Colors.white),
              child: Stack(alignment: Alignment.bottomCenter, children: [
                Column(mainAxisSize: MainAxisSize.max, children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: ClipOval(
                            child: Material(
                                shape: CircleBorder(),
                                color: Color(ListColor.color4),
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
                                          size: 20,
                                          color: Colors.white,
                                        ))))),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              CustomTextField(
                                  autofocus: true,
                                  onChanged: (value) {
                                    controller.addTextSearch(value);
                                  },
                                  controller: controller
                                      .searchTextEditingController.value,
                                  textInputAction: TextInputAction.search,
                                  // onSubmitted: (value) {
                                  //   controller.onSubmitSearch();
                                  // },
                                  newContentPadding: EdgeInsets.symmetric(
                                      horizontal: 42,
                                      vertical:
                                          GlobalVariable.ratioHeight(context) *
                                              6),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  textSize: 14,
                                  context: Get.context,
                                  newInputDecoration: InputDecoration(
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText:
                                        "LocationManagementLabelSearchHint".tr,
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: Color(ListColor.colorLightGrey2),
                                        fontWeight: FontWeight.w600),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color(ListColor.colorLightGrey7),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color(ListColor.colorLightGrey7),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color(ListColor.colorLightGrey7),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: SvgPicture.asset(
                                  "assets/search_magnifition_icon.svg",
                                  width: 30,
                                  height: 30,
                                  color: Color(ListColor.colorGrey5),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Obx(
                                  () => controller.isShowClearSearch.value
                                      ? GestureDetector(
                                          onTap: () {
                                            controller.onClearSearch();
                                          },
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.close_rounded,
                                                size:
                                                    GlobalVariable.ratioHeight(
                                                            Get.context) *
                                                        24,
                                              )),
                                        )
                                      : SizedBox.shrink(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: Color(ListColor.colorLightBlue5))
              ]),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: GlobalVariable.ratioHeight(Get.context) * 19,
              ),
              _containerPerItem(
                child: CustomText(
                  "LocationManagementLabelLocationManagement".tr,
                  color: Color(ListColor.colorLightGrey14),
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
              Expanded(
                child: Obx(
                  () => SmartRefresher(
                      enablePullUp: true,
                      controller: controller.refreshController,
                      onLoading: () {
                        controller.onLoadingData();
                      },
                      onRefresh: () {
                        controller.onRefreshData();
                      },
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount: controller.listSaveLocation.length,
                            itemBuilder: (content, index) {
                              return _manajemenLokasiPerItem(context, index);
                              //mitraTile2(controller.listMitra[index]);
                            },
                          ),
                          Obx(() => !controller.isGettingData.value &&
                                  controller.listSaveLocation.length == 0
                              ? Align(
                                  alignment: Alignment.center,
                                  child: CustomText(
                                      "LocationManagementLabelNoData".tr))
                              : SizedBox.shrink()),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerPerItem({@required Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 20),
      child: child,
    );
  }

  Widget _manajemenLokasiPerItem(BuildContext context, int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          controller.onClickListManajemenLokasi(index);
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioHeight(Get.context) * 10,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 20),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: FontTopPadding.getSize(12)),
                    child: SvgPicture.asset(
                      "assets/marked_icon.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 10,
                      height: GlobalVariable.ratioWidth(Get.context) * 14,
                    ),
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    controller.listSaveLocation[index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    color: Color(ListColor.colorDarkGrey4),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioHeight(Get.context) *
                                          4,
                                ),
                                CustomText(
                                    controller.listSaveLocation[index].address,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    color: Color(ListColor.colorGrey3),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ]),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 24,
                        ),
                        GestureDetector(
                            onTap: () {
                              controller.onClickEdit(index);
                            },
                            child: Container(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10,
                                    10 + FontTopPadding.getSize(12), 10, 10),
                                child: SvgPicture.asset(
                                  "assets/edit_pencil_icon.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ])),
      ),
    );
  }
}
