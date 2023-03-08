import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

import 'create_manajemen_user_controller.dart';

class CreateManajemenUserView extends GetView<CreateManajemenUserController> {
  // double _heightAppBar = AppBar().preferredSize.height + 30;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
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
                          onWillPop();
                        },
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + "ic_back_button.svg",
                            color: GlobalVariable.tabDetailAcessoriesMainColor,
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24))),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                Container(
                  child: CustomText(
                    controller.isEdit.value
                        ? "ManajemenUserTambahUserEditUser".tr
                        : "ManajemenUserTambahUserTambahUser"
                            .tr, //Detail Pemenang Tender
                    fontWeight: FontWeight.w700,
                    fontSize: 16.00,
                    // color: Color(ListColor.colorWhite),
                    color: GlobalVariable.tabDetailAcessoriesMainColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 23,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 23,
              GlobalVariable.ratioWidth(Get.context) * 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10),
                  topRight: Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 4,
                ),
              ]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor:
                        (controller.isEdit.value && !controller.isChanged.value)
                            ? Color(ListColor.colorLightGrey2)
                            : Color(ListColor.color4),
                    side: BorderSide(
                        width: 1,
                        color: (controller.isEdit.value &&
                                !controller.isChanged.value)
                            ? Color(ListColor.colorLightGrey2)
                            : Color(ListColor.color4)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 100)),
                    )),
                onPressed: () {
                  if (controller.isEdit.value) {
                    if (controller.isChanged.value) {
                      controller.onSubmit();
                    }
                  } else {
                    controller.onSubmit();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 22,
                      vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                  child: Stack(alignment: Alignment.center, children: [
                    CustomText(
                        controller.isEdit.value
                            ? "ManajemenUserTambahUserSimpan".tr
                            : "ManajemenUserTambahUserTambahUser".tr,
                        fontWeight: FontWeight.w600,
                        color: (controller.isEdit.value &&
                                !controller.isChanged.value)
                            ? Color(ListColor.colorLightGrey4)
                            : Colors.white),
                  ]),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //NAMA LENGKAP
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
                  CustomText(
                      "ManajemenUserTambahUserNamaLengkap".tr, // Nama lengkap
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(ListColor.colorGrey3)),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
                  CustomTextFormField(
                    context: Get.context,
                    newContentPadding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                      //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                    ),
                    textSize: 14,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      // color: Color(ListColor.colorLightGrey4),
                    ),
                    newInputDecoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefix: SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 17),
                      suffix: SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 17),
                      isDense: true,
                      isCollapsed: true,
                      hintText: "ManajemenUserTambahUserMasukkanNamaLengkap"
                          .tr, //Masukkan nama lengkap
                      hintStyle: TextStyle(
                        color: Color(ListColor.colorGrey3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    controller: controller.namaController,
                    onChanged: (value) {
                      controller.isChanged.value = true;
                      controller.checkChange();
                    },
                    validator: (value) {
                      if (controller.validasiNama.value != "") {
                        return controller.validasiNama.value;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
                  //EMAIL
                  CustomText("ManajemenUserTambahUserEmail".tr, // Email
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(ListColor.colorGrey3)),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
                  CustomTextFormField(
                    context: Get.context,
                    newContentPadding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                      //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                    ),
                    textSize: 14,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      // color: Color(ListColor.colorLightGrey4),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      controller.isChanged.value = true;
                      controller.checkChange();
                    },
                    newInputDecoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefix: SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 17),
                      suffix: SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 17),
                      isDense: true,
                      isCollapsed: true,
                      hintText: "ManajemenUserTambahUserMasukkanAlamatEmail"
                          .tr, //Masukkan Alamat Email
                      hintStyle: TextStyle(
                        color: Color(ListColor.colorGrey3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    controller: controller.emailController,
                    validator: (value) {
                      if (controller.validasiEmail.value != "") {
                        return controller.validasiEmail.value;
                      }
                      return null;
                    },
                  ),
                  //WHATSAPP
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
                  CustomText("ManajemenUserTambahUserNoWhatsapp".tr, // Judul
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(ListColor.colorGrey3)),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
                  CustomTextFormField(
                    context: Get.context,
                    newContentPadding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                      //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                    ),
                    textSize: 14,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      // color: Color(ListColor.colorLightGrey4),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                      LengthLimitingTextInputFormatter(14),
                    ],
                    onChanged: (value) {
                      controller.isChanged.value = true;
                      controller.checkChange();
                    },
                    newInputDecoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefix: SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 17),
                      suffix: SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 17),
                      isDense: true,
                      isCollapsed: true,
                      hintText: "ManajemenUserTambahUserMasukkanNoWhatsapp"
                          .tr, //Judul Pra Tender
                      hintStyle: TextStyle(
                        color: Color(ListColor.colorGrey3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    controller: controller.phoneController,
                    validator: (value) {
                      if (controller.validasiPhone.value != "") {
                        return controller
                            .validasiPhone.value; // Judul Harus Diisi
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    Get.back();
  }
}
