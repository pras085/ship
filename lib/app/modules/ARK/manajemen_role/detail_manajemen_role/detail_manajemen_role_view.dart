import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_filereader/flutter_filereader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/edit_manajemen_role/edit_manajemen_role_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/button_bottom_demo.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:validators/validators.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:open_file/open_file.dart';

import 'detail_manajemen_role_controller.dart';

class DetailManajemenRoleView extends GetView<DetailManajemenRoleController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(ListColor.colorBackgroundManajemen),
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
              child: Container(
                alignment: Alignment.center,
                height: GlobalVariable.ratioWidth(Get.context) * 56,
                padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 16),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(GlobalVariable.urlImageNavbar),
                        fit: BoxFit.fill),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                    color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(
                                GlobalVariable.imagePath + "ic_back_button.svg",
                                color:
                                    GlobalVariable.tabDetailAcessoriesMainColor,
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    24))),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                    Container(
                      child: CustomText(
                        "ManajemenRoleDetailDetailRole".tr, //Detail Role
                        fontWeight: FontWeight.w700,
                        fontSize: 16.00,
                        // color: Color(ListColor.colorWhite),
                        color: GlobalVariable.tabDetailAcessoriesMainColor,
                      ),
                    ),
                    Expanded(
                      child: CustomText(''),
                    ),
                    Obx(() => !controller.isLoading.value
                        ? Row(
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    controller.cekTambah =
                                        await SharedPreferencesHelper
                                            .getHakAkses("Tambah Role",denganLoading:true);
                                    if (SharedPreferencesHelper.cekAkses(
                                        controller.cekTambah)) {
                                      var data = await GetToPage.toNamed<
                                              EditManajemenRoleController>(
                                          Routes.EDIT_MANAJEMEN_ROLE,
                                          arguments: [
                                            controller.idrole,
                                            'UBAH_DETAIL'
                                          ]);

                                      if (data != null) {
                                        Get.back(result: true);
                                      }
                                    }
                                  },
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath +
                                          "ic_edit_white.svg",
                                      color: controller.cekTambah
                                          ? GlobalVariable
                                              .tabDetailAcessoriesMainColor
                                          : Color(ListColor.colorAksesDisable),
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24)),
                            ],
                          )
                        : SizedBox()),
                  ],
                ),
              ),
            ),
            body: Obx(() => !controller.isLoading.value
                ? SafeArea(
                    child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16,
                        ),
                        child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24),
                              CustomText("ManajemenRoleDetailRole".tr, // Role
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color(ListColor.colorGrey3)),
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              CustomText(
                                controller.nama,
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24),
                              CustomText(
                                  "ManajemenRoleDetailDeskripsiRole"
                                      .tr, // Deskripsi Role
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color(ListColor.colorGrey3)),
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              CustomText(
                                controller.deskripsi,
                                color: Colors.black,
                                fontSize: 14,
                                maxLines: 4,
                                height: 1.2,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24),
                              CustomText("ManajemenRoleDetailMenu".tr, // Menu
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color(ListColor.colorGrey3)),
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              CustomText(
                                controller.menu,
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            14,
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            14),
                                decoration: BoxDecoration(
                                    color: Color(ListColor
                                        .colorWhiteManajemen), // Color(ListColor.colorWhiteManajemen)
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10)),
                                child: _listHakAksesTile(),
                              ),
                            ]))))
                : Center(child: CircularProgressIndicator()))));
  }

  Widget _listHakAksesTile() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.listHakAkses.length,
      itemBuilder: (content, index) {
        return controller.expandedWidget(
            1, controller.listHakAkses[index], index);
      },
    );
  }
}
