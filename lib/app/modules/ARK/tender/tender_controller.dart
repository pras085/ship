import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/group_mitra_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/info_pra_tender/info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/pemenang_tender/pemenang_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/proses_tender/proses_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class TenderController extends GetxController {
  //List untuk menyimpan Menu Tender dengan tipe data Widget
  var menuTender = <Widget>[].obs;
  var showFirstTime = true.obs;
  var onLoading = true.obs;

  var cekPraTender = false;
  var cekProsesTender = false;
  var cekPemenangTender = false;

  @override
  void onInit() async {
    cekPraTender =
        await SharedPreferencesHelper.getHakAkses("Lihat Info Pra Tender");
    cekProsesTender =
        await SharedPreferencesHelper.getHakAkses("Lihat Proses Tender");
    cekPemenangTender =
        await SharedPreferencesHelper.getHakAkses("Lihat Pemenang Tender");

    menuTender.addAll([
      listTenderWidget(
          'info_pra_tender',
          'TenderMenuIndexLabelJudulMenuInfoPraTender'.tr, //'Info Pra Tender',
          16,
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          () async {
        cekPraTender = await SharedPreferencesHelper.getHakAkses(
            "Lihat Info Pra Tender",
            denganLoading: true);
        if (SharedPreferencesHelper.cekAkses(cekPraTender)) {
          GetToPage.toNamed<InfoPraTenderController>(Routes.INFO_PRA_TENDER);
        }
      }, cekPraTender),
      lineDividerWidget(),
      listTenderWidget(
          'proses_tender',
          'TenderMenuIndexLabelJudulMenuProsesTender'.tr, //'Proses Tender',
          5,
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          () async {
        cekProsesTender = await SharedPreferencesHelper.getHakAkses(
            "Lihat Proses Tender",
            denganLoading: true);
        if (SharedPreferencesHelper.cekAkses(cekProsesTender)) {
          GetToPage.toNamed<ProsesTenderController>(Routes.PROSES_TENDER);
        }
      }, cekProsesTender),
      lineDividerWidget(),
      listTenderWidget(
          'pemenang_tender',
          'TenderMenuIndexLabelJudulMenuPemenangTender'.tr, //'Pemenang Tender',
          5,
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          () async {
        cekPemenangTender = await SharedPreferencesHelper.getHakAkses(
            "Lihat Pemenang Tender",
            denganLoading: true);
        if (SharedPreferencesHelper.cekAkses(cekPemenangTender)) {
          GetToPage.toNamed<PemenangTenderController>(Routes.PEMENANG_TENDER);
        }
      }, cekPemenangTender),
      lineDividerWidget(),
      listTenderWidget(
          'amandemen_tender',
          'TenderMenuIndexLabelJudulMenuAmandemenTender'
              .tr, //'Amandemen Tender',
          0,
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          () {},
          true),
      lineDividerWidget(),
      listTenderWidget(
          'laporan_dan_eksekusi_tender',
          'TenderMenuIndexLabelJudulMenuLaporanDanEksekusiTender'
              .tr, //'Laporan dan Eksekusi Tender',
          0,
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          () {},
          true),
      lineDividerWidget(),
      listTenderWidget(
          'order_entry',
          'TenderMenuIndexLabelJudulMenuOrderEntry'.tr, //'Order Entry',
          0,
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          () {
        // GetToPage.toNamed<OrderEntryController>(Routes.ORDER_ENTRY);
      }, true),
    ]);
    //await SharedPreferencesHelper.setTenderPertamaKali(true);
    showFirstTime.value = await SharedPreferencesHelper.getTenderPertamaKali();
    onLoading.value = false;
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

/* Membuat tampilan menu tender
  parameter String icon = namaicon yang ditampilkan
  parameter int count = jumlah data yang akan ditampilkan
  parameter String title = header data yang ditampilkan
  parameter String subtitle = keterangan data yang ditampilkan
  parameter Class route = ketika menu ditekan, pindah ke page mana
*/
  Widget listTenderWidget(String icon, String title, int count, String subtitle,
      Function onTap, bool akses) {
    return Container(
        width: MediaQuery.of(Get.context).size.width,
        margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 16,
        ),
        child: GestureDetector(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: GlobalVariable.ratioWidth(Get.context) * 24,
                ),
                child: SvgPicture.asset(
                  GlobalVariable.imagePath + '${icon}.svg',
                  color: akses
                      ? Color(ListColor.color4)
                      : Color(ListColor.colorLabelDisable),
                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: title.tr,
                            style: TextStyle(
                              fontFamily: "AvenirNext",
                              color: akses
                                  ? Color(ListColor.colorBlack)
                                  : Color(ListColor.colorLabelDisable),
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [])),
                    Container(
                        margin: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 6),
                        child: CustomText(subtitle.tr,
                            fontSize: 12,
                            textAlign: TextAlign.justify,
                            color: Color(ListColor.colorGrey3))),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 4,
                ),
                child: SvgPicture.asset(
                  GlobalVariable.imagePath + 'ic_arrow.svg',
                  color: akses
                      ? Color(ListColor.colorDarkGrey3)
                      : Color(ListColor.colorLabelDisable),
                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                ),
              ),
            ],
          ),
          onTap: onTap,
        ));
  }

//Membuat Garis Pemisah
  Widget lineDividerWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * 16,
        0,
        GlobalVariable.ratioWidth(Get.context) * 16,
        0,
      ),
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 1,
        color: Color(ListColor.colorLightGrey10),
        height: 0,
      ),
    );
  }

//Menampilkan Box Kuning, ketika pertama kali menggunakan aplikasi
  Widget firstTimeYellowBox() {
    String bullet = '\u2022 ';
    return Container(
        margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 16,
        ),
        decoration: BoxDecoration(
          color: Color(ListColor.colorYellowTile),
          borderRadius:
              BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 18,
            GlobalVariable.ratioWidth(Get.context) * 8,
            GlobalVariable.ratioWidth(Get.context) * 5,
            GlobalVariable.ratioWidth(Get.context) * 14),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 0,
                  GlobalVariable.ratioWidth(Get.context) * 18,
                  GlobalVariable.ratioWidth(Get.context) * 13,
                  GlobalVariable.ratioWidth(Get.context) * 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    'TenderMenuIndexLabelPopUpTeksJudul'.tr,
                    //'Gunakan Fitur Tender di Big Fleets untuk mendapatkan manfaat strategis antara lain:'
                    //    .tr,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.8,
                    textAlign: TextAlign.justify,
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                        padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 6,
                          right: GlobalVariable.ratioWidth(Get.context) * 5,
                        ),
                        child: CustomText(
                          bullet,
                          fontSize: 14,
                          height: 1.8,
                        )),
                    Flexible(
                        child: CustomText(
                      'TenderMenuIndexLabelPopUpTeksPoin1'.tr,
                      //'Untuk mensinkronkan antara perencanaan dengan eksekusi di lapangan dalam hal distribusi produk sehingga dapat mengurangi biaya penyimpanan terlebih untuk perusahaan yang memiliki lahan terbatas.'
                      //    .tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.8,
                      textAlign: TextAlign.justify,
                    )),
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                        padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 6,
                          right: GlobalVariable.ratioWidth(Get.context) * 5,
                        ),
                        child: CustomText(
                          bullet,
                          fontSize: 14,
                          height: 1.8,
                        )),
                    Flexible(
                        child: CustomText(
                      'TenderMenuIndexLabelPopUpTeksPoin2'.tr,
                      //'Mendapatkan Penawaran terbaik dari Transporter-Transporter besar yang ada di komunitas Big Fleets.'
                      //    .tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.8,
                      textAlign: TextAlign.justify,
                    )),
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                        padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 6,
                          right: GlobalVariable.ratioWidth(Get.context) * 5,
                        ),
                        child: CustomText(
                          bullet,
                          fontSize: 14,
                          height: 1.8,
                        )),
                    Flexible(
                        child: CustomText(
                      'TenderMenuIndexLabelPopUpTeksPoin3'.tr,
                      //'Meningkatkan transparansi dan kontrol terhadap biaya distribusi perusahaan.'
                      //    .tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.8,
                      textAlign: TextAlign.justify,
                    )),
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                        padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 6,
                          right: GlobalVariable.ratioWidth(Get.context) * 5,
                        ),
                        child: CustomText(
                          bullet,
                          fontSize: 14,
                          height: 1.8,
                        )),
                    Flexible(
                        child: CustomText(
                      'TenderMenuIndexLabelPopUpTeksPoin4'.tr,
                      //'Menjadi lebih kompetitif di pasar.'.tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.8,
                      textAlign: TextAlign.justify,
                    )),
                  ]),
                ],
              ),
            ),
            Positioned(
                child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                child: SvgPicture.asset(
                    GlobalVariable.imagePath + 'ic_close.svg',
                    width: GlobalVariable.ratioWidth(Get.context) * 14,
                    height: GlobalVariable.ratioWidth(Get.context) * 14,
                    color: Colors.black),
                onTap: () async {
                  await SharedPreferencesHelper.setTenderPertamaKali(false);
                  showFirstTime.value = false;
                },
              ),
            ))
          ],
        ));
  }
}
