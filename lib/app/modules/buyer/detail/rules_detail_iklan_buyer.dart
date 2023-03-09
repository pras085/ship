import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/barang_lainnya/barang_lainnya_view.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/detail/component/testimoni_portofolio_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_card_all_list_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_card_promo_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_card_service.dart';
import 'package:muatmuat/app/template/detail/detail_card_service_all_list_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_card_service_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_card_with_desc.dart';
import 'package:muatmuat/app/template/detail/detail_seller_profile_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_title_compro_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_title_compro_detail_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_title_product_buyer.dart';
import 'package:muatmuat/app/template/media_preview/media_preview_buyer.dart';
import 'package:muatmuat/app/template/dialog/dialog_buyer.dart';
import 'package:muatmuat/app/template/widgets/banner/banner_ads.dart';
import 'package:muatmuat/app/template/widgets/carousel_image/carousel_image_buyer.dart';
import 'package:muatmuat/app/template/widgets/detail_expansion_buyer/detail_expansion_buyer.dart';
import 'package:muatmuat/app/template/widgets/detail_expansion_buyer/file_detail_expansion_buyer.dart';
import 'package:muatmuat/app/template/widgets/detail_expansion_buyer/spec_detail_expansion_buyer.dart';
import 'package:muatmuat/app/template/widgets/detail_expansion_buyer/text_detail_expansion_buyer.dart';
import 'package:muatmuat/app/template/widgets/katalog_produk_detail/katalog_produk_detail_buyer.dart';
import 'package:muatmuat/app/template/widgets/location/marker_location_buyer.dart';
import 'package:muatmuat/app/utils/download_utils.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import '../../../../global_variable.dart';
import '../rules_buyer.dart';

class RulesDetailIklanBuyer {

  // define the widget that show on Detail
  static Widget getDetailWidgetBySubKategoriId({
    @required BuildContext context,
    @required String layananId,
    @required String kategoriId,
    @required String subKategoriId,
    @required String comproId,
    @required Map data,
  }) {
    // Detail
    final detail = RulesBuyer.getDetailDataProductBySubKategoriId(subKategoriId, data);
    final detailCompro = RulesBuyer.getDetailDataComproBySubKategoriId(subKategoriId, data);
    // GENERAL COMPRO
    if (
      subKategoriId == "23" // Dealer & Karoseri | Dealer
      || subKategoriId == "25" // Dealer & Karoseri | Perusahaan Karoseri
      || subKategoriId == "28" // Dealer & Karoseri | Perusahaan Lainnya
      // Pras >
      || subKategoriId == "48" // Transportation Store | Perusahaan Lainnya
      || subKategoriId == "18" // Property & Warehouse | Jasa Pergudangan
      || subKategoriId == "19" // Property & Warehouse | Pusat Logsitik Berikat
      || subKategoriId == "22" // Property & Warehouse | Perusahaan Lainnya
      || subKategoriId == "40" // Transportasi Intermoda | Perusahaan Lainnya
      || subKategoriId == "14" // Repair & Maintenance | Perusahaan Lainnya
      || subKategoriId == "53" // Human Capital | Perusahaan Lainnya
      // Pras <

      // Andy <
      || subKategoriId == '46' // Transportation Store | Toko Suku Cadang
      || subKategoriId == '17' // Property & Warehouse | Gudang Barang Cair
      || subKategoriId == '32' // Transportasi Intermoda | Sea Freight
      || subKategoriId == '12' // Repair & Maintenance | Teknisi
      || subKategoriId == '57' // Human Capital | HR Consultant and Training
      || subKategoriId == '49' // Places & Promo | Places
      // Andy >

      // Khabib < 
      // Khabib >

      // Octa <
      || subKategoriId == "29" // Transportasi Intermoda | Road Transportation
      || subKategoriId == "30" // Transportasi Intermoda | Air Freight
      || subKategoriId == "31" // Transportasi Intermoda | Rail Freight
      // Octa >

      // Refo <
      || subKategoriId == '33' // Transportasi Intermoda | Freight Forwarding
      || subKategoriId == '34' // Transportasi Intermoda | 3 - 5 Company
      || subKategoriId == '11' // Repair & Maintenance | Bengkel
      // Refo >
    ) {
      List<String> image = [] ;
      if(data['Foto'] is List && (data['Foto'] as List).length > 0) {
        for (var o in List.from(data['Foto'])) {
          if (o is Map) {
            if (o['Foto_image'] is List) {
              for (var ob in o['Foto_image']) {
                image.add("$ob");
              }
            } else if (o['Foto_image'] is String) {
              image.add("${o['Foto_image']}");
            }
          } else if (o is String) {
            image.add("$o");
          }
        }
      }
      // Video
      if(data['Video'] is List && (data['Video'] as List).length > 0) {
        for (var o in List.from(data['Video'])) {
          if (o is Map) {
            if (o['Video_image'] is List) {
              for (var ob in o['Video_image']) {
                image.add("$ob");
              }
            } else if (o['Video_image'] is String) {
              image.add("${o['Video_image']}");
            }
          } else if (o is String) {
            image.add("$o");
          }
        }
      }
      // Andy2 <
      // Andy2 >

      // Khabib2 < 
      // Khabib2 >

      // Octa2 <
      // Octa2 >

      // Pras2 <
      else if(data['Gallery'] is List && (data['Gallery'] as List).length > 0 ) {
        for (var o in List.from(data['Gallery'])) {
          if (o is Map) {
            if (o['Gallery_image'] is List) {
              for (var ob in o['Gallery_image']) {
                image.add("$ob");
              }
            } else if (o['Gallery_image'] is String) {
              image.add("${o['Gallery_image']}");
            }
          } else if (o is String) {
            image.add("$o");
          }
        }
      }
      // Pras2 >

      // Refo2 <
      // Refo2 >

      List<Widget> list = [];

      if (
        data['JenisKaroseri'] != null &&
        data['JenisKaroseri'] != '' && 
        subKategoriId == "25"  // Dealer & Karoseri | Perusahaan Karoseri
      )
        list.add(_contentDetailPopup(context: context, title: "Jenis Karoseri yang Dilayani", content: data['JenisKaroseri']));
      if (
        data['LayananPerusahaan'] != null &&  
        data['LayananPerusahaan'] != '' && 
        (
          subKategoriId == "28" // Dealer & Karoseri | Perusahaan Lainnya
          || subKategoriId == "18" // Property & Warehouse | Jasa Pergudangan
          || subKategoriId == "22" // Property & Warehouse | Perusahaan Lainnya
          || subKategoriId == "40" // Transportasi Intermoda | Perusahaan Lainnya
          || subKategoriId == "14" // Repair & Maintenance  | Perusahaan Lainnya
          || subKategoriId == "53" // Human Capital  | Perusahaan Lainnya
        )
      )
        list.add(_contentDetailPopup(context: context, title: "Layanan Perusahaan", content: data['LayananPerusahaan']));
      if (
        data['Kelebihan'] != null && 
        data['Kelebihan'] != '' && 
        (
          subKategoriId != "28" // Dealer & Karoseri | Perusahaan Lainnya
          || subKategoriId == "18" // Property & Warehouse | Jasa Pergudangan
          || subKategoriId == "49" // Places & Promo | Places
        )
      )
        list.add(_contentDetailPopup(context: context, title: "Kelebihan", content: data['Kelebihan']));
      if (
        data['Layanan'] != null && 
        data['Layanan'] != '' && 
        (
          subKategoriId == "18" // Property & Warehouse | Jasa Pergudangan
          || subKategoriId == "19" // Property & Warehouse | PLB
        )
      )
        list.add(_contentDetailPopup(context: context, title: "Layanan", content: data['Layanan']));
      if (
        data['MenanganiSpecialHandling'] != null && 
        data['MenanganiSpecialHandling'] != '' && 
        (
          subKategoriId == "18" // Property & Warehouse | Jasa Pergudangan
        )
      )
        list.add(_contentDetailPopup(context: context, title: "Mampu Menangani Barang", content: data['MenanganiSpecialHandling']));
      if (
        data['MampuMenanganiBarang'] != null && 
        data['MampuMenanganiBarang'] != '' && 
        (
          subKategoriId == "19" // Property & Warehouse | PLB
        )
      )
        list.add(_contentDetailPopup(context: context, title: "Mampu Menangani Barang", content: data['MampuMenanganiBarang']));
      if (
        data['KotaLayanan'] != null && 
        data['KotaLayanan'] != '' && 
        (
          subKategoriId == "18" // Property & Warehouse | Jasa Pergudangan
          || subKategoriId == "19" // Property & Warehouse | PLB
        )
      )
        list.add(_contentDetailPopup(context: context, title: "Kota Layanan", content: data['KotaLayanan']));

      if (subKategoriId == "17") // Property & Warehouse | Gudang Barang Cair
      {
        list.clear();
        if (data['DetailTangki'] != null && data['DetailTangki'] != '' ) list.add(_contentDetailPopup(context: context, title: "Tangki", content: jsonEncode(data['DetailTangki']), popupType: PopupType.TANGKI));
        if (data['Layanan'] != null && data['Layanan'] != '' ) list.add(_contentDetailPopup(context: context, title: "Layanan", content: data['Layanan']));
        if (data['MampuMenanganiBarang'] != null && data['MampuMenanganiBarang'] != '' ) list.add(_contentDetailPopup(context: context, title: "Mampu Menangani Barang", content: data['MampuMenanganiBarang']));
        if (data['Kelebihan'] != null && data['Kelebihan'] != '' ) list.add(_contentDetailPopup(context: context, title: "Kelebihan", content: data['Kelebihan']));
        if (data['KotaLayanan'] != null && data['KotaLayanan'] != '' ) list.add(_contentDetailPopup(context: context, title: "Kota Layanan", content: data['KotaLayanan']));
      }

      if (subKategoriId == "46") // Transportation Store | Toko Suku Cadang
      {
        list.clear();
        if (data['JenisSukuCadangyangDijual'] != null && data['JenisSukuCadangyangDijual'] != '' ) list.add(_contentDetailPopup(context: context, title: "Jenis Suku Cadang Yang Dijual", content: data['JenisSukuCadangyangDijual']));
        if (data['Kelebihan'] != null && data['Kelebihan'] != '') list.add(_contentDetailPopup(context: context, title: "Kelebihan", content: data['Kelebihan']));
      }
      
      if (
        subKategoriId == "29" // Transportasi Intermoda | Road Transportation
        || subKategoriId == "30" // Transportasi Intermoda | Air Freight
        || subKategoriId == "31" // Transportasi Intermoda | Rail Freight
      )
      {
        list.clear();
        if (
          data['Ruteyangdilayani'] != null 
          && data['Ruteyangdilayani'] != ""
        )
          list.add(
            Column(
              children: [
                _contentDetailPopup(
                  context: context,
                  content: data['Ruteyangdilayani'],
                  title: 'Rute yang Dilayani',
                ),
                _gap(context),
              ],
            )
          );
      }

      if (
        subKategoriId == "32" // Transportasi Intermoda | Sea Freight
      ) {
        list.clear();
        if (data['Ruteyangdilayani'] != null && data['Ruteyangdilayani'] != "")
          list.add(
            Column(
              children: [
                _contentDetailPopup(
                  context: context,
                  content: data['Ruteyangdilayani'],
                  title: 'Rute yang Dilayani',
                ),
                _gap(context),
              ],
            )
          );
      }

      if (
        subKategoriId == "12" // Repair & Maintenance | Teknisi
      ) {
        list.clear();
        if (data['JenisServis'] != null && data['JenisServis'] != "")
          list.add(
            Column(
              children: [
                _contentDetailPopup(
                  context: context,
                  content: data['JenisServis'],
                  title: 'Jenis Service',
                ),
                _gap(context),
              ],
            )
          );
        if (data['MerkYangDilayani'] != null && data['MerkYangDilayani'] != "")
          list.add(
            Column(
              children: [
                _contentDetailPopup(
                  context: context,
                  content: data['MerkYangDilayani'],
                  title: 'Merk yang Dilayanani',
                ),
                _gap(context),
              ],
            )
          );
      }

      if (
        subKategoriId == '11' // Repair & Maintenance | Bengkel
      ) {
        list.clear();
        if (data['MerkYangDilayani'] != null && data['MerkYangDilayani'] != "")
          list.add(
            Column(
              children: [
                _contentDetailPopup(
                  context: context,
                  content: data['MerkYangDilayani'],
                  title: 'Merk yang Dilayanani',
                ),
                _gap(context),
              ],
            )
          );
        if (data['LayananService'] != null && data['LayananService'] != "")
          list.add(
            Column(
              children: [
                _contentDetailPopup(
                  context: context,
                  content: data['LayananService'],
                  title: 'Layanan Service',
                ),
                _gap(context),
              ],
            )
          );
          if (data['Kelebihan'] != null && data['Kelebihan'] != "")
          list.add(
            Column(
              children: [
                _contentDetailPopup(
                  context: context,
                  content: data['Kelebihan'],
                  title: 'Kelebihan',
                ),
                _gap(context),
              ],
            )
          );
      }

      if (
        subKategoriId == "57" // Human Capital | HR Consultant and Training
      ) {
        list.clear();
        if (data['Layanan'] != null && data['Layanan'] != "")
          list.add(
            Column(
              children: [
                _contentDetailPopup(
                  context: context,
                  content: data['Layanan'],
                  title: 'Layanan',
                ),
                _gap(context),
              ],
            )
          );
        if (data['Kelebihan'] != null && data['Kelebihan'] != "")
          list.add(
            Column(
              children: [
                _contentDetailPopup(
                  context: context,
                  content: data['Kelebihan'],
                  title: 'Kelebihan',
                ),
                _gap(context),
              ],
            )
          );
        if (data['BidangKeahlian'] != null && data['BidangKeahlian'] != "")
          list.add(
            Column(
              children: [
                _contentDetailPopup(
                  context: context,
                  content: data['BidangKeahlian'],
                  title: 'BidangKeahlian',
                ),
                _gap(context),
              ],
            )
          );
      }

      var mainImage = "${data['LogoPerusahaan'][0] ?? ""}";
      var title = "${data['data_seller']['nama_individu_perusahaan'] ?? ''}";
      if (subKategoriId == "57") { // Human Capital | HR Consultant & Training
        mainImage = "${data['data_seller']['TypeUser']}" == "0" ? data['data_seller']['image_seller'] ?? "" : data['LogoPerusahaan'][0] ?? "";
        title = "${data['data_seller']['TypeUser']}" == "0" ? data['data_seller']['nama_seller'] ?? "" : data['data_seller']['nama_individu_perusahaan'] ?? "";
      }

      return Column(
        children: [
          CarouselImageBuyer(imageList: image),
          DetailTitleComproBuyer(
            image: mainImage,
            title: title,
            isVerified: "${data['data_seller']['verified']}" == "1",
            onTapHubungi: () => DialogBuyer.showCallBottomSheet(listData: data),
            titleContent: 
              subKategoriId == "12" ? // Repair & Maintenance | Teknisi
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    data['data_seller']['nama_seller'],
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                  CustomText(
                    data['Keahlian'],
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/detail_compro_buyer/ic_suitcase_buyer.svg',
                        height: GlobalVariable.ratioWidth(context) * 13,
                        width: GlobalVariable.ratioWidth(context) * 13,
                      ),
                      SizedBox(width: GlobalVariable.ratioWidth(context) * 6),
                      CustomText(
                        "Pengalaman : ${data['Pengalaman']} Tahun"
                      )
                    ],
                  )
                ],
              ) : null,
            detailChildren: detailCompro.map((e) {
              return DetailTitleComproDetailBuyer(
                label: e['label'], 
                value: e['value'], 
                icon: e['icon'],
              );
            }).toList(),
            textLaporkan: "Ada masalah pada iklan ini?", 
            onTapLaporkan: () {},
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 5,
          ),
          if (data['TentangPerusahaan'] != null && data['TentangPerusahaan'] != "")
            DetailExpansionBuyer(
              headerText: "Tentang",
              maxHeight: GlobalVariable.ratioWidth(context) * 100,
              child: (isExpand, isInitialize) => TextDetailExpansionBuyer(
                text: "${data['TentangPerusahaan'] ?? ''}", 
                isExpanded: isExpand, 
                isInitialize: isInitialize,
              ),
            ),
          _gap(context),
          ...list,
          // PRAS <
          if (data['Sertifikat'] != null && data['Sertifikat'] is List && data['Sertifikat'].length > 0 )
            Column(
              children: [
                DetailExpansionBuyer(
                  headerText: "Pencapaian Penghargaan dan Sertifikat",
                  maxHeight: GlobalVariable.ratioWidth(context) * 146,
                  child: (isExpand, isInitialize) => FileDetailExpansionBuyer(
                    itemCount: (data['Sertifikat'] as List).length, 
                    itemBuilder: (ctx, i) {
                      final o = (data['Sertifikat'] as List)[i];
                      return TileFileDetailExtensionBuyer(
                        image: '${(o['Sertifikat_image'] is List && o['Sertifikat_image'].length > 0) ? o['Sertifikat_image'][0] : ''}', 
                        label: '${o['Sertifikat_nama']}', 
                        onTap: () => Get.to(
                          MediaPreviewBuyer(
                            urlMedia: [
                              '${(o['Sertifikat_image'] is List && o['Sertifikat_image'].length > 0) ? o['Sertifikat_image'][0] : o['Sertifikat_image']}'
                            ],
                            hideIndicator: true,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _gap(context),
              ],
            ),
          if (data['MarkerLokasi'] != null && data['MarkerLokasi'] != '' && (data['MarkerLokasi'] is List && (data['MarkerLokasi'] as List).length > 0)) ...[
            Column(
              children: [
                MarkerLocationBuyer(
                  title: subKategoriId == '11' ? "Alamat Bengkel" : "Alamat Perusahaan",
                  address: data['MarkerLokasi'][0]['MarkerLokasi_address'],
                  latitude: double.parse("${data['MarkerLokasi'][0]['MarkerLokasi_lat'] ?? 0}"), 
                  longitude: double.parse("${data['MarkerLokasi'][0]['MarkerLokasi_long'] ?? 0}"),
                ),
                _gap(context),
              ],
            ),
          ] else ...[
            Column(
              children: [
                MarkerLocationBuyer(
                  title: subKategoriId == '11' ? "Alamat Bengkel" : "Alamat Perusahaan",
                  address: data['Alamat'] ?? data['LokasiIklan'],
                  latitude: double.parse("${data['data_seller']['lat'] ?? 0}"), 
                  longitude: double.parse("${data['data_seller']['long'] ?? 0}"),
                ),
                _gap(context),
              ],
            ),
          ],
          if (subKategoriId != "57") // Human Capital | HR Consultant and Training
            if (data['WaktuOperasional'] != null && data['WaktuOperasional'] != '')
              Column(
                children: [
                  _baseLayerWidget(
                    context: context,
                    children: [
                      CustomText(
                        "Waktu Operasional",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 19.2/16,
                        withoutExtraPadding: true,
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 16,
                      ),
                      CustomText(
                        data['WaktuOperasional'],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 16.8/14,
                        withoutExtraPadding: true,
                      ),
                    ],
                  ),
                  _gap(context),
                ],
              ),
          _baseLayerWidget(
            context: context,
            horizontalPadding: 0, // padding from the content!
            children: [
              if (data['Promo'] != null && data['Promo'] != '' && data['Promo'] is List)...[
                DetailCardPromoBuyer(
                  cardList: List.from(data['Promo']).map((e) => {
                    'name': e['Promo_judul'],
                    'image': (e['Promo_image'] is List && (e['Promo_image'] as List).length > 0) ? e['Promo_image'][0] ?? "" : e['Promo_image'] ?? "",
                  }).toList(),
                  onCardTap: (i) {
                    var dataImage = data['Promo'][i];
                    Get.to(() => DetailCardWithDesc(
                      imageUrl: dataImage['Promo_image'][0] ?? '',
                      name: dataImage['Promo_judul'] ?? '',
                      desc: dataImage['Promo_deskripsi'] ?? '',
                      onTap: () {
                        Get.to(() => MediaPreviewBuyer(
                          urlMedia: List.from(data['Promo']).map((e) {
                            return (e['Promo_image'] is List && (e['Promo_image'] as List).length > 0) 
                            ? e['Promo_image'][i].toString() ?? "" 
                            : e['Promo_image'][i].toString() ?? "";
                          }).toList(), 
                        hideIndicator: true, 
                        ));
                      },
                    ));
                  }, 
                  onShowAllTap: () {
                    if (
                      subKategoriId == "57" // Human Capital | HR Consultant and Training
                    ) {
                      // Untuk individu title pakai data['data_seller']['nama_seller'], sedangkan kalau perusahaan pakai data['data_seller']['nama_individu_perusahaan']
                      // Untuk individu image pakai data['data_seller']['image_seller'], sedangkan kalau perusahaan pakai data['LogoPerusahaan'][0]
                      Get.to(() => DetailAllListCard(
                        data: data, 
                        imageUrl: mainImage,
                        title: title,
                        isPromo: true
                      ));
                    }
                    else if(
                      subKategoriId == "14" // Repair & Maintenance | Perusahaan Lainnya
                    ){
                      title = data['data_seller']['nama_seller']; 
                      Get.to(() => DetailAllListCard(
                        data: data, 
                        title: title,
                        isPromo: true
                      ));
                    } 
                    else {
                      Get.to(() => DetailAllListCard(data: data, isPromo: true));
                    }
                  },
                ),
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 24,
                ),
              ],
              if (
                subKategoriId == "23" // Dealer & Karoseri | Dealer
                || subKategoriId == "25" // Dealer & Karoseri | Karoseri
              )
                KatalogProdukDetailBuyer(
                  args: {
                    'layanan': layananId,
                    'KategoriID': kategoriId,
                    'SubKategoriID': subKategoriId,
                    'data': data,
                    'ComproID': comproId,
                  },
                ),
              if (
                subKategoriId == "23" // Dealer & Karoseri | Dealer
                || subKategoriId == "25" // Dealer & Karoseri | Karoseri
                //PRAS4 >
                || subKategoriId == "18" // Property & Warehouse | Jasa Pergudangan
                || subKategoriId == "19" // Property & Warehouse | PLB
                //PRAS4 <

                // Andy4 <
                || subKategoriId == "17" // Property & Warehouse | Gudang Barang Cair
                || subKategoriId == "49" // Places & Promo | Places
                // Andy4 >

                // Khabib4 < 
                // Khabib4 >

                // Octa4 <
                // Octa4 >

                // Refo4 <
                // Refo4 >
              )
                if (data['Brosur'] != null && data['Brosur'] != '' && data['Brosur'] is List && (data['Brosur'] as List).length > 0 ) ...[
                  Column(
                    children: [
                      DetailCardBrosurBuyer(
                        cardList: List.from(data['Brosur']).map((e) => {
                          'name': e['Brosur_judul'],
                          'image': (e['Brosur_image'] is List && (e['Brosur_image'] as List).length > 0) ? e['Brosur_image'][0] ?? "" : e['Brosur_image'] ?? "",
                        }).toList(),
                        onCardTap: (i) {
                          Get.to(() => MediaPreviewBuyer(
                            urlMedia: [
                              if ((data['Brosur'][i]['Brosur_image'] is List && (data['Brosur'][i]['Brosur_image'] as List).length > 0))
                                ...List.from(data['Brosur'][i]['Brosur_image']).map((e) {
                                  return e;
                                }).toList()
                              else data['Brosur'][i]['Brosur_image'] ?? "",
                            ], 
                            hideIndicator: true, 
                          ));
                        }, 
                        onShowAllTap: () => Get.to(() => DetailAllListCard(data: data, isPromo: false)),
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 24,
                      ),
                    ],
                  )
                ],
              if (data['Testimoni'] != null && data['Testimoni'] != '' && data['Testimoni'] is List && (data['Testimoni'] as List).length > 0 )
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(context) * 16),
                  child: TestimoniPortofolioBuyer(
                    dataList: List.from(data['Testimoni']).map((e) => DataTestimoniPortofolioBuyer(
                      name: e['Testimoni_nama'],
                      url: e['Testimoni_file'] is List ? e['Testimoni_file'][0] : e['Testimoni_file'],
                    )).toList(),
                  ),
                ),
              if (
                subKategoriId == "12" // Repair & Maintenance | Teknisi
              ) 
                DetailCardServiceBuyer(
                  cardList: List.from(data['JasaServis']).map((e) => {
                    'title': e['JasaServis_judul'],
                    'image': (e['JasaServis_image'] is List && (e['JasaServis_image'] as List).length > 0) ? e['JasaServis_image'][0] ?? "" : e['JasaServis_image'] ?? "",
                    'price_start': e['JasaServis_Harga_JasaServis_Awal'],
                    'price_end': e['JasaServis_Harga_JasaServis_Akhir']
                  }).toList(), 
                  onCardTap: (i) {
                    var item = data['JasaServis'][i];
                    Get.to(() => DetailCardService(
                      imageUrl: (item['JasaServis_image'] is List && (item['JasaServis_image'] as List).length > 0) ? item['JasaServis_image'][0] ?? "" : item['JasaServis_image'] ?? "",
                      title: item['JasaServis_judul'] ?? '',
                      priceStart: item['JasaServis_Harga_JasaServis_Awal'],
                      priceEnd: item['JasaServis_Harga_JasaServis_Akhir'],
                      detail: item['JasaServis_deskripsi'] ?? '',
                      onTap: () {
                        Get.to(() => MediaPreviewBuyer(
                          urlMedia: List.from(item['JasaServis_image']).map((e) => e).toList(), 
                        hideIndicator: true, 
                        ));
                      },
                    ));
                  }, 
                  onShowAllTap: () => Get.to(DetailCardServiceAllListBuyer(data: data))
                ),
              BannerAds(
                layananID: layananId,
                formMasterID: kategoriId,
                penempatanID: "3",
                marginTop: 24,
                marginBottom: 0,
              )
            ],
          ),
        ],
      );
    }
    // Carousel, Title, Harga Berlaku, Detail, Deskripsi, Company Profile, Lokasi, Banner
    else if (
      //danielle
      subKategoriId == "24" // Dealer & Karoseri | Katalog Produk Dealer
      || subKategoriId == "26" // Dealer & Karoseri | Katalog Produk Dealer
      || subKategoriId == "27" // Dealer & Karoseri | Produk Lainnya
      || subKategoriId == '37' // Transportation Store | Kendaraan Kargo
      || subKategoriId == '41' // Transportation Store | Container
      || subKategoriId == '20' // Property & Warehouse | Peralatan Gudang
      || subKategoriId == '21' // Property & Warehouse | Produk Lainnya
      // Andy3 <
      || subKategoriId == '36' // Transportation Store | BAN
      || subKategoriId == '38' // Transportation Store | AKI
      || subKategoriId == '39' // Transportation Store | OLI
      || subKategoriId == '44' // Transportation Store | Suku Cadang
      // Andy3 >

      // Khabib3 < 
      // Khabib3 >

      // Octa3 <
      || subKategoriId == '42' // Transportation Store | Semi Trailer Carrier
      || subKategoriId == '43' // Transportation Store | Rigid Truck Carrier
      || subKategoriId == '45' // Transportation Store | Peralatan Angkutan
      || subKategoriId == '15' // Property & Warehouse | Gudang Dijual
      || subKategoriId == '16' // Property & Warehouse | Gudang Disewakan
      // Octa3 >

      // Pras3 <
      || subKategoriId == '47' // Transportation Store | Produk Lainnya
      || subKategoriId == '35' // Transportasi Intermoda | Produk Lainnya
      || subKategoriId == '13' // Repair & Maintenance | Produk Lainnya
      || subKategoriId == '52' // Human Capital | Produk Lainnya

      // Pras3 >

      // Refo3 <
      // Refo3 >
    ) {
      String adName = "${data['Judul']}";
      String harga = data['Harga'] != null && data['Harga'] != "" ? data['Harga'] : null;
      String adPriceInfo;
      InfoDetailTitleProductBuyer adInfo;
      String adInfoValue = "-";
      int maxHeightSpec = 128;
      int maxHeightDesc = 100;
      // Pras >
      String namaSeller = '${data['data_seller']['nama_individu_perusahaan']}';
      if(
        subKategoriId == '13' // Repair & Maintenance | Produk Lainnya
        || subKategoriId == '14' // Repair & Maintenance | Perusahaan Lainnya
      ){
        namaSeller = '${data['data_seller']['nama_seller']}';
      }
      // Pras <
      if (
        subKategoriId == "24" // Dealer & Karoseri | Katalog Produk Dealer
      ) {
        adName = "${data['TipeUnitTruk']}";
        harga = data['Harga_harga'] != null && data['Harga_harga'] != "" ? data['Harga_harga'] : null;
        adPriceInfo = data['Harga_road_harga'] != null && data['Harga_road_harga'] != "" ? "(${data['Harga_road_harga']})" : null;
        try {
          final List aList = jsonDecode(data['CocokUntukTipeBody']);
          adInfoValue = aList.join(",");
        } catch (e) {}
        adInfo = InfoDetailTitleProductBuyer(
          label: "Cocok untuk ",
          value: adInfoValue,
        );
        maxHeightSpec = 203;
      }
      else if (
        subKategoriId == "26" // Dealer & Karoseri | Katalog Produk Dealer
      ) {
        adName = "${data['JenisKaroseri']}";
        harga = data['Harga'] != null && data['Harga'] != "" ? data['Harga'] : null;
        try {
          final List aList = jsonDecode(data['UntukTipeKendaraan']);
          adInfoValue = aList.join(",");
        } catch (e) {}
        adInfo = InfoDetailTitleProductBuyer(
          label: "Untuk tipe unit kendaraan ",
          value: adInfoValue,
        );
      }

      // Andy4 <
      // Andy4 >

      // Khabib4 < 
      // Khabib4 >

      // Octa4 <
      else if (
        subKategoriId == "42" // Transportation Store | Semi Trailer Carrier
        || subKategoriId == "43" // Transportation Store | Rigid Truck Carrier
        || subKategoriId == "45" // Transportation Store | Peralatan Angkutan
        // || subKategoriId == "15" // Property & Warehouse | Gudang Dijual
        // || subKategoriId == "16" // Property & Warehouse | Gudang Disewakan
      ) {
        maxHeightSpec = 128;
      }
      else if (
        subKategoriId == "15" // Property & Warehouse | Gudang Dijual
        || subKategoriId == "16" // Property & Warehouse | Gudang Disewakan
      ) {
        maxHeightSpec = 145;
      }
      // Octa4 >

      // Pras4 <
      // Pras4 >

      // Refo4 <
      // Refo4 >

      return Column(
        children: [
          CarouselImageBuyer(
            imageList: List<String>.from(data['Foto']),
          ),
          _gap(context),
          DetailTitleProductBuyer(
            adName: adName,
            adPrice: harga != null ? Utils.formatCurrency(value: double.parse(Utils.removeNumberFormat(harga))) : null,
            adPriceInfo: adPriceInfo,
            adInfo: adInfo,
            adLocation: data['LokasiIklan'],
            adDate: DateTime.parse(data['Created']),
          ),
          if (data['Harga_lokasi_harga'] != null)
            Column(
              children: [
                DetailExpansionBuyer(
                  headerText: "Harga Berlaku Pada",
                  child: (isExpand, isInitialize) => TextDetailExpansionBuyer(
                    text: "${data['Harga_lokasi_harga']}", 
                    isExpanded: isExpand, 
                    isInitialize: isInitialize,
                  ),
                ),
                _divider(context),
              ],
            ),
          if (detail != null && detail.isNotEmpty)
            Column(
              children: [
                DetailExpansionBuyer(
                  headerText: "Detail",
                  maxHeight: maxHeightSpec != null ? GlobalVariable.ratioWidth(context) * maxHeightSpec : maxHeightSpec,
                  child: (isExpand, isInitialize) => SpecDetailExpansionBuyer(
                    dataDetail: detail,
                  ),
                ),
                _divider(context),
              ],
            ),
          if (data['Deskripsi'] != null)
            Column(
              children: [
                DetailExpansionBuyer(
                  headerText: "Deskripsi",
                  maxHeight: GlobalVariable.ratioWidth(context) * maxHeightDesc,
                  child: (isExpand, isInitialize) => TextDetailExpansionBuyer(
                    text: data['Deskripsi'], 
                    isExpanded: isExpand, 
                    isInitialize: isInitialize,
                  ),
                ),
                _gap(context),
              ],
            ),
          if (
            data['Fasilitas'] != null 
            && (
              subKategoriId == "15" // Property & Warehouse | Gudang Dijual
              || subKategoriId == "16" // Property & Warehouse | Gudang Disewakan
            )
          )  
            Column(
              children: [
                _contentDetailPopup(
                  context: context,
                  content: data['Fasilitas'],
                  title: 'Fasilitas',
                ),
                _gap(context),
              ],
            ),
          if (
            data['BarangKhusus'] != null 
            && (
              subKategoriId == "15" // Property & Warehouse | Gudang Dijual
              || subKategoriId == "16" // Property & Warehouse | Gudang Disewakan
            )
          )  
            Column(
              children: [
                _contentDetailPopup(
                  context: context,
                  content: data['BarangKhusus'],
                  title: 'Barang Khusus yang Dapat Disimpan',
                ),
                _gap(context),
              ],
            ),
          if (
            data['SpesifikasiProduk'] != null 
            && (
              subKategoriId == "24" // Dealer & Karoseri | Katalog Produk Dealer
            )
          )  
            Column(
              children: [
                _baseLayerWidget(
                  context: context,
                  children: [
                    TestimoniPortofolioBuyer(
                      title: "Spesifikasi Produk",
                      dataList: (data['SpesifikasiProduk'] as List).map((e) {
                        return DataTestimoniPortofolioBuyer(
                          url: "$e",
                        );
                      }).toList(),
                    ),
                  ],
                ),
                _gap(context),
              ],
            ),
          DetailSellerProfileBuyer(
            profileImage: data['data_seller']['image_seller'],
            profileName: namaSeller,
            profileSince: data['data_seller']['anggota_sejak'], 
            isVerified: "${data['data_seller']['verified']}" == "1", 
            reportText: "Ada masalah dengan iklan ini?", 
            onLihatBarang: () {
              Get.to(
                () => BarangLainnyaView(), 
                arguments: {
                  'LayananID': layananId,
                  'KategoriID': kategoriId,
                  'SubKategoriID': subKategoriId,
                  'Data': data
                }
              );
            }, 
            onHubungi: () => DialogBuyer.showCallBottomSheet(listData: data),
          ),
          if (data['data_seller']['lat'] != null && data['data_seller']['long'] != null)
            MarkerLocationBuyer(
              title: "Lokasi Iklan", 
              latitude: double.parse("${data['data_seller']['lat']}"), 
              longitude: double.parse("${data['data_seller']['long']}"),
              hideAddress: true,
            ),
          BannerAds(
            layananID: layananId,
            formMasterID: kategoriId,
            penempatanID: "4",
          ),
          BannerAds(
            layananID: layananId,
            formMasterID: kategoriId,
            penempatanID: "2",
          )
        ],
      );
    }

    // COMPRO DETAIL | HUMAN CAPITAL | LOWONGAN PROFESSIONAL
    else if (
      subKategoriId == '54' // Human Capital | Lowongan Professional
    ) {
      List<String> image = [] ;
      if(data['Foto'] is List && (data['Foto'] as List).length > 0) {
        for (var o in List.from(data['Foto'])) {
          if (o is Map) {
            if (o['Foto_image'] is List) {
              for (var ob in o['Foto_image']) {
                image.add("$ob");
              }
            } else if (o['Foto_image'] is String) {
              image.add("${o['Foto_image']}");
            }
          } else if (o is String) {
            image.add("$o");
          }
        }
      }
      // Video
      if(data['Video'] is List && (data['Video'] as List).length > 0) {
        for (var o in List.from(data['Video'])) {
          if (o is Map) {
            if (o['Video_image'] is List) {
              for (var ob in o['Video_image']) {
                image.add("$ob");
              }
            } else if (o['Video_image'] is String) {
              image.add("${o['Video_image']}");
            }
          } else if (o is String) {
            image.add("$o");
          }
        }
      }
      int maxHeightSpec = 153;

      List<Widget> list = [];

      if (
        data['Kualifikasi'] != null &&
        data['Kualifikasi'] != ''
      )
        list.add(_contentDetailPopup(context: context, title: "Kualifikasi", content: data['Kualifikasi']));
      
      if (
        data['KetrampilanWajib'] != null &&
        data['KetrampilanWajib'] != ''
      )
        list.add(_contentDetailPopup(context: context, title: "Skill Wajib", content: data['KetrampilanWajib']));
      
      if (
        data['Tunjangan'] != null &&
        data['Tunjangan'] != ''
      )
        list.add(_contentDetailPopup(context: context, title: "Tunjangan dan Lain-lain", content: data['Tunjangan']));
      
      return Column(
        children: [
          CarouselImageBuyer(imageList: image),
          DetailTitleComproBuyer(
            image: "${data['LogoPerusahaan'][0] ?? ""}",
            title: "${data['Judul'] ?? ''}",
            titleContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(data['data_seller']['nama_individu_perusahaan'] ?? '',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 14.4/12,
                  withoutExtraPadding: true,
                ),
              ],
            ),
            textHubungi: "Kirim Lamaran",
            isVerified: "${data['verified']}" == "1",
            onTapHubungi: () {
              if (
                subKategoriId == "54" // Human Capital | Lowongan Professional
                // Andy7 <
                // Andy7 >

                // Khabib7 < 
                // Khabib7 >

                // Octa7 <
                // Octa7 >

                // Pras7 <
                // Pras7 >

                // Refo7 <
                // Refo7 >
              ){
                return DialogBuyer.showCallBottomSheet(
                  listData: data, 
                  isHumanCapital: true,
                  bottomSheetType: 0,
                  /* JENIS BOTTOM SHEET TYPE
                    0 : just showing email
                    1 : without pic
                    2 : showing all include email
                    3 : default 
                  */
                );
              } else {
                return DialogBuyer.showCallBottomSheet(listData: data);
              }
            },
            detailChildren: detailCompro.map((e) {
              return DetailTitleComproDetailBuyer(
                label: e['label'], 
                value: e['value'], 
                icon: e['icon'],
              );
            }).toList(),
            textLaporkan: "Ada masalah pada iklan ini?", 
            onTapLaporkan: () {},
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 5,
          ),
          if (detail != null && detail.isNotEmpty)
            ...[
              DetailExpansionBuyer(
                headerText: "Detail Lowongan",
                maxHeight: maxHeightSpec != null ? GlobalVariable.ratioWidth(context) * maxHeightSpec : maxHeightSpec,
                child: (isExpand, isInitialize) => SpecDetailExpansionBuyer(
                  dataDetail: detail,
                ),
              ),
              _divider(context),
            ],
          if (data['Deskripsi'] != null && data['Deskripsi'] != "")
            ...[
              DetailExpansionBuyer(
                headerText: "Deskripsi",
                maxHeight: GlobalVariable.ratioWidth(context) * 100,
                child: (isExpand, isInitialize) => TextDetailExpansionBuyer(
                  text: "${data['Deskripsi'] ?? ''}", 
                  isExpanded: isExpand, 
                  isInitialize: isInitialize,
                ),
              ),
              _gap(context),
            ],
          ...list,
          if (data['TentangPerusahaan'] != null && data['TentangPerusahaan'] != "")
            ...[
              DetailExpansionBuyer(
                headerText: "Tentang Perusahaan",
                maxHeight: GlobalVariable.ratioWidth(context) * 100,
                child: (isExpand, isInitialize) => TextDetailExpansionBuyer(
                  text: "${data['TentangPerusahaan'] ?? ''}", 
                  isExpanded: isExpand, 
                  isInitialize: isInitialize,
                ),
              ),
              _gap(context),
            ],
          if (data['AlamatPerusahaan'] != null && data['AlamatPerusahaan'] != "")
            ...[
              DetailExpansionBuyer(
                headerText: subKategoriId == '11' ? "Alamat Bengkel" : "Alamat Perusahaan",
                maxHeight: GlobalVariable.ratioWidth(context) * 100,
                child: (isExpand, isInitialize) => TextDetailExpansionBuyer(
                  text: "${data['AlamatPerusahaan'] ?? ''}", 
                  isExpanded: isExpand,
                  isInitialize: isInitialize,
                ),
              ),
              _gap(context),
            ],
          if (data['UkuranPerusahaan'] != null && data['UkuranPerusahaan'] != "")
            ...[
              DetailExpansionBuyer(
                headerText: "Ukuran Perusahaan",
                maxHeight: GlobalVariable.ratioWidth(context) * 100,
                child: (isExpand, isInitialize) => TextDetailExpansionBuyer(
                  text: "${data['UkuranPerusahaan'] ?? ''}", 
                  isExpanded: isExpand, 
                  isInitialize: isInitialize,
                ),
              ),
              _gap(context),
            ],
        ],
      );
    }

    // COMPRO DETAIL | HUMAN CAPITAL | Job Seekers
    else if (
      subKategoriId == '56' // Human Capital | Job Seekers
    ) {

      List<Widget> list = [];

      if (
        data['PengalamanKerja'] != null &&
        data['PengalamanKerja'] != ''
      )
        list.add(_contentDetailPopup(context: context, title: "Pengalaman Kerja", content: data['RiwayatPengalamanKerja'], data: data, popupType: PopupType.WORKEXP));
      
      if (
        data['RiwayatPendidikan'] != null &&
        data['RiwayatPendidikan'] != ''
      )
        list.add(_contentDetailPopup(context: context, title: "Riwayat Pendidikan", content: data['RiwayatPendidikan']));
      
      String skill;
      if (data['Keahlian'] != null && data['Keahlian'] != "") {
        skill = data['Keahlian'];
        if (data['RateKeahlian'] != null && data['RateKeahlian'] != "") {
          skill += " (${data['RateKeahlian']})";
        }
        if (data['KeahlianB'] != null && data['KeahlianB'] != "") {
          skill += ", ${data['KeahlianB']}";
          if (data['RateKeahlianB'] != null && data['RateKeahlianB'] != "") {
            skill += " (${data['RateKeahlianB']})";
          }
        }
        if (data['KeahlianC'] != null && data['KeahlianC'] != "") {
          skill += ", ${data['KeahlianC']}";
          if (data['RateKeahlianC'] != null && data['RateKeahlianC'] != "") {
            skill += " (${data['RateKeahlianC']})";
          }
        }
      }

      if (
        skill != null
      )
        list.add(_contentDetailPopup(context: context, title: "Keahlian & Bakat", content: '', data: {
          "Keahlian": skill,
          "Bakat": "${data['Bakat']}".replaceAll("\n", ", ").replaceAll("-", "").trim(),
        }, popupType: PopupType.KEAHLIANBAKAT));
      
      return Column(
        children: [
          DetailTitleComproBuyer(
            image: "${data['data_seller']['image_seller']}",
            title: "${data['data_seller']['nama_individu_perusahaan']}, ${data['Umur']} Tahun, ${data['JenisKelamin']}",
            titleContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText('Posisi Yang Diharapkan:',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 16.8/14,
                  withoutExtraPadding: true,
                ),
                CustomText(data['PosisiYangDiharapkan'] ?? '',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 16.8/14,
                  withoutExtraPadding: true,
                ),
              ],
            ),
            isVerified: "${data['verified']}" != "1",
            onTapHubungi: () => DialogBuyer.showCallBottomSheet(listData: data),
            detailChildren: detailCompro.map((e) {
              return DetailTitleComproDetailBuyer(
                label: e['label'], 
                value: e['value'], 
                icon: e['icon'],
              );
            }).toList(),
            textLaporkan: "Ada masalah pada iklan ini?", 
            onTapLaporkan: () {},
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 5,
          ),
          if (detail != null && detail.isNotEmpty)
            Column(
              children: [
                DetailExpansionBuyer(
                  headerText: "Informasi Tambahan",
                  padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(context) * 16,
                    GlobalVariable.ratioWidth(context) * 16,
                    GlobalVariable.ratioWidth(context) * 16,
                    GlobalVariable.ratioWidth(context) * 12,
                  ),
                  child: (isExpand, isInitialize) => SpecDetailExpansionBuyer(
                    dataDetail: detail,
                    lastBorder: true,
                  ),
                ),
                if (data['Resume'] != null && data['Resume'] is List && (data['Resume'] as List).isNotEmpty)
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(context) * 16,
                      GlobalVariable.ratioWidth(context) * 0,
                      GlobalVariable.ratioWidth(context) * 16,
                      GlobalVariable.ratioWidth(context) * 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("Resume",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 16.8/14,
                          withoutExtraPadding: true,
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              GlobalVariable.urlImageTemplateBuyer + 'temp-check-paper.svg',
                              color: Color(ListColor.colorBlackTemplate),
                              height: GlobalVariable.ratioWidth(context) * 24,
                            ),
                            SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                            Expanded(
                              child: CustomText(
                                "Resume ${data['data_seller']['nama_individu_perusahaan']}",
                                withoutExtraPadding: true,
                                fontSize: 14,
                                height: 16.8/14,
                                color: Color(0xFF176CF7),
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: GlobalVariable.ratioWidth(context) * 24,
                              ),
                              child: InkWell(
                                onTap: () {
                                  DownloadUtils.doDownload(
                                    context: context, 
                                    url: data['Resume'][0],
                                  );
                                },
                                child: SvgPicture.asset(GlobalVariable.imagePath +
                                  "download_dokumen.svg",
                                  color: Color(ListColor.colorBlue),
                                  width: GlobalVariable.ratioWidth(context) * 24,
                                  height: GlobalVariable.ratioWidth(context) * 24,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                _divider(context),
              ],
            ),
          if (data['Tentang'] != null && data['Tentang'] != "")
            DetailExpansionBuyer(
              headerText: "Tentang",
              maxHeight: GlobalVariable.ratioWidth(context) * 100,
              child: (isExpand, isInitialize) => TextDetailExpansionBuyer(
                text: "${data['Tentang'] ?? ''}", 
                isExpanded: isExpand, 
                isInitialize: isInitialize,
              ),
            ),
          _gap(context),
          ...list,
          if (data['Sertifikat'] != null && data['Sertifikat'] is List)
            _baseLayerWidget(
              context: context,
              children: [
                TestimoniPortofolioBuyer(
                  title: "Sertifikat Keahlian/Dokumen Penting",
                  dataList: (data['Sertifikat'] as List).map((e) {
                    return DataTestimoniPortofolioBuyer(
                      url: "${e['Sertifikat_image'] is List ? e['Sertifikat_image'][0] : e['Sertifikat_image']}",
                      name: "${e['Sertifikat_nama']}",
                    );
                  }).toList(),
                ),
              ],
            ),
        ],
      );
    }

    return Container();
  }

  // Andy7 <
  // Andy7 >

  // Khabib7 < 
  // Khabib7 >

  // Octa7 <
  // Octa7 >

  // Pras7 <
  // Pras7 >

  // Refo7 <
  // Refo7 >

  static Widget _gap(context) => SizedBox(
    height: GlobalVariable.ratioWidth(context) * 5,
  );

  static Widget _divider(context) {
    return Container(
      width: double.infinity,
      height: GlobalVariable.ratioWidth(context) * 0.5,
      color: Color(ListColor.colorGreyTemplate2),
    );
  }

  static Widget _baseLayerWidget({
    @required BuildContext context,
    double verticalPadding = 24,
    double horizontalPadding = 16,
    @required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(context) * verticalPadding,
        horizontal: GlobalVariable.ratioWidth(context) * horizontalPadding,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  static Widget _contentDetailPopup({
    @required BuildContext context,
    String title,
    String content,
    Map data,
    PopupType popupType = PopupType.BASIC
  }) {
    return Column(
      children: [
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              var result;
              try {
                result = jsonDecode(content);
              } on FormatException {
                result = content;
              }

              if (popupType == PopupType.WORKEXP) {
                DialogBuyer.detailPengalamanKerja(
                  context: context,
                  title: title,
                  currentWork: data['PosisiPekerjaanTerakhir'],
                  pengalamanKerja: content,
                );
              } else if (popupType == PopupType.KEAHLIANBAKAT) {
                DialogBuyer.detailKeahlianBakat(
                  context: context,
                  title: title,
                  data: data,
                );
              } else if (popupType == PopupType.TANGKI) {
                detailTangki(
                  context: context,
                  title: title,
                  listDetail: result
                );
              } else {
                DialogBuyer.detail(
                  context: context,
                  title: title,
                  content: content,
                  listDetail: result is List ? List<String>.from(result) : null,
                );
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(context) * 16,
                vertical: GlobalVariable.ratioWidth(context) * 12,
              ),
              constraints: BoxConstraints(
                minHeight: GlobalVariable.ratioWidth(context) * 46,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: GlobalVariable.ratioWidth(context) * 264,
                    child: CustomText(
                      title,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/ic_arrow_right_profile.svg',
                    width: GlobalVariable.ratioWidth(context) * 22,
                    height: GlobalVariable.ratioWidth(context) * 22,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: GlobalVariable.ratioWidth(context) * 5,
        ),
      ],
    );
  }

  static void detailTangki({
    @required BuildContext context,
    String title,
    List listDetail,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 16),
          topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 16),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: GlobalVariable.ratioWidth(context) * 604,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                  color: Color(ListColor.colorGreyTemplate7),
                ),
                width: GlobalVariable.ratioWidth(context) * 38,
                height: GlobalVariable.ratioWidth(context) * 3,
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(context) * 6,
                  bottom: GlobalVariable.ratioWidth(context) * 15,
                ),
              ),
              Container(
                height: GlobalVariable.ratioWidth(context) * 24,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: Get.back,
                        child: SvgPicture.asset(
                          GlobalVariable.urlImageTemplateBuyer + 'ic_close_grey.svg',
                          width: GlobalVariable.ratioWidth(context) * 24,
                          height: GlobalVariable.ratioWidth(context) * 24,
                          color: Color(ListColor.colorBlueTemplate1),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        title,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
              Container(
                width: GlobalVariable.ratioWidth(context) * 328,
                child: ListView.separated(
                  itemCount: listDetail.length,
                  shrinkWrap: true,
                  separatorBuilder: (_, __) {
                    return Container(
                      height: GlobalVariable.ratioWidth(context) * 14,
                    );
                  },
                  itemBuilder: (c, i) {
                    return Container(
                      padding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(context) * 19,
                        top: GlobalVariable.ratioWidth(context) * 14,
                        right: GlobalVariable.ratioWidth(context) * 14,
                        bottom: GlobalVariable.ratioWidth(context) * 14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
                        border: Border.all(
                          color: Color(ListColor.colorGreyTemplate2),
                          width: GlobalVariable.ratioWidth(context) * 1
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            listDetail[i]['DetailTangki_Tipe_Tangki'],
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            height: 1.2,
                          ),
                          Container(
                            width: double.infinity,
                            height: GlobalVariable.ratioWidth(context) * 0.5,
                            margin: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(context) * 8,
                              bottom: GlobalVariable.ratioWidth(context) * 13
                            ),
                            color: Color(ListColor.colorGreyTemplate2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'Jumlah Tangki',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                height: 1.2,
                                color: Color(ListColor.colorGreyTemplate3),
                              ),
                              CustomText(
                                listDetail[i]['DetailTangki_Jumlah_Tangki'],
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                height: 1.2
                              ),
                            ],
                          ),
                          SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'Cbm/Tangki',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                height: 1.2,
                                color: Color(ListColor.colorGreyTemplate3),
                              ),
                              CustomText(
                                listDetail[i]['DetailTangki_Cbm_Tangki'],
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                height: 1.2
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 36,
              ),
              _button(
                onTap: Get.back,
                height: 32,
                borderRadius: 6,
                backgroundColor: Color(ListColor.colorBlueTemplate1),
                color: Colors.white,
                text: "OK",
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
            ],
          ),
        );
      },
    );
  }
}

// PRIVATE CUSTOM BUTTON
Widget _button({
  double height,
  double width,
  bool maxWidth = false,
  double marginLeft = 0,
  double marginTop = 0,
  double marginRight = 0,
  double marginBottom = 0,
  double paddingLeft = 0,
  double paddingTop = 0,
  double paddingRight = 0,
  double paddingBottom = 0,
  bool useShadow = false,
  bool useBorder = false,
  double borderRadius = 18,
  double borderSize = 1,
  String text = "",
  @required Function onTap,
  FontWeight fontWeight = FontWeight.w600,
  double fontSize = 14,
  Color color = Colors.white,
  Color backgroundColor = Colors.white,
  Color borderColor,
  Widget customWidget,
}) {
  return Container(
    margin: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * marginLeft, GlobalVariable.ratioWidth(Get.context) * marginTop,
        GlobalVariable.ratioWidth(Get.context) * marginRight, GlobalVariable.ratioWidth(Get.context) * marginBottom),
    width: width == null
        ? maxWidth
            ? MediaQuery.of(Get.context).size.width
            : null
        : GlobalVariable.ratioWidth(Get.context) * width,
    height: height == null ? null : GlobalVariable.ratioWidth(Get.context) * height,
    decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: useShadow
            ? <BoxShadow>[
                BoxShadow(
                  color: Color(ListColor.shadowColor).withOpacity(0.08),
                  blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                  spreadRadius: 0,
                  offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                ),
              ]
            : null,
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        border: useBorder
            ? Border.all(
                width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                color: borderColor ?? Color(ListColor.colorBlue),
              )
            : null),
    child: Material(
      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
      color: Colors.transparent,
      child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
          ),
          onTap: () {
            onTap();
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * paddingLeft, GlobalVariable.ratioWidth(Get.context) * paddingTop,
                GlobalVariable.ratioWidth(Get.context) * paddingRight, GlobalVariable.ratioWidth(Get.context) * paddingBottom),
            width: maxWidth ? double.infinity : null,
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(borderRadius)),
            child: customWidget == null
                ? CustomText(
                    text ?? "",
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: color,
                  )
                : customWidget,
          )),
    ),
  );
}

enum PopupType { BASIC, TANGKI, WORKEXP, KEAHLIANBAKAT }