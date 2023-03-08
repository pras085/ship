import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ExampleDetailLaporkanController extends GetxController {
  TextEditingController textC = TextEditingController();
  RxBool isCheck = false.obs;

  String selectedValue;
  var valueObs = ''.obs;
  var listReport = [
    'Pelanggaran HAKI & Produk MLM',
    'Barang Hasil Kejahatan',
    'Barang Ilegal dan Berbahaya',
    'Barang Palsu',
    'Kondisi Produk Rusak / Tidak Sesuai',
    'Stok Produk Kosong',
    'Iklan Mengandung Spam',
    'Kategori Produk Sesuai',
    'Lainnya',
  ];

  showUpload() {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 25),
          topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 25),
        ),
      ),
      backgroundColor: Colors.white,
      context: Get.context,
      builder: (context) {
        FocusManager.instance.primaryFocus.unfocus();
        FocusScope.of(context).unfocus();
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 8,
                bottom: GlobalVariable.ratioWidth(Get.context) * 18,
              ),
              child: Container(
                width: GlobalVariable.ratioWidth(Get.context) * 94,
                height: GlobalVariable.ratioWidth(Get.context) * 5,
                decoration: BoxDecoration(
                  color: Color(ListColor.colorLightGrey10),
                  borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 90)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: GlobalVariable.ratioWidth(context) * 64,
                        width: GlobalVariable.ratioWidth(context) * 64,
                        decoration: BoxDecoration(
                          color: Color(ListColor.colorBlue),
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                            ),
                            onTap: () {
                              Get.back();
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 20),
                              child: SvgPicture.asset(
                                GlobalVariable.urlImageTemplateBuyer + "ic_camera_template.svg",
                                color: Colors.white,
                                // width: GlobalVariable.ratioWidth(Get.context) * 24,
                                // height: GlobalVariable.ratioWidth(Get.context) * 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
                      CustomText(
                        "Ambil Foto",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 84),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: GlobalVariable.ratioWidth(context) * 64,
                        width: GlobalVariable.ratioWidth(context) * 64,
                        decoration: BoxDecoration(
                          color: Color(ListColor.colorBlue),
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                            ),
                            onTap: () {
                              Get.back();
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 20),
                              child: SvgPicture.asset(
                                GlobalVariable.urlImageTemplateBuyer + "ic_upload_template.svg",
                                color: Colors.white,
                                // width: GlobalVariable.ratioWidth(Get.context) * 24,
                                // height: GlobalVariable.ratioWidth(Get.context) * 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
                      CustomText(
                        "Upload File",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

}
