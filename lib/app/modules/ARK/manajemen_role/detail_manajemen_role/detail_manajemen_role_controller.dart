import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'dart:math' as math;

class DetailManajemenRoleController extends GetxController {
  var listHakAkses = [].obs;
  String nama = '';
  String menu = '';
  String deskripsi = '';
  var isLoading = true.obs;
  var validasiSimpan = true;
  var idrole;
  String bullet = '\u2022 ';

  var cekTambah = false;

  @override
  void onInit() async {
    cekTambah = await SharedPreferencesHelper.getHakAkses("Tambah Role");
    idrole = Get.arguments[0];
    await getData();
  }

  void getData() async {
    String iduser = await SharedPreferencesHelper.getUserID();
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDetailRole(iduser, idrole);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'][0];

      nama = data['name'];
      deskripsi = data['deskripsi'];
      menu = data['menu'];
      var aplikasi = "";
      if (data['role_profile'].toString() == '2') {
        aplikasi = "Shipper";
      } else {
        aplikasi = "Transporter";
      }

      await getListHakAkses(data['Menu']);
      isLoading.value = false;
    }
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future getListHakAkses(data) async {
    listHakAkses.clear();
    for (var x = 0; x < data.length; x++) {
      var listHakAksesLvl2 = [];
      for (var y = 0; y < data[x]['Hak_Akses'].length; y++) {
        var listHakAksesLvl3 = [];
        for (var z = 0; z < data[x]['Hak_Akses'][y]['child'].length; z++) {
          var listHakAksesLvl4 = [];
          for (var a1 = 0;
              a1 < data[x]['Hak_Akses'][y]['child'][z]['child_terakhir'].length;
              a1++) {
            listHakAksesLvl4.add({
              'ID': data[x]['Hak_Akses'][y]['child'][z]['child_terakhir'][a1]
                  ['ID'],
              'title_menu_id': data[x]['Hak_Akses'][y]['child'][z]
                  ['child_terakhir'][a1]['Hak_Akses_Child_terakhir'],
              'subdata': [],
              'tutup': false,
            });
          }

          listHakAksesLvl3.add({
            'ID': data[x]['Hak_Akses'][y]['child'][z]['ID'],
            'title_menu_id': data[x]['Hak_Akses'][y]['child'][z]
                ['Hak_Akses_Child'],
            'subdata': listHakAksesLvl4,
            'tutup': false,
          });
        }

        listHakAksesLvl2.add({
          'ID': data[x]['Hak_Akses'][y]['ID'],
          'title_menu_id': data[x]['Hak_Akses'][y]['Hak_Akses'],
          'subdata': listHakAksesLvl3,
          'tutup': false,
        });
      }

      listHakAkses.add({
        'ID': data[x]['ID'],
        'title_menu_id': data[x]['SuperMenu'],
        'subdata': listHakAksesLvl2,
        'tutup': false,
      });
      listHakAkses.refresh();
    }
  }

  //Membuat Garis Pemisah
  Widget lineDividerWidget() {
    return Expanded(
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 0.5,
        color: Color(ListColor.colorLightGrey10),
        height: 0,
      ),
    );
  }

  Widget expandedWidget(int level, data, int index) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft:
                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
              topRight:
                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
              bottomLeft:
                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
              bottomRight:
                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
            ),
            // color: Color(ListColor.colorHeaderListTender),
            color: GlobalVariable.cardHeaderManajemenColor),
        padding: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 1,
          right: GlobalVariable.ratioWidth(Get.context) * 1,
          bottom: GlobalVariable.ratioWidth(Get.context) * 1,
        ),
        margin: EdgeInsets.only(
          bottom: (index != (listHakAkses.length - 1))
              ? GlobalVariable.ratioWidth(Get.context) * 16
              : 0,
        ),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  if (data['tutup']) {
                    data['tutup'] = false;
                  } else {
                    data['tutup'] = true;
                  }

                  listHakAkses.refresh();
                  print(data['tutup']);
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          topRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          bottomLeft: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          bottomRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                        ),
                        color: Colors.transparent),
                    padding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                        vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4),
                                child: CustomText(
                                  data['title_menu_id'],
                                  maxLines: 2,
                                  wrapSpace: true,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ))),
                        Container(
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            child: Transform.rotate(
                                angle: (!data['tutup']
                                    ? (-math.pi / 2)
                                    : (math.pi / 2)),
                                child: SvgPicture.asset(
                                  'assets/ic_arrow.svg',
                                  color: Colors.black,
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                ))),
                      ],
                    ))),
            !data['tutup'] && data['subdata'].length != 0
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          bottomRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                        )),
                    // margin: EdgeInsets.only(
                    //     bottom: GlobalVariable.ratioWidth(Get.context) * 10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data['subdata'].length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return detailWidget(
                              (level + 1),
                              data['subdata'][index],
                              index,
                              (listHakAkses.length - 1));
                        }))
                : SizedBox(),
          ],
        ));
  }

  Widget detailWidget(int level, data, int index, int lastindex) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        index != 0 || level > 2
            ? Row(
                children: [
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 14),
                  SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) *
                          27 *
                          ((level - 3) < 0 ? 0 : (level - 3))), //(level - 3)
                  lineDividerWidget(),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 14)
                ],
              )
            : SizedBox(),
        GestureDetector(
            onTap: () {},
            child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    level > 2
                        ? SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) *
                                27 *
                                (level - 2)) //level - 2
                        : SizedBox(),
                    Container(
                        margin: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 2),
                        child: CustomText(
                          bullet,
                          fontSize: 12,
                        )),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(
                                top:
                                    GlobalVariable.ratioWidth(Get.context) * 2),
                            child: CustomText(
                              data['title_menu_id'],
                              maxLines: 2,
                              wrapSpace: true,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ))),
                  ],
                ))),
        Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data['subdata'].length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return detailWidget((level + 1), data['subdata'][index],
                      index, (data['subdata'].length - 1));
                })),
      ],
    );
  }
}
