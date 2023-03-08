import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/create_permintaan_muat/create_permintaan_muat_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_user_info_permintaan_muat/list_user_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/modules/select_head_carrier/select_head_carrier_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:latlong/latlong.dart';

class CreatePermintaanMuatView extends GetView<CreatePermintaanMuatController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return WillPopScope(
      onWillPop: (){
        return Future.value(!controller.loadingAPI.value);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Center(
            child: GestureDetector(
              onTap: (){
                if(!controller.loadingAPI.value)
                  Get.back();
              },
              child: Container(
                child: SvgPicture.asset(
                  "assets/ic_back_blue_in_white.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                ),
              ),
            )
          ),
          titleSpacing: 0,
          title: CustomText("Buat Info Permintaan Muat",
              fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white),
          elevation: 0,
        ),
        body: SafeArea(
          child: Obx(()=>
            Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: _appBar.preferredSize.height,
                      color: Color(ListColor.color4),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) * 16),
                              height: GlobalVariable.ratioWidth(Get.context) * 0.5,
                              child: Container(color: Color(ListColor.colorLightBlue5))),
                          Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) * 16,
                                    vertical: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Obx(() => CustomText(
                                          controller.title.value,
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                    )),
                                    Obx(
                                      () => Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          for (int i = 0; i < 4; i++)
                                            _buildPageIndicator(
                                                i == controller.slideIndex.value, i)
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        controller.slideIndex.value = index;
                        controller.updateTitle();
                        controller.refreshMap(index);
                      },
                      controller: controller.pageController,
                      children: [
                        firstPage(context),
                        secondPage(context),
                        thirdPage(),
                        fourthPage()
                      ],
                    )),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                          vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                          topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.61),
                            offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * -3),
                            blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
                            spreadRadius: 0
                          )
                        ]
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Obx(() => Opacity(
                                  opacity: controller.slideIndex == 0 ? 0 : 1,
                                  child: MaterialButton(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            GlobalVariable.ratioWidth(Get.context) * 9),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                        side:
                                            BorderSide(color: Color(ListColor.color4))),
                                    onPressed: () {
                                      if (controller.slideIndex.value != 0) {
                                        FocusManager.instance.primaryFocus.unfocus();
                                        controller.slideIndex.value--;
                                        controller.pageController.animateToPage(
                                            controller.slideIndex.value,
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.linear);
                                      }
                                    },
                                    child: CustomText(
                                      "InfoPermintaanMuatLabelKembali".tr,
                                      color: Color(ListColor.color4),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )),
                          ),
                          Container(width: GlobalVariable.ratioWidth(Get.context) * 12),
                          Expanded(
                            child: Obx(() => MaterialButton(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          GlobalVariable.ratioWidth(Get.context) * 9),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  color: Color(ListColor.color4),
                                  onPressed: () {
                                    var valid = false;
                                    switch (controller.slideIndex.value) {
                                      case 0:
                                        {
                                          valid = controller.formOne.currentState
                                              .validate();
                                          break;
                                        }
                                      case 1:
                                        {
                                          valid = controller.formTwo.currentState
                                              .validate();
                                          break;
                                        }
                                      case 2:
                                        {
                                          valid = controller.formThree.currentState
                                              .validate();
                                          break;
                                        }
                                      case 3:
                                        {
                                          valid = controller.formFour.currentState
                                              .validate();
                                          break;
                                        }
                                    }
                                    if (valid) {
                                      FocusScope.of(Get.context).unfocus();
                                      FocusManager.instance.primaryFocus.unfocus();
                                      if (controller.slideIndex.value != 3) {
                                        controller.slideIndex.value++;
                                        controller.pageController.animateToPage(
                                            controller.slideIndex.value,
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.linear);
                                      } else {
                                        controller.onSave();
                                      }
                                    }
                                  },
                                  child: CustomText(
                                    controller.slideIndex.value == 3
                                        ? "InfoPermintaanMuatLabelSimpan".tr
                                        : "InfoPermintaanMuatLabelSelanjutnya".tr,
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                !controller.loadingAPI.value 
                ? SizedBox.shrink()
                : Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 12)
                        ),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(ListColor.color4)),
                        ))
                    )
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: GlobalVariable.ratioWidth(Get.context) * 20,
          height: GlobalVariable.ratioWidth(Get.context) * 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isCurrentPage
                ? Color(ListColor.colorYellow)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(ListColor.colorYellow), width: 2),
          ),
          child: CustomText((index + 1).toString(),
              color: isCurrentPage ? Color(ListColor.colorBlue) : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        index == 3
            ? SizedBox.shrink()
            : Container(
                height: GlobalVariable.ratioWidth(Get.context) * 2, width: GlobalVariable.ratioWidth(Get.context) * 11, color: Color(ListColor.colorYellow))
      ],
    );
  }

  Widget firstPage(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: controller.formOne,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("InfoPermintaanMuatLabelTipePickup".tr,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(ListColor.colorGrey3)),
                    Container(
                        height: GlobalVariable.ratioWidth(Get.context) * 9),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => RadioButtonCustom(
                                groupValue: controller.jenisLokasi.value,
                                value: "0",
                                isDense: true,
                                isWithShadow: true,
                                onChanged: (str) {
                                  controller.jenisLokasi.value = str;
                                  controller.totalLokasi.value = "1";
                                  controller.latlngLokasi.clear();
                                  controller.namaLokasi.clear();
                                  controller.deskripsiLokasi.clear();
                                  controller.namaPICPickup.clear();
                                  controller.nomorPICPickup.clear();
                                  controller
                                      .setTextEditingControllerNoPICPickUp();
                                },
                              ),
                            ),
                            Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 9),
                            CustomText("InfoPermintaanMuatLabelSatuLokasi".tr,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => RadioButtonCustom(
                                groupValue: controller.jenisLokasi.value,
                                value: "1",
                                isDense: true,
                                isWithShadow: true,
                                onChanged: (str) {
                                  controller.jenisLokasi.value = str;
                                  controller.totalLokasi.value = "2";
                                  controller.latlngLokasi.clear();
                                  controller.namaLokasi.clear();
                                  controller.deskripsiLokasi.clear();
                                  controller.namaPICPickup.clear();
                                  controller.nomorPICPickup.clear();
                                  controller
                                      .setTextEditingControllerNoPICPickUp();
                                },
                              ),
                            ),
                            Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 9),
                            CustomText("InfoPermintaanMuatLabelMultiLokasi".tr,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ],
                        ))
                      ],
                    ),
                    controller.jenisLokasi.value != "1"
                        ? SizedBox.shrink()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24),
                              CustomText(
                                  "InfoPermintaanMuatLabelTotalLokasi".tr,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(ListColor.colorGrey3)),
                              Container(
                                  height:
                                      GlobalVariable.ratioWidth(context) * 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Stack(children: [
                                      _textFormField(
                                          isEnable: false,
                                          title: "",
                                          isSetTitleToHint: true,
                                          initialValue: "",
                                          marginBottom: 0),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Obx(() => DropdownButton(
                                              isExpanded: true,
                                              underline: Container(),
                                              value:
                                                  controller.totalLokasi.value,
                                              items: ["2", "3", "4", "5"]
                                                  .map((data) {
                                                return DropdownMenuItem(
                                                  child: CustomText(data),
                                                  value: data,
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                controller.totalLokasi.value =
                                                    value;
                                                controller.latlngLokasi.clear();
                                                controller.namaLokasi.clear();
                                                controller.deskripsiLokasi
                                                    .clear();
                                                controller.namaPICPickup
                                                    .clear();
                                                controller.nomorPICPickup
                                                    .clear();
                                                controller
                                                    .setTextEditingControllerNoPICPickUp();
                                              },
                                            )),
                                      ),
                                    ]),
                                  ),
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            12),
                                    child: CustomText(
                                        "InfoPermintaanMuatLabelLokasi".tr,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ))
                                ],
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
            Container(
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var index = 0;
                        index < int.parse(controller.totalLokasi.value);
                        index++)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        12),
                            child: GestureDetector(
                              onTap: () {
                                controller.onClickAddress("lokasi");
                              },
                              child: Obx(
                                () => _textFormField(
                                    title: "InfoPermintaanMuatLabelAlamatLokasi"
                                        .tr,
                                    isEnable: false,
                                    prefixIcon: Container(
                                      alignment: Alignment.center,
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          38,
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          SvgPicture.asset(
                                            controller.totalLokasi.value == "1"
                                                ? "assets/pin_truck_icon.svg"
                                                : index == 0
                                                    ? "assets/pin_yellow_icon.svg"
                                                    : "assets/pin_blue_icon.svg",
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                18,
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                24,
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          5),
                                              child: CustomText(
                                                  controller.totalLokasi
                                                              .value ==
                                                          "1"
                                                      ? ""
                                                      : (index + 1).toString(),
                                                  color: index == 0
                                                      ? Color(ListColor.color4)
                                                      : Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 8))
                                        ],
                                      ),
                                    ),
                                    textEditingController:
                                        TextEditingController(
                                            text: (controller.namaLokasi[
                                                            index.toString()] ==
                                                        null ||
                                                    controller
                                                        .namaLokasi[
                                                            index.toString()]
                                                        .isEmpty)
                                                ? ""
                                                : controller.namaLokasi[
                                                    index.toString()]),
                                    hintText:
                                        "InfoPermintaanMuatLabelHintAlamatLokasi"
                                            .tr,
                                    marginBottom: 0),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        12),
                            child: _textFormField(
                                title: "InfoPermintaanMuatLabelDetailLokasi".tr,
                                hintText:
                                    "InfoPermintaanMuatLabelDetailLokasi".tr,
                                initialValue:
                                    controller.deskripsiLokasi[index] == null ||
                                            controller
                                                .deskripsiLokasi[index].isEmpty
                                        ? ""
                                        : controller.deskripsiLokasi[index],
                                validator: (str) {
                                  if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                                  return null;
                                },
                                isMultiLine: true,
                                minLines: 3,
                                maxLines: 3,
                                onChanged: (str) {
                                  controller.deskripsiLokasi[index] = str;
                                },
                                marginBottom: 0),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        12),
                            child: _textFormField(
                                title: "InfoPermintaanMuatLabelNamaPIC".tr,
                                hintText: "InfoPermintaanMuatLabelNamaPIC".tr,
                                initialValue: controller.namaPICPickup[index] ==
                                            null ||
                                        controller.namaPICPickup[index].isEmpty
                                    ? ""
                                    : controller.namaPICPickup[index],
                                validator: (str) {
                                  if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                                  return null;
                                },
                                onChanged: (str) {
                                  controller.namaPICPickup[index] = str;
                                },
                                customTextInputFormatter: [
                                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
                                ],
                                marginBottom: 0),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        12),
                            child: _textFormField(
                                isPhoneNumber: true,
                                title: "InfoPermintaanMuatLabelNomorPIC".tr,
                                hintText: "InfoPermintaanMuatLabelNomorPIC".tr,
                                isNumber: true,
                                textEditingController: controller
                                    .textEditingControllerNoPICPickUp[index],
                                validator: (str) {
                                  if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                                  if (str.length <= 8) return "*${"InfoPermintaanMuatLabelFieldTidakValid".tr}";
                                  return null;
                                },
                                onChanged: (str) {
                                  controller.nomorPICPickup[index] = str;
                                },
                                customTextInputFormatter: [
                                  LengthLimitingTextInputFormatter(14)
                                ],
                                marginBottom: 0),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("InfoPermintaanMuatLabelWaktuEkspektasi".tr,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(ListColor.colorGrey3)),
                  Container(height: GlobalVariable.ratioWidth(context) * 8),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                        onTap: () async {
                          var time = await DateTime.now();
                          FocusScope.of(Get.context).unfocus();
                          FocusManager.instance.primaryFocus.unfocus();
                          DatePicker.showDateTimePicker(Get.context,
                              minTime: time,
                              showTitleActions: true,
                              currentTime: time, 
                              onConfirm: (date) {
                            controller.selectedWaktuLokasi.value = date;
                            controller.selectedWaktuDestinasi.value = date;
                            controller.selectedWaktuLokasiController.text =
                                controller.dateFormat.format(
                                    controller.selectedWaktuLokasi.value);
                          });
                        },
                        child: _textFormField(
                            isSetTitleToHint: true,
                            title:
                                "InfoPermintaanMuatLabelWaktuEkspektasi".tr,
                            hintText:
                                "InfoPermintaanMuatLabelWaktuEkspektasi".tr,
                            isEnable: false,
                            suffixIcon: Container(
                              padding: EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                  "assets/calendar_icon.svg",
                                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                                  color: Colors.black),
                            ),
                            textEditingController:
                                controller.selectedWaktuLokasiController,
                            validator: (str) {
                              if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                              return null;
                            },
                            marginBottom: 0),
                        ),
                      ),
                      Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 12,
                      ),
                      Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 92,
                        child: Stack(children: [
                          _textFormField(
                              isEnable: false,
                              title: "",
                              isSetTitleToHint: true,
                              initialValue: "",
                              marginBottom: 0),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Obx(
                              () => DropdownButton(
                                underline: SizedBox.shrink(),
                                isExpanded: true,
                                value: controller.selectedTimezoneLokasi.value,
                                hint: CustomText(
                                    'LTRSearchLabelSelectTypeOfTruck'.tr),
                                items: ["WIT", "WIB", "WITA"].map((data) {
                                  return DropdownMenuItem(
                                    child: CustomText(data),
                                    value: data,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.selectedTimezoneLokasi.value =
                                      value;
                                },
                              ),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 4),
                  CustomText(
                      "*untuk multi pickup, masukkan waktu lokasi pertama",
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6)),
                child: Stack(children: [
                  Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 152,
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      Expanded(
                        child: Obx(
                          () => Stack(
                            children: [
                              Obx(() => FlutterMap(
                                    options: MapOptions(
                                      center: GlobalVariable.centerMap,
                                      interactiveFlags: InteractiveFlag.none,
                                      zoom: 13.0,
                                    ),
                                    mapController:
                                        controller.mapLokasiController,
                                    layers: [
                                      GlobalVariable.tileLayerOptions,
                                      MarkerLayerOptions(markers: [
                                        for (var index = 0;
                                            index <
                                                controller
                                                    .latlngLokasi.keys.length;
                                            index++)
                                          Marker(
                                            width: 30.0,
                                            height: 30.0,
                                            point: controller
                                                .latlngLokasi.values
                                                .toList()[index],
                                            builder: (ctx) => Stack(
                                              alignment: Alignment.topCenter,
                                              children: [
                                                SvgPicture.asset(
                                                  controller.totalLokasi
                                                              .value ==
                                                          "1"
                                                      ? "assets/pin_truck_icon.svg"
                                                      : index == 0
                                                          ? "assets/pin_yellow_icon.svg"
                                                          : "assets/pin_blue_icon.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            5),
                                                    child: CustomText(
                                                        controller.totalLokasi.value == "1"
                                                            ? ""
                                                            : (int.parse(controller
                                                                            .latlngLokasi
                                                                            .keys
                                                                            .toList()[
                                                                        index]) +
                                                                    1)
                                                                .toString(),
                                                        color: index == 0
                                                            ? Color(ListColor.color4)
                                                            : Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 8))
                                              ],
                                            ),
                                          ),
                                      ])
                                    ],
                                  )),
                              !controller.loadMapLokasi.value
                                  ? SizedBox.shrink()
                                  : Positioned.fill(
                                      child: Container(
                                        color: Color(ListColor.colorLightGrey),
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: GlobalVariable.ratioWidth(Get.context) * 35,
                        width: MediaQuery.of(context).size.width,
                        color: Color(ListColor.color4),
                        child: Center(
                          child: CustomText(
                            "InfoPermintaanMuatLabelAturPin".tr,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ]),
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        controller.onClickAddress("lokasi");
                      },
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget secondPage(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: controller.formTwo,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("InfoPermintaanMuatLabelTipeDestinasi".tr,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(ListColor.colorGrey3)),
                    Container(
                        height: GlobalVariable.ratioWidth(Get.context) * 9),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => RadioButtonCustom(
                                groupValue: controller.jenisDestinasi.value,
                                value: "0",
                                isDense: true,
                                isWithShadow: true,
                                onChanged: (str) {
                                  controller.jenisDestinasi.value = str;
                                  controller.totalDestinasi.value = "1";
                                  controller.latlngDestinasi.clear();
                                  controller.namaDestinasi.clear();
                                  controller.deskripsiDestinasi.clear();
                                  controller.namaPICDestinasi.clear();
                                  controller.nomorPICDestinasi.clear();
                                  controller
                                      .setTextEditingControllerNoPICDestinasi();
                                },
                              ),
                            ),
                            Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 9),
                            CustomText("InfoPermintaanMuatLabelSatuLokasi".tr,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => RadioButtonCustom(
                                groupValue: controller.jenisDestinasi.value,
                                value: "1",
                                isDense: true,
                                isWithShadow: true,
                                onChanged: (str) {
                                  controller.jenisDestinasi.value = str;
                                  controller.totalDestinasi.value = "2";
                                  controller.latlngDestinasi.clear();
                                  controller.namaDestinasi.clear();
                                  controller.deskripsiDestinasi.clear();
                                  controller.namaPICDestinasi.clear();
                                  controller.nomorPICDestinasi.clear();
                                  controller
                                      .setTextEditingControllerNoPICDestinasi();
                                },
                              ),
                            ),
                            Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 9),
                            CustomText("InfoPermintaanMuatLabelMultiLokasi".tr,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ],
                        ))
                      ],
                    ),
                    controller.jenisDestinasi.value != "1"
                        ? Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 12)
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24),
                              CustomText(
                                  "InfoPermintaanMuatLabelTotalLokasi".tr,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(ListColor.colorGrey3)),
                              Container(
                                  height:
                                      GlobalVariable.ratioWidth(context) * 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Stack(children: [
                                      _textFormField(
                                          isEnable: false,
                                          title: "",
                                          isSetTitleToHint: true,
                                          initialValue: "",
                                          marginBottom: 0),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Obx(
                                          () => DropdownButton(
                                            isExpanded: true,
                                            underline: Container(),
                                            value:
                                                controller.totalDestinasi.value,
                                            items: ["2", "3", "4", "5"]
                                                .map((data) {
                                              return DropdownMenuItem(
                                                child: CustomText(data),
                                                value: data,
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              controller.totalDestinasi.value =
                                                  value;
                                              controller.latlngDestinasi
                                                  .clear();
                                              controller.namaDestinasi.clear();
                                              controller.deskripsiDestinasi
                                                  .clear();
                                              controller.namaPICDestinasi
                                                  .clear();
                                              controller.nomorPICDestinasi
                                                  .clear();
                                              controller
                                                  .setTextEditingControllerNoPICDestinasi();
                                            },
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            12),
                                    child: CustomText(
                                        "InfoPermintaanMuatLabelLokasi".tr,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ))
                                ],
                              ),
                              Container(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                              )
                            ],
                          )
                  ],
                ),
              ),
            ),
            Container(
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var index = 0;
                        index < int.parse(controller.totalDestinasi.value);
                        index++)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        12),
                            child: GestureDetector(
                              onTap: () {
                                controller.onClickAddress("destinasi");
                              },
                              child: Obx(
                                () => _textFormField(
                                    title: "InfoPermintaanMuatLabelAlamatLokasi"
                                        .tr,
                                    isEnable: false,
                                    prefixIcon: Container(
                                      alignment: Alignment.center,
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          38,
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          SvgPicture.asset(
                                            controller.totalDestinasi.value ==
                                                    "1"
                                                ? "assets/pin_truck_icon.svg"
                                                : index == 0
                                                    ? "assets/pin_yellow_icon.svg"
                                                    : "assets/pin_blue_icon.svg",
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                18,
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                24,
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          5),
                                              child: CustomText(
                                                  controller.totalDestinasi
                                                              .value ==
                                                          "1"
                                                      ? ""
                                                      : (index + 1).toString(),
                                                  color: index == 0
                                                      ? Color(ListColor.color4)
                                                      : Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 8))
                                        ],
                                      ),
                                    ),
                                    textEditingController:
                                        TextEditingController(
                                            text: (controller.namaDestinasi[
                                                            index.toString()] ==
                                                        null ||
                                                    controller
                                                        .namaDestinasi[
                                                            index.toString()]
                                                        .isEmpty)
                                                ? ""
                                                : controller.namaDestinasi[
                                                    index.toString()]),
                                    hintText:
                                        "InfoPermintaanMuatLabelHintAlamatLokasi"
                                            .tr,
                                    marginBottom: 0),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        12),
                            child: _textFormField(
                                title: "InfoPermintaanMuatLabelDetailLokasi".tr,
                                hintText:
                                    "InfoPermintaanMuatLabelDetailLokasi".tr,
                                initialValue:
                                    controller.deskripsiDestinasi[index] ==
                                                null ||
                                            controller.deskripsiDestinasi[index]
                                                .isEmpty
                                        ? ""
                                        : controller.deskripsiDestinasi[index],
                                validator: (str) {
                                  if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                                  return null;
                                },
                                isMultiLine: true,
                                maxLines: 3,
                                minLines: 3,
                                onChanged: (str) {
                                  controller.deskripsiDestinasi[index] = str;
                                },
                                marginBottom: 0),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        12),
                            child: _textFormField(
                                title: "InfoPermintaanMuatLabelNamaPIC".tr,
                                hintText: "InfoPermintaanMuatLabelNamaPIC".tr,
                                initialValue:
                                    controller.namaPICDestinasi[index] ==
                                                null ||
                                            controller
                                                .namaPICDestinasi[index].isEmpty
                                        ? ""
                                        : controller.namaPICDestinasi[index],
                                validator: (str) {
                                  if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                                  return null;
                                },
                                onChanged: (str) {
                                  controller.namaPICDestinasi[index] = str;
                                },
                                customTextInputFormatter: [
                                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
                                ],
                                marginBottom: 0),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        12),
                            child: _textFormField(
                                isPhoneNumber: true,
                                title: "InfoPermintaanMuatLabelNomorPIC".tr,
                                hintText: "InfoPermintaanMuatLabelNomorPIC".tr,
                                isNumber: true,
                                textEditingController: controller
                                    .textEditingControllerNoPICDestinasi[index],
                                validator: (str) {
                                  if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                                  if (str.length <= 8) return "Field tidak valid";
                                  return null;
                                },
                                onChanged: (str) {
                                  controller.nomorPICDestinasi[index] = str;
                                },
                                customTextInputFormatter: [
                                  LengthLimitingTextInputFormatter(14)
                                ],
                                marginBottom: 0),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("InfoPermintaanMuatLabelWaktuEkspektasi".tr,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(ListColor.colorGrey3)),
                  Container(height: GlobalVariable.ratioWidth(context) * 8),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                        onTap: () {
                          FocusScope.of(Get.context).unfocus();
                          FocusManager.instance.primaryFocus.unfocus();
                          DatePicker.showDateTimePicker(Get.context,
                              minTime: controller.selectedWaktuLokasi.value,
                              showTitleActions: true,
                              currentTime: controller.selectedWaktuDestinasi
                                  .value, onConfirm: (date) {
                            controller.selectedWaktuDestinasi.value = date;
                            controller.selectedWaktuDestinasiController.text =
                                controller.dateFormat.format(
                                    controller.selectedWaktuDestinasi.value);
                          });
                        },
                        child: _textFormField(
                            isSetTitleToHint: true,
                            title: "InfoPermintaanMuatLabelWaktuEkspektasi".tr,
                            hintText:
                                "InfoPermintaanMuatLabelWaktuEkspektasi".tr,
                            isEnable: false,
                            suffixIcon: Container(
                              padding: EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                  "assets/calendar_icon.svg",
                                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                                  color: Colors.black),
                            ),
                            textEditingController:
                                controller.selectedWaktuDestinasiController,
                            validator: (str) {
                              if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                              return null;
                            },
                            marginBottom: 0),
                      )),
                      Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 12,
                      ),
                      Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 92,
                        child: Stack(children: [
                          _textFormField(
                              isEnable: false,
                              title: "",
                              isSetTitleToHint: true,
                              initialValue: "",
                              marginBottom: 0),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Obx(
                              () => DropdownButton(
                                underline: SizedBox.shrink(),
                                isExpanded: true,
                                value:
                                    controller.selectedTimezoneDestinasi.value,
                                hint: CustomText(
                                    'LTRSearchLabelSelectTypeOfTruck'.tr),
                                items: ["WIT", "WIB", "WITA"].map((data) {
                                  return DropdownMenuItem(
                                    child: CustomText(data),
                                    value: data,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.selectedTimezoneDestinasi.value =
                                      value;
                                },
                              ),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                  Container(height: GlobalVariable.ratioWidth(Get.context) * 4),
                  CustomText(
                      "*untuk multi pickup, masukkan waktu lokasi pertama",
                      fontSize: 12,
                      color: Color(ListColor.colorDarkGrey3),
                      fontWeight: FontWeight.w600),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6)),
                child: Stack(children: [
                  Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 152,
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      Expanded(
                        child: Obx(
                          () => Stack(
                            children: [
                              Obx(() => FlutterMap(
                                    options: MapOptions(
                                      center: GlobalVariable.centerMap,
                                      interactiveFlags: InteractiveFlag.none,
                                      zoom: 13.0,
                                    ),
                                    mapController:
                                        controller.mapDestinasiController,
                                    layers: [
                                      GlobalVariable.tileLayerOptions,
                                      MarkerLayerOptions(markers: [
                                        for (var index = 0;
                                            index <
                                                controller.latlngDestinasi.keys
                                                    .length;
                                            index++)
                                          Marker(
                                            width: 30.0,
                                            height: 30.0,
                                            point: controller
                                                .latlngDestinasi.values
                                                .toList()[index],
                                            builder: (ctx) => Stack(
                                              alignment: Alignment.topCenter,
                                              children: [
                                                SvgPicture.asset(
                                                  controller.totalDestinasi
                                                              .value ==
                                                          "1"
                                                      ? "assets/pin_truck_icon.svg"
                                                      : index == 0
                                                          ? "assets/pin_yellow_icon.svg"
                                                          : "assets/pin_blue_icon.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            5),
                                                    child: CustomText(
                                                        controller.totalDestinasi
                                                                    .value ==
                                                                "1"
                                                            ? ""
                                                            : (int.parse(controller.latlngDestinasi.keys.toList()[index]) +
                                                                    1)
                                                                .toString(),
                                                        color: index == 0
                                                            ? Color(ListColor
                                                                .color4)
                                                            : Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 8))
                                              ],
                                            ),
                                          ),
                                      ])
                                    ],
                                  )),
                              !controller.loadMapDestinasi.value
                                  ? SizedBox.shrink()
                                  : Positioned.fill(
                                      child: Container(
                                        color: Color(ListColor.colorLightGrey),
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: GlobalVariable.ratioWidth(Get.context) * 35,
                        width: MediaQuery.of(context).size.width,
                        color: Color(ListColor.color4),
                        child: Center(
                          child: CustomText(
                            "InfoPermintaanMuatLabelAturPin".tr,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ]),
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        controller.onClickAddress("destinasi");
                      },
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget thirdPage() {
    return SingleChildScrollView(
      child: Form(
        key: controller.formThree,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("InfoPermintaanMuatLabelHeadDanKarier".tr,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(ListColor.colorGrey3)),
                    Container(
                        height: (GlobalVariable.ratioWidth(Get.context) * 4) - FontTopPadding.getSize(GlobalVariable.ratioWidth(Get.context) * 11)),
                    CustomText("InfoPermintaanMuatLabelMohonPilih".tr,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorDarkGrey3)),
                    Container(
                        height: GlobalVariable.ratioWidth(Get.context) * 24),
                    GestureDetector(
                      onTap: () async {
                        FocusScope.of(Get.context).unfocus();
                        FocusManager.instance.primaryFocus.unfocus();
                        var result = await GetToPage.toNamed<
                                SelectHeadCarrierController>(
                            Routes.SELECT_HEAD_CARRIER_TRUCK_INTERNAL,
                            arguments: [
                              "0",
                              0, // selected data
                              0,
                              "Cari Jenis Truk",
                              0
                            ]);
                        if (result != null) {
                          controller.editHeadTruk.value = result;
                          controller.editHeadTruckController.text =
                              result["Description"];
                        }
                        controller.checkImage();
                      },
                      child: _textFormField(
                          title: "InfoPermintaanMuatLabelJenisTruk".tr,
                          hintText: "InfoPermintaanMuatLabelJenisTruk".tr,
                          isSetTitleToHint: true,
                          isEnable: false,
                          suffixIcon: Container(
                              margin: EdgeInsets.only(right: 12),
                              child: Icon(Icons.keyboard_arrow_down_sharp)),
                          textEditingController:
                              controller.editHeadTruckController,
                          validator: (str) {
                            if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                            return null;
                          },
                          marginBottom: 0),
                    ),
                    Container(
                        height: GlobalVariable.ratioWidth(Get.context) * 24),
                    GestureDetector(
                      onTap: () async {
                        if (controller.editHeadTruk.isNotEmpty) {
                          FocusScope.of(Get.context).unfocus();
                          FocusManager.instance.primaryFocus.unfocus();
                          var result = await GetToPage.toNamed<
                                  SelectHeadCarrierController>(
                              Routes.SELECT_HEAD_CARRIER_TRUCK_INTERNAL,
                              arguments: [
                                "1",
                                0, // selected data
                                controller.editHeadTruk["ID"],
                                "Cari Jenis Truk",
                                0
                              ]);
                          if (result != null) {
                            controller.editKarierTruk.value = result;
                            controller.editKarierTruckController.text =
                                result["Description"];
                          }
                          controller.checkImage();
                        }
                      },
                      child: _textFormField(
                          title: "InfoPermintaanMuatLabelJenisKarier".tr,
                          hintText: "InfoPermintaanMuatLabelJenisKarier".tr,
                          isSetTitleToHint: true,
                          isEnable: false,
                          suffixIcon: Container(
                              margin: EdgeInsets.only(right: 12),
                              child: Icon(Icons.keyboard_arrow_down_sharp)),
                          textEditingController:
                              controller.editKarierTruckController,
                          validator: (str) {
                            if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                            return null;
                          },
                          marginBottom: 0),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Container(
                    margin: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(Get.context) * 24),
                    alignment: Alignment.center,
                    height: GlobalVariable.ratioWidth(Get.context) * 167,
                    decoration: BoxDecoration(
                        color: controller.linkImage.value.isEmpty
                            ? Color(ListColor.colorLightGrey20)
                            : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 6)),
                        border: Border.all(
                            color: Color(ListColor.colorLightGrey10),
                            width: GlobalVariable.ratioWidth(Get.context) * 1)),
                    child: Obx(
                      () => controller.linkImage.value.isEmpty
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icon_empty_truck.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          39,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          28,
                                ),
                                Container(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            9),
                                CustomText(
                                    "InfoPermintaanMuatLabelTrukWarning".tr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorLightGrey4))
                              ],
                            )
                          : CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.linkImage.value,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6)),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                            ),
                    )),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("Estimasi Berat Max/Dimensi/Volume",
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(ListColor.colorGrey3)),
                    Container(height: (GlobalVariable.ratioWidth(Get.context) * 8) - FontTopPadding.getSize(GlobalVariable.ratioWidth(Get.context) * 14)),
                    Obx(()=>
                      CustomText(controller.kapasitas.value,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only( bottom: GlobalVariable.ratioWidth(Get.context) * 8),
                        padding:
                            EdgeInsets.only(top: FontTopPadding.getSize(12)),
                        child: CustomText("InfoPermintaanMuatLabelJumlahTruk".tr,
                            color: Color(ListColor.colorGrey3),
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _textFormField(
                              title: "InfoPermintaanMuatLabelJumlahTruk".tr,
                              hintText: "InfoPermintaanMuatLabelJumlahTruk".tr,
                              isSetTitleToHint: true,
                              marginBottom: 0,
                              textEditingController:
                                  controller.jumlahTruckController,
                              isNumber: true,
                              customTextInputFormatter: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (str) {
                                if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        12),
                            child: CustomText("Unit",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(ListColor.colorGrey)),
                          ),
                        ]),
                  ],
                ),
              ),
              Container(height: GlobalVariable.ratioWidth(Get.context) * 13),
            ],
          ),
        ),
      ),
    );
  }

  Widget fourthPage() {
    return SingleChildScrollView(
      child: Form(
        key: controller.formFour,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                child: _textFormField(
                    title: "InfoPermintaanMuatLabelDeskripsi".tr,
                    hintText: "",
                    initialValue: controller.deskripsi.value,
                    validator: (str) {
                      if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                      return null;
                    },
                    isMultiLine: true,
                    maxLines: 3,
                    minLines: 3,
                    onChanged: (str) {
                      controller.deskripsi.value = str;
                    },
                    marginBottom: 0),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                child: _textFormField(
                    title: "InfoPermintaanMuatLabelBerat".tr,
                    isSetTitleToHint: true,
                    textEditingController: controller.beratController,
                    validator: (str) {
                      if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                      return null;
                    },
                    isNumber: true,
                    onChanged: (str) {
                      controller.berat.value = str;
                    },
                    suffixIcon: Container(
                        alignment: Alignment.center,
                        width: 10,
                        height: 20,
                        margin: EdgeInsets.all(8),
                        child: CustomText("ton",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorLightGrey4))),
                    marginBottom: 0),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                child: _textFormField(
                    title: "Volume".tr,
                    isSetTitleToHint: true,
                    textEditingController: controller.volumeController,
                    validator: (str) {
                      if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                      return null;
                    },
                    isNumber: true,
                    suffixIcon: Container(
                        alignment: Alignment.center,
                        width: 10,
                        height: 20,
                        margin: EdgeInsets.all(8),
                        child: CustomText("m3", fontWeight: FontWeight.w600)),
                    marginBottom: 0),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                child: _textFormField(
                    title: "Dimensi per koli (pxlxt atau dxp)",
                    textEditingController: controller.dimensiController,
                    isSetTitleToHint: true,
                    validator: (str) {
                      if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                      return null;
                    },
                    marginBottom: 0),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                child: _textFormField(
                    title: "InfoPermintaanMuatLabelJumlah".tr,
                    isSetTitleToHint: true,
                    textEditingController: controller.jumlahKoliController,
                    validator: (str) {
                      if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                      return null;
                    },
                    isNumber: true,
                    suffixIcon: Container(
                        alignment: Alignment.center,
                        width: 10,
                        height: 20,
                        margin: EdgeInsets.all(8),
                        child: CustomText("koli", fontWeight: FontWeight.w600)),
                    marginBottom: 0),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                child: _textFormField(
                    title: "InfoPermintaanMuatLabelCatatanTambahan".tr,
                    hintText: "",
                    initialValue: controller.catatanTambahan.value,
                    validator: (str) {
                      if (str.isEmpty) return "*${"InfoPermintaanMuatLabelFieldHarusDiisi".tr}";
                      return null;
                    },
                    isMultiLine: true,
                    maxLines: 4,
                    minLines: 4,
                    onChanged: (str) {
                      controller.catatanTambahan.value = str;
                    },
                    marginBottom: 0),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => CustomText(
                          controller.jumlahMitra.value == 0
                              ? "InfoPermintaanMuatLabelTransporterMitra".tr
                              : "InfoPermintaanMuatLabelDiumumkan".tr,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(ListColor.colorGrey3)),
                    ),
                    Obx(
                      () => controller.diumumkanKepadaTextSpan.length == 0
                          ? SizedBox.shrink()
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8),
                                Obx(
                                  () => Text.rich(
                                    TextSpan(
                                        children: controller
                                            .diumumkanKepadaTextSpan
                                            .map((data) => data as InlineSpan)
                                            .toList()),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(height: 1.2),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 8),
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(ListColor.color4),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        18)),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 11,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 4),
                            child: Obx(() => CustomText(
                                controller.jumlahMitra.value == 0
                                    ? "InfoPermintaanMuatLabelPilih".tr
                                    : "InfoPermintaanMuatLabelUbah".tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                          ),
                          onTap: () async {
                            FocusScope.of(Get.context).unfocus();
                            FocusManager.instance.primaryFocus.unfocus();
                            var result = await GetToPage.toNamed<
                                    ListUserInfoPermintaanMuatController>(
                                Routes.LIST_USER_INFO_PERMINTAAN_MUAT,
                                arguments: [
                                  {
                                    "semua":
                                        controller.selectedJenisMitra.value,
                                    "group": controller.selectedGroup.value,
                                    "transporter":
                                        controller.selectedTransporter.value,
                                    "invited": controller.listInvited.value
                                  }
                                ]);
                            if (result != null) {
                              controller.selectedJenisMitra.value =
                                  result["semua"];
                              controller.selectedGroup.value = result["group"];
                              controller.selectedTransporter.value =
                                  result["transporter"];
                              controller.listInvited.value = result["invited"];
                              controller.jumlahMitra.value =
                                  (controller.selectedJenisMitra.keys.length) +
                                      controller.selectedGroup.length +
                                      controller.selectedTransporter.length +
                                      controller.listInvited.length;
                              controller.setDiumumkanKepada();
                            }
                          },
                        ))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        "InfoPermintaanMuatLabelStatus".tr,
                        color: Color(ListColor.colorGrey3),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      Container(
                          height: GlobalVariable.ratioWidth(Get.context) * 8),
                      CustomText("InfoPermintaanMuatLabelAktif".tr,
                          color: Color(ListColor.colorGreen6),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ],
                  )),
              Container(height: GlobalVariable.ratioWidth(Get.context) * 12)
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFormField(
      {Widget prefixIcon,
      Widget suffixIcon,
      bool isEnable = true,
      bool isPhoneNumber = false,
      bool isNumber = false,
      bool isMultiLine = false,
      TextEditingController textEditingController,
      String initialValue,
      String title,
      Function validator,
      String hintText = "",
      bool isSetTitleToHint = false,
      double marginBottom = 10,
      int minLines = 1,
      int maxLines = 1,
      void Function(String) onChanged,
      List<TextInputFormatter> customTextInputFormatter}) {
    return TextFormFieldWidget(
      isNumber: isNumber,
      errorColor: Color(ListColor.colorRed),
      isSetTitleToHint: isSetTitleToHint,
      onChanged: onChanged,
      isMultiLine: isMultiLine,
      textSize: 14,
      titleTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(ListColor.colorGrey3)),
      hintText: hintText,
      title: title,
      validator: validator,
      initialValue: initialValue,
      customContentPaddingHorizontal:
          GlobalVariable.ratioWidth(Get.context) * 12,
      customContentPaddingVertical:
          GlobalVariable.ratioWidth(Get.context) * 8,
      textEditingController: textEditingController,
      isPhoneNumber: isPhoneNumber,
      isShowCodePhoneNumber: false,
      isEnable: isEnable,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      fillColor: Colors.white,
      hintTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(ListColor.colorLightGrey2)),
          // color: Color(ListColor.colorLightGrey4)),
      focusedBorderColor: Color(ListColor.color4),
      enableBorderColor: Color(ListColor.colorLightGrey19),
      disableBorderColor: Color(ListColor.colorLightGrey19),
      borderColor: Color(ListColor.colorLightGrey19),
      contentTextStyle: TextStyle(fontWeight: FontWeight.w600),
      marginBottom: marginBottom,
      minLines: minLines,
      maxLines: maxLines,
      customTextInputFormatter: customTextInputFormatter
    );
  }
}
