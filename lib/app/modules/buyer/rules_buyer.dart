// this class is build for help programmer to determine which data that
// will show to the UI by identifying subKategori Id or subKategori name
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/template/dialog/dialog_buyer.dart';
import 'package:muatmuat/app/template/widgets/card/card_company.dart';
import 'package:muatmuat/app/template/widgets/card/card_product.dart';
import 'package:muatmuat/app/utils/utils.dart';

import 'detail/detail_iklan_compro_view.dart';
import 'detail/detail_iklan_product_view.dart';

enum ADS_TYPE {
  product,
  compro,
  catalogue,
}

class RulesBuyer {

  // Halaman Awal Image
  static String getAssetImageForLanding(kategoriId, [String menuName]) {
    /// Dealer & Karoseri > [assets/dealer_karoseri_buyer.png]
    /// Human Capital > [assets/human_capital_buyer.png]
    /// Places & Promo > [assets/places_promos_buyer.png]
    /// Property Warehouse > [assets/property_warehouse_buyer.png]
    /// Repair & Maintenance Services > [assets/repair_maintenance_services_buyer.png]
    /// Transportasi Intermoda > [assets/transportasi_intermoda_buyer.png]
    /// Transportation Store > [assets/transportation_store_buyer.png]
    if (kategoriId == "4" || menuName.toLowerCase() == "transportation store") { // TRANSPORTATION STORE
      return "assets/transportation_store_buyer.png";
    }
    else if (kategoriId == "8" || menuName.toLowerCase() == "dealer & karoseri") {
      return "assets/dealer_karoseri_buyer.png";
    }
    else if (kategoriId == "5" || menuName.toLowerCase() == "repair & maintenance") {
      return "assets/repair_maintenance_services_buyer.png";
    }
    else if (kategoriId == "9" || menuName.toLowerCase() == "human capital") {
      return "assets/template_buyer/human_capital_buyer.png";
    }
    else if (kategoriId == "10" || menuName.toLowerCase() == "places & promo") {
      return "assets/places_promos_buyer.png";
    }
    else if (kategoriId == "6" || menuName.toLowerCase() == "property & warehouse") {
      return "assets/property_warehouse_buyer.png";
    }
    else if (kategoriId == "7" || menuName.toLowerCase() == "transportasi intermoda") {
      return "assets/transportasi_intermoda_buyer.png";
    }
    else return "assets/property_warehouse_buyer.png";
  }

  // ADS TYPE
  static ADS_TYPE getAdsTypeBySubKategoriId(
    String subKategoriId,
  ) {
    if (
      subKategoriId == '37' // Transportation Store | Kendaraan Kargo
      || subKategoriId == '36' // Transportation Store | BAN
      || subKategoriId == '41' // Transportation Store | Container
      || subKategoriId == '42' // Transportation Store | Semi Trailer Carrier
      || subKategoriId == '43' // Transportation Store | Rigid Truck Carrier
      || subKategoriId == '38' // Transportation Store | AKI
      || subKategoriId == '39' // Transportation Store | OLI
      || subKategoriId == '44' // Transportation Store | Suku Cadang
      || subKategoriId == '24' // Dealer & Karoseri | Katalog Produk
      || subKategoriId == '45' // Transportation Store | Peralatan Angkutan
      || subKategoriId == '47' // Transportation Store | Produk Lainnya
      || subKategoriId == '15' // Property & Warehouse | Gudang Dijual
      // Andy1 <
      // Andy1 >

      // Khabib1 < 
      || subKategoriId == '24' // Dealer & Karoseri | Katalog Produk Dealer
      || subKategoriId == '26' // Dealer & Karoseri | Katalog Produk Karoseri
      || subKategoriId == '27' // Dealer & Karoseri | Katalog Produk Karoseri
      || subKategoriId == '55' // Human Capital | Lowongan Umum
      // Khabib1 >

      // Octa1 <
      || subKategoriId == '16' // Property & Warehouse | Gudang Disewakan
      // Octa1 >

      // Pras1 <
      || subKategoriId == '35' // Transportasi Intermoda | Produk Lainnya
      || subKategoriId == '13' // Repair & Maintenance | Produk Lainnya
      || subKategoriId == '52' // Human Capital | Produk Lainnya

      // Refo1 <
      || subKategoriId == '20' // Property & Warehouse | Peralatan Gudang
      || subKategoriId == '21' // Property & Warehouse | Katalog Produk Lainnya
      // Refo1 >
    ) {
      // PRODUCT
      return ADS_TYPE.product;
    }
    else if (
      subKategoriId == '18' // Property & Warehouse | Jasa Pergudangan
      || subKategoriId == '23' // Dealer & Karoseri | Dealer
      || subKategoriId == '46' // Transportation Store | Toko Suku Cadang
      || subKategoriId == '17' // Property & Warehouse | Gudang Barang Cair
      // Andy2 <
      || subKategoriId == '32' // Transportasi Intermoda | Sea Freight
      || subKategoriId == '12' // Repair & Maintenance | Teknisi
      || subKategoriId == '57' // Human Capital | HR Consultant and Training
      || subKategoriId == '10' // Places & Promo | Places
      // Andy2 >

      // Khabib2 < 
      || subKategoriId == '25' // Dealer & Karoseri | Perusahaan Karoseri
      || subKategoriId == '28' // Dealer & Karoseri | Perusahaan Karoseri
      || subKategoriId == '54' // Human Capital | Lowongan Professional
      // Khabib2 >

      // Octa2 <
      || subKategoriId == '29' // Transportasi Intermoda | Road Transportation
      || subKategoriId == '30' // Transportasi Intermoda | Air Freight
      || subKategoriId == '31' // Transportasi Intermoda | Rail Freight
      // Octa2 >

      // Pras2 <
      || subKategoriId == '48' // Transportation Store | Perusahaan Lainnya
      || subKategoriId == '19' // Property & Warehouse | PLB
      || subKategoriId == '22' // Property & Warehouse | Perusahaan Lainnya
      || subKategoriId == '40' // Transportasi Intermoda | Perusahaan Lainnya
      || subKategoriId == '14' // Repair & Maintenance | Perusahaan Lainnya
      || subKategoriId == '53' // Human Capital | Perusahaan Lainnya
      // Pras2 >

      // Refo2 <
      || subKategoriId == '33' // Transportasi Intermoda | Freight Forwarding
      || subKategoriId == '34' // Transportasi Intermoda | 3 - 5 Company
      || subKategoriId == '11' // Repair & Maintenance | Bengkel
      // Refo2 >
    ) {
      // COMPRO (Company Profile)
      return ADS_TYPE.compro;
    } 
    else {
      // CATALOGUE (Company Profile + Product)
      return ADS_TYPE.catalogue;
    }
  }

  // Card Variety
  static Widget getCardDataKey({
    String kategoriId, 
    String subKategoriId, 
    Map data,
    String layanan,
    VoidCallback onFavorited,
    VoidCallback onReported
  }) {
    
    // Card Product
    if (
      subKategoriId == '37' // Transportation Store | Kendaraan Kargo
      || subKategoriId == '36' // Transportation Store | BAN
      || subKategoriId == '41' // Transportation Store | Container
      || subKategoriId == '42' // Transportation Store | Semi Trailer Carrier
      || subKategoriId == '43' // Transportation Store | Rigid Truck Carrier
      || subKategoriId == '38' // Transportation Store | AKI
      || subKategoriId == '39' // Transportation Store | OLI
      || subKategoriId == '44' // Transportation Store | Suku Cadang
      || subKategoriId == '45' // Transportation Store | Peralatan Angkutan
      || subKategoriId == '15' // Property & Warehouse | Gudang Dijual
      // Andy3 <
      // Andy3 >

      // Khabib3 < 
      // Khabib3 >

      // Octa3 <
      || subKategoriId == '16' // Property & Warehouse | Gudang Disewakan
      // Octa3 >

      // Pras3 <
      // Pras3 >

      // Refo3 <
      // Refo3 >
    ) {
      String harga = "${data['Harga'] ?? '0'}";
      num price = 0;
      try {
        price = double.parse(Utils.removeNumberFormat(harga));
      } catch (e) {}
      return CardProduct(
        onTap: () async {
          Get.to(() => DetailIklanProductView(),
            arguments: {
              'KategoriID': kategoriId,
              'SubKategoriID': subKategoriId,
              'IklanID': data['ID'],
              'Layanan': layanan
            },
          );
        },
        highlight: "${data['highlight']}" != "0",
        verified: "${data['verified']}" != "0",
        favorite: "${data['favorit']}" != "0",
        onFavorited: onFavorited,
        // report: data['report'] == null ? false : data['report'] != "0",
        // onReported: onReported,
        date: DateTime.parse(data['Created']),
        title: data['Judul'] ?? "",
        imageUrl: data['Foto'].isNotEmpty ? data['Foto'][0] ?? "" : "",
        useNegotiationPrice: harga.isEmpty,
        price: price,
        description: data['Deskripsi'],
        location: data['LokasiIklan'],
        detail: getCardDataKeyBySubKategoriId(subKategoriId, data),
        detailValueStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        // maxWidthDetailLabel: 70,
        showDateAtFooter: false, // menyesuaikan berdasarkan modul
      );
    }
    // Card product with company name in bottom
    else if (
      subKategoriId == '24' // Dealer & Karoseri | Katalog Produk Dealer
      // Andy4 <
      // Andy4 >

      // Khabib4 < 
      || subKategoriId == '26' // Dealer & Karoseri | Katalog Produk Karoseri
      // Khabib4 >

      // Octa4 <
      // Octa4 >

      // Pras4 <
      // Pras4 >

      // Refo4 <
      // Refo4 >
    ) {
      bool verticalDetail = false;
      String harga = "";
      String title = "";
      num price = 0;
      TextStyle detailStyle;
      if (subKategoriId == '24') { // Dealer & Karoseri | Katalog Produk Dealer
        title = "${data['TipeUnitTruk']}";
        harga = "${data['Harga_harga'] ?? '0'}";
        detailStyle = TextStyle(
          color: Color(0xFF676767),
          fontSize: 10,
          fontWeight: FontWeight.w500,
          height: 12/10,
        );
      } else if (subKategoriId == '26') { // Dealer & Karoseri | Katalog Produk Karoseri
        title = "${data['JenisKaroseri']}";
        harga = "${data['Harga'] ?? '0'}";
        verticalDetail = true;
        detailStyle = TextStyle(
          color: Color(0xFF676767),
          fontSize: 10,
          fontWeight: FontWeight.w500,
          height: 12/10,
        );
      }

      try {
        price = double.parse(Utils.removeNumberFormat(harga));
      } catch (e) {}
      return CardProduct(
        onTap: () async {
          Get.to(() => DetailIklanProductView(),
            arguments: {
              'KategoriID': "$kategoriId",
              'SubKategoriID': "$subKategoriId",
              'IklanID': data['ID'],
              'Kategori': data['kategori']
            },
          );
        },
        highlight: "${data['highlight']}" != "0",
        verified: "${data['verified']}" != "0",
        favorite: "${data['favorit']}" != "0",
        onFavorited: onFavorited,
        date: DateTime.parse(data['Created']),
        imageUrl: data['Foto'] is List && (data['Foto'] as List).isNotEmpty ? data['Foto'][0] ?? "" : "",
        price: price,
        description: data['Deskripsi'],
        detailValueStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        verticalDetail: verticalDetail,
        maxWidthDetailLabel: 70,
        showDateAtFooter: true,
        formatDate: "dd MMMM yyyy",
        title: title, 
        subtitle: data['Harga_road_harga'] != null && data['Harga_road_harga'] != "" ? "(${data['Harga_road_harga']})" : null,
        subtitleStyle: TextStyle(
          color: Color(0xFF676767),
          fontSize: 10,
          height: 12/10,
        ),
        location: "${data['LokasiIklan']}",
        detail: getCardDataKeyBySubKategoriId(subKategoriId, data),
        detailLabelStyle: detailStyle,
        useNegotiationPrice: harga == "",
        company: data['NamaPerusahaan'],
      );
    }
    // Card Product without Detail and title
    else if(
      subKategoriId == '47' // Transportation Store | Produk Lainnya
      // Andy5 <
      // Andy5 >

      // Khabib5 < 
      || subKategoriId == '27' // Dealer & Karoseri | Produk Lainnya
      // Khabib5 >

      // Octa5 <
      // Octa5 >

      // Pras5 <
      || subKategoriId == '35' // Dealer & Karoseri | Produk Lainnya
      || subKategoriId == '13' // Repair & Maintenance | Produk Lainnya
      || subKategoriId == '52' // Human Capital | Produk Lainnya
      // Pras5 >

      // Refo5 <
      // Refo5 >
    ){
      return CardProduct(
        onTap: (){
          Get.to(() => DetailIklanProductView(),
            arguments: {
              'KategoriID':kategoriId,
              'SubKategoriID': subKategoriId,
              'IklanID': data['ID'],
              'Kategori': data['kategori']
            },
          );
        },
        highlight: "${data['highlight']}" != "0",
        verified: "${data['verified']}" != "0",
        favorite: "${data['favorit']}" != "0",
        onFavorited: onFavorited,
        date: DateTime.parse(data['Created']),
        imageUrl: data['Foto'][0],
        description: data['Judul'],
        useNegotiationPrice: ['Harga'].toString().isEmpty,
        price: double.parse(Utils.removeNumberFormat(data['Harga'])),
        location: data['LokasiIklan'],
        showDateAtFooter: true,
      );

    }
    // Card Compro
    else if (
      subKategoriId == '18' // Property & Warehouse | Jasa Pergudangan
      || subKategoriId == '23' // Dealer & Karoseri | Dealer
      || subKategoriId == '46' // Transportation Store | Toko Suku Cadang
      || subKategoriId == '17' // Property & Warehouse | Gudang Barang Cair
      || subKategoriId == '48' // Transportation Store | Perusahaan Lainnya
      // Andy6 <
      || subKategoriId == '32' // Transportasi Intermoda | Sea Freight
      || subKategoriId == '12' // Repair & Maintenance | Teknisi
      // Andy6 >

      // Khabib6 < 
      || subKategoriId == '25' // Dealer & Karoseri | Perusahaan Karoseri
      || subKategoriId == '28' // Dealer & Karoseri | Perusahaan Lainnya
      // Khabib6 >

      // Octa6 <
      || subKategoriId == '29' // Transportasi Intermoda | Road Transportation
      || subKategoriId == '30' // Transportasi Intermoda | Air Freight
      || subKategoriId == '31' // Transportasi Intermoda | Rail Freight
      // Octa6 >

      // Pras6 <
      || subKategoriId == '19' // Property & Warehouse | Pusat Logistik Berikat
      || subKategoriId == '22' // Property & Warehouse | Perusahaan Lainnya
      || subKategoriId == '40' // Transportasi Intermoda | Perusahaan Lainnya
      || subKategoriId == '14' // Repair & Maintenance | Perusahaan Lainnya
      || subKategoriId == '53' // Human Capital | Perusahaan Lainnya
      // Pras6 >

      // Refo6 <
      || subKategoriId == '33' // Transportasi Intermoda | Freight Forwarding
      || subKategoriId == '34' // Transportasi Intermoda | 3 - 5 Company
      || subKategoriId == '11' // Repair & Maintenance | Bengkel
      // Refo6 >
    ) {
      var address = data['Alamat'];
      var title = data['NamaPerusahaan'] ?? "";

      // Repair & Maintenance | Teknisi
      if (subKategoriId == '12') {
        address = data['JasaServis_deskripsi'];
        title = data['data_seller']['nama_seller'];
      }

      return CardCompany(
        onTap: () {
          Get.to(() => DetailIklanComproView(),
            arguments: {
              'KategoriID': kategoriId,
              'SubKategoriID': subKategoriId,
              'IklanID': data['ID'],
              'Kategori': data['kategori']
            },
          );
        },
        highlight: "${data['highlight']}" != "0",
        verified: "${data['data_seller']['verified']}" != "0",
        favorite: "${data['favorit']}" != "0",
        onFavorited: onFavorited,
        date: DateTime.parse(data['Created']),
        title: title,
        imageUrl: data['LogoPerusahaan'][0] ?? "",
        location: data['LokasiIklan'],
        detail: getCardDataKeyBySubKategoriId(subKategoriId, data),
        detailValueStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        address: address
      );
    }
    // Card with detail vertically
    else if (
      subKategoriId == '20' // Property & Warehouse | Peralatan Gudang
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
    ) {
      return CardProduct(
        onTap: () {
          Get.to(() => DetailIklanProductView(),
            arguments: {
              'KategoriID': kategoriId,
              'SubKategoriID': subKategoriId,
              'IklanID': data['ID'],
              'Kategori': data['kategori']
            },
          );
        },
        highlight: "${data['highlight']}" != "0",
        verified: "${data['verified']}" != "0",
        favorite: "${data['favorit']}" != "0",
        onFavorited: onFavorited,
        report: data['report'] == null ? false : data['report'] != "0",
        onReported: onReported,
        date: DateTime.parse(data['Created']),
        title: data['Judul'] ?? "",
        imageUrl: data['Foto'][0] ?? "",
        useNegotiationPrice: ['Harga'].toString().isEmpty,
        price: double.parse(Utils.removeNumberFormat(data['Harga'])),
        description: data['Deskripsi'],
        location: data['LokasiIklan'],
        // detail: getCardDataKeyBySubKategoriId(subKategoriId, data),
        verticalDetail: true,
        detail: getCardDataKeyBySubKategoriId(subKategoriId, data),
        detailValueStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        // maxWidthDetailLabel: 70,
        showDateAtFooter: false, // menyesuaikan berdasarkan modul
      );
    }
    else if (subKategoriId == '21'){
      return CardProduct(
        onTap: () {
          Get.to(() => DetailIklanProductView(),
            arguments: {
              'KategoriID': kategoriId,
              'SubKategoriID': subKategoriId,
              'IklanID': data['ID'],
              'Kategori': data['kategori']
            },
          );
        },
        highlight: "${data['highlight']}" != "0",
        verified: "${data['verified']}" != "0",
        favorite: "${data['favorit']}" != "0",
        onFavorited: onFavorited,
        report: data['report'] == null ? false : data['report'] != "0",
        onReported: onReported,
        date: DateTime.parse(data['Created']),
        // title: data['Judul'] ?? "",
        imageUrl: data['Foto'][0] ?? "",
        price: double.parse(Utils.removeNumberFormat(data['Harga'])),
        // description: data['Deskripsi'],
        description: data['Judul'],
        location: data['LokasiIklan'],
        // detail: getCardDataKeyBySubKategoriId(subKategoriId, data),
        // verticalDetail: true,
        detailValueStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        maxWidthDetailLabel: 70,
        showDateAtFooter: true, // menyesuaikan berdasarkan modul
      );
    }
    // Card Compro Human Capital | Lowongan Professional
    else if (
      subKategoriId == '54' // Human Capital | Lowongan Professional
    ) {
      String salary;
      String gender;
      String batasLamaran;
      try {
        if (
        data['Harga_estimasi_awal'] != null 
        && data['Harga_estimasi_akhir'] != null
        ) {
          salary = "${Utils.formatUang(double.parse(data['Harga_estimasi_awal'].toString()))} - ${Utils.delimeter(data['Harga_estimasi_akhir'])}/bulan";
        }
      } catch (e) {}
      try {
        gender = (jsonDecode("${data['JenisKelamin']}") as List).join(",");
      } catch (e) {}
      try {
        batasLamaran = Utils.formatDate(value: data['BatasLamaran'], format: "dd MMMM yyyy");
      } catch (e) {}
      return CardCompany(
        onTap: () {
          Get.to(() => DetailIklanComproView(),
            arguments: {
              'KategoriID': kategoriId,
              'SubKategoriID': subKategoriId,
              'IklanID': data['ID'],
              'Kategori': data['kategori']
            },
          );
        },
        highlight: "${data['highlight']}" != "0",
        verified: "${"${data['verified']}"}" != "0",
        favorite: "${data['favorit']}" != "0",
        onFavorited: onFavorited,
        // date: DateTime.parse(data['Created']),
        title: data['Judul'] ?? "",
        subtitle: data['NamaPerusahaan'] ?? "",
        imageUrl: data['LogoPerusahaan'][0] ?? "",
        information: Information(
          salary: salary,
          gender: gender,
          age: "${data['BatasanUmur_estimasi_awal']} - ${data['BatasanUmur_estimasi_akhir']} Tahun",
          place: "Penempatan : ${data['LokasiIklan']}",
          deadline: "Batas Lamaran : $batasLamaran",
        ),
        tags: [
          BadgeModel(
            label: "${data['SistemKerja']}",
          ),
          BadgeModel(
            label: "${data['TipePekerjaan']}",
          ),
          BadgeModel(
            label: "Pengalaman : ${data['MinimumPengalaman']} Tahun",
          ),
        ],
      );
    }
    // Card Compro Human Capital | Job Seekers
    else if (
      subKategoriId == '56' // Human Capital | Job Seekers
    ) {
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
      return CardCompany(
        onTap: () {
          Get.to(() => DetailIklanComproView(),
            arguments: {
              'KategoriID': kategoriId,
              'SubKategoriID': subKategoriId,
              'IklanID': data['ID'],
              'Kategori': data['kategori']
            },
          );
        },
        highlight: "${data['highlight']}" != "0",
        verified: "${"${data['verified']}"}" != "0",
        favorite: "${data['favorit']}" != "0",
        onFavorited: onFavorited,
        date: DateTime.parse(data['Created']),
        detailTop: {
          'Posisi yang diharapkan': data['PosisiYangDiharapkan'],
        },
        title: "${data['data_seller']['nama_individu_perusahaan']}, ${data['Umur']} Tahun, ${data['JenisKelamin']}",
        imageUrl: "${data['data_seller']['image_seller']}",
        information: Information(
          education: data['JenjangPendidikan'],
          experience: "${data['PengalamanKerja']} tahun pengalaman",
          staff: data['PosisiPekerjaanTerakhir'],
          skill: skill,
          job: "${data['Bakat']}".replaceAll("\n", ", ").replaceAll("-", "").trim(),
          preference: "Preferensi Lokasi Kerja : ${data['LokasiIklan']}",
        ),
      );
    }
    // Card Product Only Text
    else if (
      subKategoriId == '55' // Human Capital | Lowongan Umum
      // Andy6 <
      // Andy6 >

      // Khabib6 < 
      // Khabib6 >

      // Octa6 <
      // Octa6 >

      // Pras6 <
      // Pras6 >

      // Refo6 <
      // Refo6 >
    ) {
      return CardProduct(
        highlight: "${data['highlight']}" != "0",
        verified: "${"${data['verified']}"}" != "0",
        favorite: "${data['favorit']}" != "0",
        onFavorited: onFavorited,
        onReported: onReported,
        report: true,
        date: DateTime.parse(data['Created']),
        location: data['LokasiIklan'],
        title: data['Judul'] ?? "",
        description: data['Deskripsi'] ?? "",
        onContactViewed: () => DialogBuyer.showCallBottomSheet(
          listData: data, 
          isHumanCapital: true,
          bottomSheetType: 2,
          /* JENIS BOTTOM SHEET TYPE
            0 : just showing email
            1 : without pic
            2 : showing all include email
            3 : default 
          */
        ),
      );
    }
    // Card Company with Individu Icon and Date below
    else if (
      subKategoriId == '57' // Human Capital | HR Consultant and Training
    ) {
      return CardCompany(
        onTap: () {
          Get.to(() => DetailIklanComproView(),
            arguments: {
              'KategoriID': kategoriId,
              'SubKategoriID': subKategoriId,
              'IklanID': data['ID'],
              'Kategori': data['kategori']
            },
          );
        },
        highlight: "${data['highlight']}" != "0",
        verified: "${data['data_seller']['verified']}" != "0",
        favorite: "${data['favorit']}" != "0",
        onFavorited: onFavorited,
        individu: "${data['data_seller']['TypeUser']}" == "0", // 0 = Individu, 1 = Perusahaan
        date: DateTime.parse(data['Created']),
        title: "${data['data_seller']['TypeUser']}" == "0" ? data['data_seller']['nama_seller'] ?? "" : data['data_seller']['nama_individu_perusahaan'] ?? "",
        imageUrl: "${data['data_seller']['TypeUser']}" == "0" ? data['data_seller']['image_seller'] ?? "" : data['LogoPerusahaan'][0] ?? "",
        location: data['LokasiIklan'],
        detail: getCardDataKeyBySubKategoriId(subKategoriId, data),
        detailValueStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        address: data['Alamat']
      );
    }
    // Card Places & Promo
    else if (
      subKategoriId == '49' // Places & Promo | Places
    ) {
      return CardCompany(
        onTap: () {
          Get.to(() => DetailIklanComproView(),
            arguments: {
              'KategoriID': kategoriId,
              'SubKategoriID': subKategoriId,
              'IklanID': data['ID'],
              'Kategori': data['kategori']
            },
          );
        },
        highlight: "${data['highlight']}" != "0",
        verified: "${data['data_seller']['verified']}" != "0",
        favorite: "${data['favorit']}" != "0",
        onFavorited: onFavorited,
        topLabel: data['Subkategori']['nama'] ?? "",
        title: data['data_seller']['nama_individu_perusahaan'] ?? "",
        imageUrl: data['LogoPerusahaan'] != null && data['LogoPerusahaan'].isNotEmpty ? data['LogoPerusahaan'][0] ?? "" : "",
        location: data['LokasiIklan'],
        address: data['Alamat']
      ); 
    }
    return CardProduct(
      onTap: () {
        // log(data.toString() + 'peace sign');
        // log(data['Foto'][0].toString());
        // log(subKategoriId.toString());
        Get.to(() => DetailIklanProductView(),
          arguments: {
            'KategoriID': kategoriId,
            'SubKategoriID': subKategoriId,
            'IklanID': data['ID'],
            'Kategori': data['kategori']
          },
        );
      },
      highlight: "${data['highlight']}" != "0",
      verified: "${data['verified']}" != "0",
      favorite: "${data['favorit']}" != "0",
      onFavorited: onFavorited,
      report: data['report'] != "0",
      onReported: onReported,
      date: DateTime.parse(data['Created']),
      title: data['title'] ?? "",
      imageUrl: data['foto_utama'] ?? "",
      useNegotiationPrice: ['Harga'].toString().isEmpty,
      price: double.parse('${data['harga'] ?? '0'}'),
      description: data['deskripsi'],
      location: data['kota'],
      detail: {
        'Kondisi': "${data['kondisi']}".capitalize,
        'Tahun Produksi': data['tahun'],
      },
      detailValueStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      // maxWidthDetailLabel: 70,
      showDateAtFooter: false, // menyesuaikan berdasarkan modul
    );
  }

  // Card Iklan Data Detail
  static Map getCardDataKeyBySubKategoriId(String subKategoriId, Map data) {
    // Transportation Store | Kendaraan Kargo
    if (subKategoriId == '37') {
      return {
        'Kondisi': "${data['Kondisi']}".capitalize,
        'Tahun Produksi': data['TahunKendaraan'],
      };
    }
    // Transportation Store | BAN
    else if (subKategoriId == '36') {
      return {
        'Kondisi': "${data['KondisiBan']}",
        'Ukuran': data['UkuranBan'],
      };
    }
    // Transportation Store | Semi Trailer Carrier
    else if (subKategoriId == '42') {
      return {
        'Kondisi': "${data['Kondisi']}".capitalize,
        'Jenis': data['JenisSemiTrailerCarrier'],
      };
    }
    // Transportation Store | Rigid Truck Carrier
    else if (subKategoriId == '43') {
      return {
        'Kondisi': "${data['Kondisi']}".capitalize,
        'Jenis': data['JenisCarrier'],
      };
    }
    // Transportation Store | Peralatan Angkutan
    else if (subKategoriId == '45') {
      return {
        'Kondisi': "${data['Kondisi']}".capitalize,
      };
    }
    // Property & Warehouse | Jasa Pergudangan
    // PRAS <
    else if (subKategoriId == '18') {
      return {
        'Layanan Special Handling': "${jsonDecode(data['Layanan']).join(", ")}",
        'Berdiri Sejak': data['TahunBerdiri'],
      };
    }
    // PRAS <

    // Property & Warehouse | Gudang Dijual
    else if (subKategoriId == '15') {
      return {
        'LB': data['LuasBangunan'] + " m²",
        'LT': data['LuasTanah'] + " m²",
        'Daya': data['DayaListrik']  + " KWH",
        'Lebar Jalan': data['LebarJalan'] + " m",
      };
    }
    // Dealer & Karoseri | Dealer
    else if (subKategoriId == '23') {
      return {
        'Merk': "${data['Merk']}".capitalize,
        'Tahun Berdiri': data['TahunBerdiri'],
      };
    }
    // Transportation Store | AKI
    else if (subKategoriId == '38') {
      return {
        'Kondisi': "${data['Kondisi']}",
        'Tegangan': "${data['Tegangan']}V/${data['Kapasitas']}Ah"
      };
    }
    // Transportation Store | OLI
    else if (subKategoriId == '39') {
      return {
        'Jenis': "${data['JenisOli']}"
      };
    }
    // Transportation Store | Suku Cadang
    else if (subKategoriId == '44') {
      return {
        'Kondisi': "${data['Kondisi']}",
        'Jenis': "${data['JenisSukuCadang']}",
        'Merk': "${data['Merk']}"
      };
    }
    // Transportation Store | Toko Suku Cadang
    else if (subKategoriId == '46') {
      return {
        'Menjual': "${jsonDecode(data['JenisSukuCadangyangDijual']).join(", ")}",
        'Tahun Berdiri': "${data['TahunBerdiri']}".replaceAll(".", "")
      };
    }
    // Property & Warehouse | Gudang Barang Cair
    else if (subKategoriId == '17') {
      return {
        'Jumlah Tangki': data["DetailTangki_Jumlah_Tangki"],
        'Tahun Berdiri': "${data['TahunBerdiri']}".replaceAll(".", "")
      };
    }
    // Pras <
    else if (
      subKategoriId == '48' // Transportation Store | Perusahaan Lainnya
      || subKategoriId =='22' // Property & Warehouse | Perusahaan Lainnya
      || subKategoriId =='40' // Transportasi Intermoda | Perusahaan Lainnya
      || subKategoriId =='14' // Repair & Maintenance | Perusahaan Lainnya
      || subKategoriId =='53' // Human Capital | Perusahaan Lainnya
    ) {
      return {
        'Layanan Perusahaan': "${data['LayananPerusahaan']}",
        'Tahun Berdiri': "${data['TahunBerdiri']}".replaceAll(".", ""),
      };
    }
    // Pras >
    // Andy8 <
    else if (
      subKategoriId == '30' // Transportasi Intermoda | Air Freight
      || subKategoriId == '32' // Transportasi Intermoda | Sea Freight
    ) {
      List cakupanLayanan = [];
      try {
        print("Cakupan Layanan: " + data['CakupanLayanan']);
        cakupanLayanan = jsonDecode("${data['CakupanLayanan'].isEmpty ? "[]" : data['CakupanLayanan']}");
      } catch (e) {
        cakupanLayanan = [data['CakupanLayanan']];
      }
      return {
        'Jumlah Kantor': "Indonesia: " + data['JumlahKantordiIndonesia'] + ", Luar Negeri: " + ((data['JumlahKantordiluarnegeri'] == "") ? "-" : data['JumlahKantordiluarnegeri']),
        'Cakupan Layanan': cakupanLayanan.isNotEmpty ? cakupanLayanan.join(" - ") : "-",
        'Tahun Berdiri': data['TahunBerdiri'],
      };
    }
    // Repair & Maintenance | Teknisi
    else if (subKategoriId == '12') {
      List jenisServis = [];
      List merk = [];

      try {
        jenisServis = jsonDecode("${data['JenisServis']}");
        merk = jsonDecode("${data['MerkYangDilayani']}");
      } catch (e) {}
      return {
        'Jenis Service': jenisServis.join(", "),
        'Pengalaman': "${data['Pengalaman']} Tahun",
        'Merk yang Dilayani': merk.join(", ")
      };
    }
    // Human Capital | HR Consultant and Training
    else if (subKategoriId == '57') {
      List services = [];
      try {
        services = jsonDecode("${data['Layanan']}");
      } catch (e) {}
      return {
        'Layanan': services.join(", "),
        'Tahun Berdiri': data['TahunBerdiri'],
      };
    }
    // Andy8 >

    // Khabib8 < 
    // Dealer & Karoseri | Katalog Produk Dealer
    else if (subKategoriId == '24') {
      return {
        if (data['JenisTruk'] != null) 'Jenis': "${data['JenisTruk']}",
        if (data['Engine'] != null) 'Engine': "${data['Engine']} Silinder",
        if (data['VolEngine'] != null) 'Vol Engine': "${Utils.delimeter('${data['VolEngine']}')}cc",
        if (data['OutputHP'] != null) 'Output HP': "${data['OutputHP']} HP",
        if (data['TahunPembuatan_'] != null) 'Tahun': "${data['TahunPembuatan_']}",
        if (data['MaxGVW'] != null) 'Max GVW': "${Utils.delimeter('${data['MaxGVW']}')} Kg",
      };
    }
    // Dealer & Karoseri | Perusahaan Karoseri
    else if (subKategoriId == '25') {
      List jenisKaroseri = [];
      try {
        jenisKaroseri = jsonDecode("${data['JenisKaroseri']}");
      } catch (e) {}
      return {
        'Layanan': jenisKaroseri.join(", "),
        'Tahun Berdiri': data['TahunBerdiri'],
      };
    }
    // Dealer & Karoseri | Katalog Produk Karoseri
    else if (subKategoriId == '26') {
      return {
        'Untuk tipe unit kendaraan': "${data['UntukTipeKendaraan']}",
      };
    }
    // Dealer & Karoseri | Perusahaan Lainnya
    else if (subKategoriId == '28') {
      return {
        'Layanan Perusahaan': "${data['LayananPerusahaan']}",
        'Tahun Berdiri': "${data['TahunBerdiri']}",
      };
    }
    // Khabib8 >

    // Octa8 <
    // Property & Warehouse | Gudang Disewakan
    else if (subKategoriId == '16') {
      return {
        'LB': data['LuasBangunan'] + " m²",
        'LT': data['LuasTanah'] + " m²",
        'Daya': data['DayaListrik']  + " KWH",
        'Lebar Jalan': data['LebarJalan'] + " m",
      };
    }
    else if (
      subKategoriId == '29' // Transportasi Intermoda | Road Transportation
      || subKategoriId == '31' // Transportasi Intermoda | Rail Freight
    ) {
      return {
        'Jumlah Kantor Di Indonesia': data['JumlahKantordiIndonesia'],
        'Tahun Berdiri': data['TahunBerdiri'],
      };
    }
    // Octa8 >

    // Pras8 <
    else if (
      subKategoriId == '19' // Property & Warehouse | PLB
      ) { 
      return {
        'Layanan': "${jsonDecode(data["Layanan"]).join(", ")}",
        'Tahun Berdiri': "${data['TahunBerdiri']}".replaceAll(".", ""),
        'Lokasi Gudang': "${data['LokasiGudang']}",
      };
    }
    else if (subKategoriId == '20') {
      return {
        'Jenis Peralatan': "${data['JenisPeralatan']}".capitalize, 
        'Kondisi Barang': "${data['Kondisi']}".capitalize,
      };
    }
    // Pras8 >

    // Refo8 <
    else if (subKategoriId == '41'){
      return {
        'Kondisi': "${data['Kondisi']}",
        'Jenis': "${data['JenisContainer']}",
      };
    }
     else if (
      subKategoriId == '33' // Transportasi Intermoda | Freight Forwarding
    ) {
      List cakupanLayanan = [];
      try {
        cakupanLayanan = jsonDecode("${data['CangkupanLayanan']}");
      } catch (e) {}
      return {
        'Agen Dari Perusahaan': "${data['AgenDariPerusahaan'] == "" ? '-' : data['AgenDariPerusahaan']}",
        'Cakupan Layanan': cakupanLayanan.join(" - "),
        'Jumlah Kantor Di Indonesia': "${data['JumlahKantordiIndonesia'] == "" ? '-' : data['JumlahKantordiIndonesia']}",
        'Tahun Berdiri': "${data['TahunBerdiri'] == "" ? '-' : data['TahunBerdiri']}"
      };
    }
     else if (
      subKategoriId == '34' // Transportasi Intermoda | 3 - 5 PL Company
    ) {
      List cakupanLayanan = [];
      try {
        cakupanLayanan = jsonDecode("${data['Layanan']}");
      } catch (e) {}
      return {
        'Layanan': cakupanLayanan.join(", "),
        'Tingkat Layanan': "${data['TingkatLayanan'] == "" ? '-' : data['TingkatLayanan']}",
        'Tahun Berdiri': "${data['TahunBerdiri'] == "" ? '-' : data['TahunBerdiri']}"
      };
    }
    else if (
      subKategoriId == '11' // Repair & Maintenance | Bengkel
    ) {
      List cakupanLayanan = [];
      List merkLayanan = [];
      try {
        cakupanLayanan = jsonDecode("${data['TipeLayanan']}");
        merkLayanan = jsonDecode("${data['TipeLayanan']}");
      } catch (e) {}
      return {
        'Tipe Layanan': cakupanLayanan.join(", "),
        'Merk yang Dilayani': "${data['MerkYangDilayani'] == "" ? '-' : data['MerkYangDilayani']}",
        'Tahun Berdiri': "${data['TahunBerdiri'] == "" ? '-' : data['TahunBerdiri']}"
      };
    }
    // Refo8 >

    return {
      'Kondisi': "${data['kondisi']}".capitalize,
      'Ukuran': data['ukuran']
    };
  }

  // Detail Product Data Key
  static Map getDetailDataProductBySubKategoriId(subKategoriId, Map data) {
    // Transportation Store | Kendaraan Kargo
    if (subKategoriId == '37') {
      return {
        'Kondisi': data['Kondisi'],
        'Tahun Kendaraan': data['TahunKendaraan'],
        'Jenis Truk': data['JenisTrukCarrier_jenis_truk'],
        'Jenis Carrier': data['JenisTrukCarrier_jenis_carrier'],
        'Jarak Tempuh': data['JarakTempuh'],
        'Merk': data['Merk'],
        'Warna': data['Warna'],
        'Tipe': data['Tipe'],
        'Kapasitas Mesin': data['KapasitasMesin'],
        'Pajak Berlaku Hingga': data['PajakBerlakuHingga'],
      };
    }
    // Transportation Store | BAN
    else if (subKategoriId == '36') {
      return {
        'Kondisi': data['KondisiBan'],
        'Ukuran': data['UkuranBan'],
        'Tipe': data['TipeBan'],
        'Merk': data['Merk'],
      };
    }
    // Transportation Store | Semi Trailer Carrier
    else if (subKategoriId == '42') {
      return {
        'Kondisi': data['Kondisi'],
        'Jenis Carrier': data['JenisSemiTrailerCarrier'],
        'Merk Axle': data['MerkAxle'],
        'Diameter Kingpin': data['DiameterKingpin'],
        'Axle Load': data['AxleLoad'] + " Ton",
        'Warna': data['Warna'],
      };
    }
    // Transportation Store | Rigid Truck Carrier
    else if (subKategoriId == '43') {
      return {
        'Kondisi': data['Kondisi'],
        'Jenis Carrier': data['JenisCarrier'],
        'Cocok Untuk Truk': data['CocokUntukTruk'],
        'Warna': data['Warna'],
      };
    }
    // Transportation Store | AKI
    else if (subKategoriId == '38') {
      return {
        'Kondisi': data['Kondisi'],
        'Dimensi Aki (P x L x T)': "${data['PanjangAki'].toString().replaceAll(".", ",")} x ${data['LebarAki'].toString().replaceAll(".", ",")} x ${data['TinggiAki'].toString().replaceAll(".", ",")} cm",
        'Jenis Aki': data['JenisAki'],
        'Tegangan': "${data['Tegangan']} Volt",
        'Kapasitas': "${data['Kapasitas']} Ampere Hour",
        'Merk': data['Merk']
      };
    }
    // Transportation Store | OLI
    else if (subKategoriId == '39') {
      return {
        'Jenis': data['JenisOli'],
        'Kekentalan': "${data['Kekentalan']}".capitalize,
        'Volume': "${data['Volume']} Liter",
        'Merk': data['Merk']
      };
    }
    // Transportation Store | Suku Cadang
    else if (subKategoriId == '44') {
      return {
        'Kondisi': "${data['Kondisi']}",
        'Jenis': "${data['JenisSukuCadang']}",
        'Merk': "${data['Merk']}"
      };
    }
    // Transportation Store | Peralatan Angkutan
    else if (subKategoriId == '45') {
      return {
        'Kondisi': data['Kondisi'],
      };
    }
    // Property & Warehouse | Gudang Dijual
    else if (subKategoriId == '15') {
      return {
        'Tipe Properti': data['TipeProperti'],
        'Alamat Lokasi': data['LokasiIklan'],
        'Luas Tanah (LT)': data['LuasTanah']  + " m²",
        'Luas Bangunan (LB)': data['LuasBangunan'] + " m²",
        'Sertifikasi': data['SertifikatProperti'],
        'Hadap': data['Hadap'],
        'Tahun Dibangun': data['TahunDibangun'],
        'Tahun Terakhir Renovasi': data['TahunRenov'],
        'Daya Listrik': data['DayaListrik'] + " KWH",
        'Lebar Jalan': data['LebarJalan'] + " m",
        'Kendaraan Yang Dapat Lewat': data['KendaraanYangLewat'],
      };
    }

    // Andy9 <
    // Andy9 >

    // Khabib9 < 
    // Dealer & Karoseri | Katalog Produk Dealer
    else if (subKategoriId == '24') {
      return {
        if (data['JenisTruk'] != null) 'Jenis': "${data['JenisTruk']}",
        if (data['Engine'] != null) 'Engine': "${data['Engine']} Silinder",
        if (data['VolEngine'] != null) 'Vol Engine': "${Utils.delimeter('${data['VolEngine']}')}cc",
        if (data['OutputHP'] != null) 'Output HP': "${data['OutputHP']} HP",
        if (data['TahunPembuatan_'] != null) 'Tahun': "${data['TahunPembuatan_']}",
        if (data['MaxGVW'] != null) 'Max GVW': "${Utils.delimeter('${data['MaxGVW']}')} Kg",
      };
    }
    // Dealer & Karoseri | Katalog Produk Karoseri
    else if (subKategoriId == '26') {
      return {
        'Jenis Bahan': "${data['JenisBahan'] ?? '-'}",
        'Ketebalan Bahan': "${data['KetebalanBahan'] ?? '-'}",
      };
    }
    // Human Capital | Lowongan Professional
    else if (subKategoriId == '54') {
      String gender;
      String batasLamaran;
      try {
        gender = (jsonDecode("${data['JenisKelamin']}") as List).join(",");
      } catch (e) {}
      try {
        batasLamaran = Utils.formatDate(value: data['BatasLamaran'], format: "dd MMMM yyyy");
      } catch (e) {}
      return {
        'Tingkat Jabatan': "${data['TingkatJabatan'] ?? '-'}",
        'Sistem Kerja': "${data['SistemKerja'] ?? '-'}",
        'Min. Pendidikan': "${data['MinimumPendidikan'] ?? '-'}",
        if (
          data['BatasanUmur_estimasi_awal'] != null 
          && data['BatasanUmur_estimasi_akhir'] != null
        )
          'Batasan Umur': "${data['BatasanUmur_estimasi_awal']} - ${data['BatasanUmur_estimasi_akhir']} Tahun",
        if (gender != null) 'Jenis Kelamin': "$gender",
        'Batasan Lamaran': batasLamaran,
      };
    }
    // Human Capital | Job Seeker
    else if (subKategoriId == '56') {
      return {
        if (data['Domisili'] != null) 'Domisili': data['Domisili'],
        if (data['Umur'] != null) 'Umur': "${data['Umur']} Tahun",
        if (data['JenisKelamin'] != null) 'Jenis Kelamin': "${data['JenisKelamin']}",
      };
    }
    // Khabib9 >

    // Octa9 <
    // Property & Warehouse | Gudang Disewakan
    else if (subKategoriId == '16') {
      return {
        'Tipe Properti': data['TipeProperti'],
        'Alamat Lokasi': data['LokasiIklan'],
        'Luas Tanah (LT)': data['LuasTanah']  + " m²",
        'Luas Bangunan (LB)': data['LuasBangunan'] + " m²",
        'Sertifikasi': data['SertifikatProperti'],
        'Hadap': data['Hadap'],
        'Tahun Dibangun': data['TahunDibangun'],
        'Tahun Terakhir Renovasi': data['TahunRenov'],
        'Daya Listrik': data['DayaListrik'] + " KWH",
        'Lebar Jalan': data['LebarJalan'] + " m",
        'Kendaraan Yang Dapat Lewat': data['KendaraanYangLewat'],
      };
    }
    // Octa9 >

    // Pras9 <
    // Pras9 >

    // Refo9 <
    else if (subKategoriId == '41') {
      return {
        'Kondisi': "${data['Kondisi']}",
        'Ukuran': "${data['Ukuran']}",
        'Jenis Container': "${data['JenisContainer']}",
        'Warna': "${data['Warna']}",
      };
    }
    else if (subKategoriId == '20') {
      return {
        'Kondisi': data['Kondisi'],
        'Jenis Peralatan': data['JenisPeralatan'],
      };
    }
    else if (subKategoriId == '21') {
      return {
      };
    }
    // Refo9 >

    return {};
  }

  // Detail Compro Data Key
  static List<Map> getDetailDataComproBySubKategoriId(subKategoriId, Map data) {
  // Pras10
    if (
      subKategoriId == '18' // Property & Warehouse | Jasa Pergudangan
      || subKategoriId == '19' // Property & Warehouse | Pusat Logistik Berikat
      || subKategoriId == "22" // Property & Warehouse | Perusahaan Lainnya
      || subKategoriId == '48' // Transportation Store | Perusahaan Lainnya
      || subKategoriId == '40' // Transportasi Intermoda | Perusahaan Lainnya
      || subKategoriId == '14' // Repair & Maintenance | Perusahaan Lainnya
      || subKategoriId == '53' // Human Capital | Perusahaan Lainnya
    ) {
      return [
        {
          'icon': 'assets/detail_compro_buyer/ic_alamat_detail_buyer.svg',
          'label': "Alamat",
          'value': data['Alamat'],
        },
        if(data['KantorPusat'] != null && subKategoriId != '22')
          {
            'icon': 'assets/detail_compro_buyer/ic_location_buyer.svg',
            'label': "Kantor Pusat",
            'value': data['KantorPusat'],
          },
        if(subKategoriId == '19')
          {
            'icon': 'assets/detail_compro_buyer/ic_warehouse_buyer.svg',
            'label': "Lokasi Gudang",
            'value': data['LokasiGudang'],
          },
        {
          'icon': 'assets/detail_compro_buyer/ic_tahun_berdiri_detail_buyer.svg',
          'label': "Tahun Berdiri",
          'value': data['TahunBerdiri'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_website_buyer.svg',
          'label': "Website",
          'value': data['Website'],
        },
      ];
    }
    // Pras10 >
    // Transportation Store | Toko Suku Cadang
    else if (subKategoriId == '46') {
      return [
        {
          'icon': 'assets/detail_compro_buyer/ic_alamat_detail_buyer.svg',
          'label': "Alamat",
          'value': data['Alamat'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_tahun_berdiri_detail_buyer.svg',
          'label': "Tahun Berdiri",
          'value': "${data['TahunBerdiri']}".replaceAll(".", ""),
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_website_buyer.svg',
          'label': "Website",
          'value': data['Website'],
        },
      ];
    }
    // Dealer & Karoseri | Dealer
    else if (subKategoriId == '23') {
      return [
        {
          'icon': 'assets/detail_compro_buyer/ic_alamat_detail_buyer.svg',
          'label': "Alamat",
          'value': data['Alamat'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_tahun_berdiri_detail_buyer.svg',
          'label': "Tahun Berdiri",
          'value': "${data['TahunBerdiri']}".replaceAll(".", ""),
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_website_buyer.svg',
          'label': "Website",
          'value': data['Website'],
        },
      ];
    }
    // Property & Warehouse | Gudang Barang Cair
    if (subKategoriId == '17') {
      return [
        {
          'icon': 'assets/detail_compro_buyer/ic_alamat_detail_buyer.svg',
          'label': "Alamat",
          'value': data['Alamat'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_location_buyer.svg',
          'label': "Kantor Pusat",
          'value': data['KantorPusat'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_tahun_berdiri_detail_buyer.svg',
          'label': "Tahun Berdiri",
          'value': "${data['TahunBerdiri']}".replaceAll(".", ""),
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_website_buyer.svg',
          'label': "Website",
          'value': data['Website'],
        },
      ];
    }

    // Andy10 <
    else if (
      subKategoriId == '57' // Human Capital | HR Consultant and Training
      || subKategoriId == '49' // Places & Promo | Places
    ) {
      return [
        {
          'icon': 'assets/detail_compro_buyer/ic_alamat_detail_buyer.svg',
          'label': "Alamat",
          'value': data['Alamat'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_tahun_berdiri_detail_buyer.svg',
          'label': "Tahun Berdiri",
          'value': "${data['TahunBerdiri']}".replaceAll(".", ""),
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_website_buyer.svg',
          'label': "Website",
          'value': data['Website'],
        },
      ];
    }
    // Andy10 >

    // Khabib10 < 
    // Dealer & Karoseri | Perusahaan Karoseri
    else if (subKategoriId == '25') {
      return [
        {
          'icon': 'assets/detail_compro_buyer/ic_alamat_detail_buyer.svg',
          'label': "Alamat",
          'value': data['Alamat'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_tahun_berdiri_detail_buyer.svg',
          'label': "Tahun Berdiri",
          'value': "${data['TahunBerdiri']}".replaceAll(".", ""),
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_website_buyer.svg',
          'label': "Website",
          'value': data['Website'],
        },
      ];
    }
    else if (
      subKategoriId == "28" // Dealer & Karoseri | Perusahaan Lainnya
    ) {
      return [
        {
          'icon': 'assets/detail_compro_buyer/ic_alamat_detail_buyer.svg',
          'label': "Alamat",
          'value': data['Alamat'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_tahun_berdiri_detail_buyer.svg',
          'label': "Tahun Berdiri",
          'value': data['TahunBerdiri'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_website_buyer.svg',
          'label': "Website",
          'value': data['Website'],
        },
      ];
    }
    else if (
      subKategoriId == '54' // Human Capital | Lowongan Professional
    ) {
      String salary;
      try {
        if (
        data['Harga_estimasi_awal'] != null 
        && data['Harga_estimasi_akhir'] != null
        ) {
          salary = "${Utils.formatUang(double.parse(data['Harga_estimasi_awal'].toString()))} - ${Utils.delimeter(data['Harga_estimasi_akhir'])} / Bulan";
        }
      } catch (e) {}
      return [
        {
          'icon': 'assets/detail_compro_buyer/ic_location_buyer.svg',
          'label': "Penempatan",
          'value': data['LokasiIklan'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_salary_buyer.svg',
          'label': "Estimasi Gaji",
          'value': salary,
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_timer_sand_buyer.svg',
          'label': "Tipe Pekerjaan",
          'value': "${data['TipePekerjaan']} - ${data['SistemKerja']}",
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_suitcase_buyer.svg',
          'label': "Pengalaman",
          'value': "${data['MinimumPengalaman']} Tahun",
        },
      ];
    }
    else if (
      subKategoriId == '56' // Human Capital | Job Seeker
    ) {
      String salary;
      try {
        if (
        data['EkspektasiGaji'] != null
        ) {
          salary = "${Utils.formatUang(double.parse(data['EkspektasiGaji'].toString()))}";
        }
      } catch (e) {}
      return [
        {
          'icon': 'assets/detail_compro_buyer/ic_building_buyer.svg',
          'label': "Preferensi Tempat Kerja",
          'value': data['LokasiIklan'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_salary_buyer.svg',
          'label': "Ekspektasi Gaji",
          'value': "$salary",
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_suitcase_buyer.svg',
          'label': "Pengalaman",
          'value': "${data['PengalamanKerja']} Tahun",
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_education_buyer.svg',
          'label': "Tingkat Pendidikan",
          'value': "${data['JenjangPendidikan']}",
        },
      ];
    }
    // Khabib10 >

    // Octa10 <
    else if (
      subKategoriId == '29' // Transportasi Intermoda | Road Transportation
      || subKategoriId == '30' // Transportasi Intermoda | Air Freight
      || subKategoriId == '31' // Transportasi Intermoda | Rail Freight
      || subKategoriId == '32' // Transportasi Intermoda | Sea Freight
    ) {
     List cakupanLayanan = [];
      try {
        print("Cakupan Layanan: " + data['CakupanLayanan']);
        cakupanLayanan = jsonDecode("${data['CakupanLayanan'].isEmpty ? "[]" : data['CakupanLayanan']}");
      } catch (e) {
        cakupanLayanan = [data['CakupanLayanan']];
      }

      return [
        {
          'icon': 'assets/detail_compro_buyer/ic_alamat_detail_buyer.svg',
          'label': "Alamat",
          'value': data['Alamat'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_jumlah_kantor_detail_buyer.svg',
          'label': (subKategoriId == '30' || subKategoriId == '32') ? "Jumlah Kantor" : "Jumlah Kantor Di Indonesia",
          'value': (subKategoriId == '30' || subKategoriId == '32') ? "Indonesia: " + data['JumlahKantordiIndonesia'] + ", Luar Negeri: " + ((data['JumlahKantordiluarnegeri'] == "") ? "-" : data['JumlahKantordiluarnegeri']) : data['JumlahKantordiIndonesia'],
        },
        if(subKategoriId == '30' || subKategoriId == '32')
          {
            'icon': 'assets/detail_compro_buyer/ic_cakupan_layanan_detail_buyer.svg',
            'label': "Cakupan Layanan",
            'value': cakupanLayanan.isNotEmpty ? cakupanLayanan.join(" - ") : "-",
          },
        {
          'icon': 'assets/detail_compro_buyer/ic_tahun_berdiri_detail_buyer.svg',
          'label': "Tahun Berdiri",
          'value': data['TahunBerdiri'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_website_buyer.svg',
          'label': "Website",
          'value': data['Website'],
        },
      ];
    }
    // Octa10 >

    // Pras10 <
    // Pras10 >

    // Refo10 <
    //giorno
     else if (
      subKategoriId == '34' // Transportasi Intermoda | 3 - 5 Company
    ) {
      return [
        {
          'icon': 'assets/detail_compro_buyer/ic_alamat_detail_buyer.svg',
          'label': "Alamat",
          'value': data['Alamat'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_tingkat_layanan_buyer.svg',
          'label': "Tingkat Layanan",
          'value': data['TingkatLayanan'] == "" ? '-' : data['TingkatLayanan'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_tahun_berdiri_detail_buyer.svg',
          'label': "Tahun Berdiri",
          'value': data['TahunBerdiri'],
        },
        {

          'icon': 'assets/detail_compro_buyer/ic_website_buyer.svg',
          'label': "Website",
          'value': data['Website'],
        },
      ];
    }
    else if (
       subKategoriId == '33' // Transportasi Intermoda | Freight Forwarding
    ) {
      List cakupanLayanan;

      try {
        cakupanLayanan = jsonDecode(data['CangkupanLayanan']);
      
      } catch (e) { }

      return [
        {
          'icon': 'assets/detail_compro_buyer/ic_alamat_detail_buyer.svg',
          'label': "Alamat",
          'value': data['Alamat'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_agen_buyer.svg',
          'label': "Agen Dari Perusahaan",
          'value': data['AgenDariPerusahaan'] == "" ? '-' : data['AgenDariPerusahaan'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_cakupan_layanan_detail_buyer.svg',
          'label': "Cakupan Layanan",
          'value': cakupanLayanan.join(" - "),
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_jumlah_kantor_detail_buyer.svg',
          'label': (subKategoriId == '30' || subKategoriId == '32') ? "Jumlah Kantor" : "Jumlah Kantor Di Indonesia",
          'value': (subKategoriId == '30' || subKategoriId == '32') ? "Indonesia: " + data['JumlahKantordiIndonesia'] + ", Luar Negeri: " + data['JumlahKantordiluarnegeri'] : data['JumlahKantordiIndonesia'],
        },
        if(subKategoriId == '30' || subKategoriId == '32')
          {
            'icon': 'assets/detail_compro_buyer/ic_cakupan_layanan_detail_buyer.svg',
            'label': "Cakupan Layanan",
            'value': cakupanLayanan.join(" - "),
          },
        {
          'icon': 'assets/detail_compro_buyer/ic_tahun_berdiri_detail_buyer.svg',
          'label': "Tahun Berdiri",
          'value': data['TahunBerdiri'],
        },
        {
          'icon': 'assets/detail_compro_buyer/ic_website_buyer.svg',
          'label': "Website",
          'value': data['Website'],
        },
      ];
    }
    // Refo10 >

    return [];
  }

  // Sorting
  static List<Map<String, dynamic>> getSortingDataBySubKategoriId(subKategoriId) {
    // Transportation Store | Kendaraan Kargo
    if (subKategoriId == '37') {
      return [
        {
          'id': 'Created',
          'name': "Waktu Dibuat",
          'child': [
            {'id': "desc", 'name': "Terbaru"},
            {'id': "asc", 'name': "Terlama"},
          ],
        },
        {
          'id': 'Harga',
          'name': "Harga",
          'child':  [
            {'id': "desc", 'name': "Tertinggi"},
            {'id': "asc", 'name': "Terendah"},
          ],
        },
        {
          'id': 'TahunKendaraan',
          'name': "Tahun",
          'child': [
            {'id': "desc", 'name': "Terbaru"},
            {'id': "asc", 'name': "Terlama"},
          ],
        },
      ];
    }
    else if (
      subKategoriId == '36' // Transportation Store | BAN
      || subKategoriId == '42' // Transportation Store | Semi Trailer Carrier
      || subKategoriId == '43' // Transportation Store | Rigid Truck Carrier
      || subKategoriId == '38' // Transportation Store | AKI
      || subKategoriId == '39' // Transportation Store | OLI
      || subKategoriId == '44' // Transportation Store | Suku Cadang
      || subKategoriId == '45' // Transportation Store | Peralatan Angkutan
      || subKategoriId == '47' // Transportation Store | Produk Lainnya
      || subKategoriId == '15' // Property & Warehouse | Gudang Dijual
      // Andy11 <
      // Andy11 >

      // Khabib11 < 
      || subKategoriId == '26' // Dealer & Karoseri | Katalog Produk Karoseri
      || subKategoriId == '27' // Dealer & Karoseri | Katalog Produk Karoseri
      // Khabib11 >

      // Octa11 <
      || subKategoriId == '16' // Property & Warehouse | Gudang Disewakan
      // Octa11 >

      // Pras11 <
      || subKategoriId == '35' // Transportasi Intermoda | Produk Lainnya
      || subKategoriId == '13' // Repair & Maintenance | Produk Lainnya
      || subKategoriId == '52' // Human Capital | Produk Lainnya
      // Pras11 >

      // Refo11 <
      || subKategoriId == '41' // Transportation Store | Container
      || subKategoriId == '20' // Property & Warehouse | Peralatan Gudang
      || subKategoriId == '21' // Property & Warehouse | Katalog Produk Lainnya
      || subKategoriId == '37' // Transportation Store | Kendaraan Kargo
      // Refo11 >
    ) {
      return [
        {
          'id': 'Created',
          'name': "Waktu Dibuat",
          'child': [
            {'id': "desc", 'name': "Terbaru"},
            {'id': "asc", 'name': "Terlama"},
          ],
        },
        {
          'id': 'Harga',
          'name': "Harga",
          'child': [
            {'id': "desc", 'name': "Tertinggi"},
            {'id': "asc", 'name': "Terendah"},
          ],
        },
      ];
    }
    else if (
      subKategoriId == '23' // Dealer & Karoseri | Dealer
      || subKategoriId == '25' // Dealer & Karoseri | Perusahaan Karoseri
      //PRAS>
      || subKategoriId == '14' // Dealer & Karoseri | Perusahaan Karoseri
      || subKategoriId == '53' // Human Capital | Perusahaan Lainnya
      //PRAS<

      // Andy <
      || subKategoriId == '49' // Places & Promo | Places
      // Andy >
    ) {
      return [
        {
          'id': 'Created',
          'name': "Waktu Dibuat",
          'child': [
            {'id': "desc", 'name': "Terbaru"},
            {'id': "asc", 'name': "Terlama"},
          ],
        },
        {
          'id': 'NamaPerusahaan',
          'name': "Alfabet",
          'child': [
            {'id': "asc", 'name': "A-Z"},
            {'id': "desc", 'name': "Z-A"},
          ],
        },
      ];
    }
    // Property & Warehouse | Gudang Barang Cair
    else if (subKategoriId == '17') {
      return [
        {
          'id': 'Created',
          'name': "Waktu Dibuat",
          'child': [
            {'id': "desc", 'name': "Terbaru"},
            {'id': "asc", 'name': "Terlama"},
          ],
        },
        {
          'id': 'DetailTangki_Jumlah_Tangki',
          'name': "Jumlah Tangki",
          'child': [
            {'id': "desc", 'name': "Tertinggi"},
            {'id': "asc", 'name': "Terendah"},
          ],
        },
      ];
    }
    // Andy12 <
    // Andy12 >

    // Khabib12 < 
    else if (
      subKategoriId == '24' // Dealer & Karoseri | Katalog Produk Dealer
    ) {
      return [
        {
          'id': 'Created',
          'name': "Waktu Dibuat",
          'child': [
            {'id': "desc", 'name': "Terbaru"},
            {'id': "asc", 'name': "Terlama"},
          ],
        },
        {
          'id': 'Harga_harga',
          'name': "Harga",
          'child': [
            {'id': "desc", 'name': "Tertinggi"},
            {'id': "asc", 'name': "Terendah"},
          ],
        },
      ];
    }
    else if (
      subKategoriId == '54' // Human Capital | Lowongan Professional
    ) {
      return [
        {
          'id': 'Created',
          'name': "Waktu Dibuat",
          'child': [
            {'id': "desc", 'name': "Terbaru"},
            {'id': "asc", 'name': "Terlama"},
          ],
        },
        {
          'id': 'Salary',
          'name': "Estimasi Gaji",
          'child': [
            {'id': "desc", 'name': "Tertinggi"},
            {'id': "asc", 'name': "Terendah"},
          ],
        },
      ];
    }
    // Khabib12 >

    // Octa12 <
    else if (
      subKategoriId == '29' // Transportasi Intermoda | Road Transportation
      || subKategoriId == '31' // Transportasi Intermoda | Rail Freight
    ) {
      return [
        {
          'id': 'Created',
          'name': "Waktu Dibuat",
          'child': [
            {'id': "desc", 'name': "Terbaru"},
            {'id': "asc", 'name': "Terlama"},
          ],
        },
        {
          'id': 'JumlahKantordiIndonesia',
          'name': "Jumlah Kantor Di Indonesia",
          'child': [
            {'id': "desc", 'name': "Tertinggi"},
            {'id': "asc", 'name': "Terendah"},
          ],
        },
      ];
    }
    else if (
      subKategoriId == '30' // Transportasi Intermoda | Air Freight
      || subKategoriId == '32' // Transportasi Intermoda | Sea Freight
    ) {
      return [
        {
          'id': 'Created',
          'name': "Waktu Dibuat",
          'child': [
            {'id': "desc", 'name': "Terbaru"},
            {'id': "asc", 'name': "Terlama"},
          ],
        },
        {
          'id': 'JumlahKantordiIndonesia',
          'name': "Jumlah Kantor Di Indonesia",
          'child': [
            {'id': "desc", 'name': "Tertinggi"},
            {'id': "asc", 'name': "Terendah"},
          ],
        },
        {
          'id': 'JumlahKantordiluarnegeri',
          'name': "Jumlah Kantor Di Luar Negeri",
          'child': [
            {'id': "desc", 'name': "Tertinggi"},
            {'id': "asc", 'name': "Terendah"},
          ],
        },
      ];
    }
    // Octa12 >

    // Pras12 <
    // Pras12 >

    // Refo12 <
     else if (
      subKategoriId == '33' // Transportasi Intermoda | Freight Forwarding
    ) {
      return [
        {
          'id': 'Created',
          'name': "Waktu Dibuat",
          'child': [
            {'id': "desc", 'name': "Terbaru"},
            {'id': "asc", 'name': "Terlama"},
          ],
        },
        {
          'id': 'JumlahKantordiIndonesia',
          'name': "Jumlah Kantor Di Indonesia",
          'child': [
            {'id': "desc", 'name': "Tertinggi"},
            {'id': "asc", 'name': "Terendah"},
          ],
        },
        // {
        //   'id': 'JumlahKantordiluarnegeri',
        //   'name': "Jumlah Kantor Di Luar Negeri",
        //   'child': [
        //     {'id': "desc", 'name': "Tertinggi"},
        //     {'id': "asc", 'name': "Terendah"},
        //   ],
        // },
      ];
    }
    else if (
    subKategoriId == '34' // Transportasi Intermoda | 3 - 5 Company
    || subKategoriId == '11' // Repair & Maintenance | Bengkel
    ) {
      return [
        {
          'id': 'Created',
          'name': "Waktu Dibuat",
          'child': [
            {'id': "desc", 'name': "Terbaru"},
            {'id': "asc", 'name': "Terlama"},
          ],
        },
      ];
    }
    // Refo12 >

    return [
      {
        'id': 'Created',
        'name': "Waktu Dibuat",
        'child': [
          {'id': "desc", 'name': "Terbaru"},
          {'id': "asc", 'name': "Terlama"},
        ],
      },
    ];
  }

  // Filter
  static List<Map> getFilterDataBySubKategoriId(subKategoriId) {
    // Transportation Store | Kendaraan Kargo
    if (subKategoriId == '37') {
      return [
        {
          'key': 'Kondisi',
          'title': 'Kondisi Kendaraan',
          'KategoriID': 21,
          'SubKategoriID': 37,
          'tag_frontend': "kondisi_kendaraan_kargo-radiofield",
        },
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 21,
          'SubKategoriID': 37,
          'tag_frontend': "lokasi_kendaraan_kargo-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 21,
          'SubKategoriID': 37,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': 'Harga_terendah', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "rentang_harga_kendaraan_kargo-rangefield",
        },
        {
          'key': 'TahunKendaraan',
          'title': 'Tahun Produksi',
          'KategoriID': 21,
          'SubKategoriID': 37,
          'min_value': "1970",
          'max_value': "${DateFormat('yyyy').format(DateTime.now())}",
          'tag_frontend': "tahun_kendaraan_kargo-rangefield",
          'withoutSeparator': true,
          'number_type': NumberType.YEAR
        },
        {
          'key': 'JarakTempuh',
          'title': 'Kilometer (km)',
          'KategoriID': 21,
          'SubKategoriID': 37,
          'min_value': "0",
          'max_value': "100000",
          'tag_frontend': "kilometer_kendaraan_kargo-rangefield",
        },
        {
          'key': 'Merk',
          'title': 'Merk',
          'KategoriID': 21,
          'SubKategoriID': 37,
          'tag_frontend': "merk_kendaraan_kargo-checkboxfield",
        },
        {
          'key': 'JenisTrukCarrier_jenis_truk',
          'title': null,
          'KategoriID': 21,
          'SubKategoriID': 37,
          'tag_frontend': "jenis_truck_kendaraan_kargo-truckcarrierdropdowndouble",
          'group_by_title': 'Jenis Truk dan Carrier'
        },
        {
          'key': 'JenisTrukCarrier_jenis_carrier',
          'title': null,
          'KategoriID': 21,
          'SubKategoriID': 37,
          'tag_frontend': "jenis_carrier_kendaraan_kargo-truckcarrierdropdowndouble",
          'group_by_title': 'Jenis Truk dan Carrier'
        },
        {
          'key': 'KapasitasMesin',
          'title': 'Kapasitas Mesin',
          'KategoriID': 21,
          'SubKategoriID': 37,
          'tag_frontend': "kapasitas_mesin_kendaraan_kargo-checkboxfield",
        },
        {
          'key': 'Warna',
          'title': 'Warna',
          'KategoriID': 21,
          'SubKategoriID': 37,
          'tag_frontend': "warna_kendaraan_kargo-checkboxfield",
        },
        {
          'key': 'tipe_penjual',
          'title': 'Tipe Penjual',
          'KategoriID': 107,
          'SubKategoriID': 37,
          'tag_frontend': "tipe_penjual-checkboxfield",
          'value_alias': "Individu,Perusahaan",
          'value': "0,1",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 107,
          'SubKategoriID': 37,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Transportation Store | BAN
    else if (subKategoriId == '36') {
      return [
        {
          'key': 'KondisiBan',
          'title': 'Kondisi Ban',
          'KategoriID': 48,
          'SubKategoriID': 36,
          'tag_frontend': "kondisi_ban-radiofield",
        },
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 48,
          'SubKategoriID': 36,
          'tag_frontend': "lokasi_ban-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 48,
          'SubKategoriID': 36,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "harga_ban-rangefield",
        },
        {
          'key': 'TipeBan',
          'title': 'Tipe Ban',
          'KategoriID': 48,
          'SubKategoriID': 36,
          'tag_frontend': "tipe_ban-checkboxfield",
        },
        {
          'key': 'tipe_penjual',
          'title': 'Tipe Penjual',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'tag_frontend': "tipe_penjual-checkboxfield",
          'value_alias': "Individu,Perusahaan",
          'value': "0,1",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Dealer & Karoseri | Dealer
    else if (subKategoriId == '23') {
      return [
        {
          'key': 'lokasi',
          'title': 'Lokasi',
          'KategoriID': 40,
          'SubKategoriID': 23,
          'tag_frontend': "lokasi_ban-lokasifield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 40,
          'SubKategoriID': 23,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Transportation Store | Semi Trailer Carrier
    else if (subKategoriId == '42') {
      return [
        {
          'key': 'Kondisi',
          'title': 'Kondisi Semi Trailer',
          'KategoriID': 22,
          'SubKategoriID': 42,
          'tag_frontend': "kondisi_semi_trailer-radiofield",
        },
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 22,
          'SubKategoriID': 42,
          'tag_frontend': "lokasi_semi_trailer-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 22,
          'SubKategoriID': 42,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "harga_semi_trailer-rangefield",
        },
        {
          'key': 'JenisSemiTrailerCarrier',
          'title': 'Jenis Semi Trailer Carrier',
          'KategoriID': 22,
          'SubKategoriID': 42,
          'tag_frontend': "jenis_carrier_semi_trailer-checkboxfield",
        },
        {
          'key': 'tipe_penjual',
          'title': 'Tipe Penjual',
          'KategoriID': 22,
          'SubKategoriID': 42,
          'tag_frontend': "tipe_penjual-checkboxfield",
          'value_alias': "Individu,Perusahaan",
          'value': "0,1",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 22,
          'SubKategoriID': 42,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Transportation Store | Rigid Truck Carrier
    else if (subKategoriId == '43') {
      return [
        {
          'key': 'Kondisi',
          'title': 'Kondisi Rigid Truck Carrier',
          'KategoriID': 22,
          'SubKategoriID': 43,
          'tag_frontend': "kondisi_rigid_truck-radiofield",
        },
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 22,
          'SubKategoriID': 43,
          'tag_frontend': "lokasi_rigid_truck-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 22,
          'SubKategoriID': 43,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "harga_iklan_rigid_truck-rangefield"
        },
        {
          'key': 'JenisCarrier',
          'title': 'Jenis Carrier Rigid',
          'KategoriID': 22,
          'SubKategoriID': 43,
          'tag_frontend': "jenis_carrier_rigid_truck-checkboxfield",
        },
        {
          'key': 'tipe_penjual',
          'title': 'Tipe Penjual',
          'KategoriID': 22,
          'SubKategoriID': 43,
          'tag_frontend': "tipe_penjual-checkboxfield",
          'value_alias': "Individu,Perusahaan",
          'value': "0,1",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 22,
          'SubKategoriID': 43,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Transportation Store | Peralatan Angkutan
    else if (subKategoriId == '45') {
      return [
        {
          'key': 'Kondisi',
          'title': 'Kondisi Peralatan Angkutan',
          'KategoriID': 51,
          'SubKategoriID': 45,
          'tag_frontend': "kondisi_peralatan_angkutan-radiofield"
        },
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 51,
          'SubKategoriID': 45,
          'tag_frontend': "lokasi_peralatan_angkutan-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 51,
          'SubKategoriID': 45,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "harga_iklan_peralatan_angkutan-rangefield",
        },
        {
          'key': 'tipe_penjual',
          'title': 'Tipe Penjual',
          'KategoriID': 51,
          'SubKategoriID': 45,
          'tag_frontend': "tipe_penjual-checkboxfield",
          'value_alias': "Individu,Perusahaan",
          'value': "0,1",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 51,
          'SubKategoriID': 45,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Transportation Store | AKI
    else if (subKategoriId == '38') {
      return [
        {
          'key': 'Kondisi',
          'title': 'Kondisi Aki',
          'KategoriID': 51,
          'SubKategoriID': 45,
          'tag_frontend': "kondisi_aki-radiofield",
        },
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'tag_frontend': "lokasi_aki-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "harga_iklan_aki-rangefield",
        },
        {
          'key': 'JenisAki',
          'title': 'Jenis Aki',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'tag_frontend': "jenis_aki-checkboxfield",
        },
        {
          'key': 'Merk',
          'title': 'Merk',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'tag_frontend': "merk_aki-checkboxfield",
        },
        {
          'key': 'PanjangAki',
          'header': 'Dimensi',
          'title': 'Panjang (cm)',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'PanjangAki', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "panjang_aki-rangefield",
        },
        {
          'key': 'LebarAki',
          'header': 'Dimensi',
          'title': 'Lebar (cm)',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'LebarAki', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "lebar_aki-rangefield",
        },
        {
          'key': 'TinggiAki',
          'header': 'Dimensi',
          'title': 'Tinggi (cm)',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TinggiAki', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tinggi_aki-rangefield",
        },
        {
          'key': 'Tegangan',
          'title': 'Volt',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'tag_frontend': "tegangan_aki-smarttextfielddouble",
          'group_by_title': 'Tegangan'
        },
        {
          'key': 'Kapasitas',
          'title': 'Ampere',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'tag_frontend': "kapasitas_aki-smarttextfielddouble",
          'group_by_title': 'Tegangan'
        },
        {
          'key': 'tipe_penjual',
          'title': 'Tipe Penjual',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'tag_frontend': "tipe_penjual-checkboxfield",  
          'value_alias': "Individu,Perusahaan",
          'value': "0,1",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 48,
          'SubKategoriID': 38,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Transportation Store | OLI
    else if (subKategoriId == '39') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 48,
          'SubKategoriID': 39,
          'tag_frontend': "lokasi_oli-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 48,
          'SubKategoriID': 39,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "harga_iklan_oli_filter-rangefield",
        },
        {
          'key': 'JenisOli',
          'title': 'Jenis Pelumas',
          'KategoriID': 48,
          'SubKategoriID': 39,
          'tag_frontend': "jenis_oli_filter-checkboxfield",
        },
        {
          'key': 'Volume',
          'title': 'Volume (liter)',
          'KategoriID': 48,
          'SubKategoriID': 39,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Volume', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "volume_oli_filter-rangefield",
        },
        {
          'key': 'tipe_penjual',
          'title': 'Tipe Penjual',
          'KategoriID': 48,
          'SubKategoriID': 39,
          'tag_frontend': "tipe_penjual-checkboxfield",
          'value_alias': "Individu,Perusahaan",
          'value': "0,1",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 48,
          'SubKategoriID': 39,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Transportation Store | Suku Cadang
    else if (subKategoriId == '44') {
      return [
        {
          'key': 'Kondisi',
          'title': 'Kondisi Suku Cadang',
          'KategoriID': 50,
          'SubKategoriID': 44,
          'tag_frontend': "kondisi_suku_cadang-radiofield",
        },
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 50,
          'SubKategoriID': 44,
          'tag_frontend': "lokasi_oli-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 50,
          'SubKategoriID': 44,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "harga_iklan_suku_cadang-rangefield",
        },
        {
          'key': 'JenisSukuCadang',
          'title': 'Jenis Suku Cadang',
          'KategoriID': 50,
          'SubKategoriID': 44,
          'tag_frontend': "jenis_suku_cadang-checkboxfield",
        },
        {
          'key': 'Merk',
          'title': 'Merk',
          'KategoriID': 50,
          'SubKategoriID': 44,
          'tag_frontend': "merk_suku_cadang-checkboxfield",
        },
        {
          'key': 'tipe_penjual',
          'title': 'Tipe Penjual',
          'KategoriID': 50,
          'SubKategoriID': 44,
          'tag_frontend': "tipe_penjual-checkboxfield",
          'value_alias': "Individu,Perusahaan",
          'value': "0,1",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 50,
          'SubKategoriID': 44,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Transportation Store | Toko Suku Cadang
    else if (subKategoriId == '46') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 49,
          'SubKategoriID': 46,
          'tag_frontend': "lokasi_toko_suku_cadang-lokasifield",
        },
        {
          'key': 'JenisSukuCadangyangDijual',
          'title': 'Jenis Suku Cadang',
          'KategoriID': 49,
          'SubKategoriID': 46,
          'tag_frontend': "jenis_toko_suku_cadang-checkboxfield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 49,
          'SubKategoriID': 46,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    //Pras >
    else if (
      subKategoriId == '47' // Transportation Store | Produk Lainnya
      || subKategoriId == '27' // Dealer & Karoseri | Produk Lainnya
      || subKategoriId == '35' // Transportasi Intermoda | Produk Lainnya
      || subKategoriId == '13' // Repair & Maintenance | Produk Lainnya
      || subKategoriId == '52' // Human Capital | Produk Lainnya
    ) {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'tag_frontend': "lokasi_iklan_produk_lainnya-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'min_value': '0',
          'max_value': '1000000000',
          'dynamic_min_key': '-',
          'dynamic_max_key': 'Harga',
          'tag_frontend': "harga_produk_lainnya-rangefield",
        },
        {
          'key': 'verified', 
          'title': 'Opsi Penjual',
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    //  PRas <
    // Properti & Warehouse | Gudang Barang Cair
    else if (subKategoriId == '17') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 28,
          'SubKategoriID': 17,
          'tag_frontend': "lokasi_gudang_tangki-lokasifield",
        },
        {
          'key': 'TahunBerdiri',
          'title': 'Tahun Berdiri',
          'KategoriID': 28,
          'SubKategoriID': 17,
          'min_value': "1970",
          'max_value': DateTime.now().year.toString(),
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunBerdiri', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_berdiri_gudang_tangki_hard-rangefield",
          'number_type': NumberType.YEAR
        },
        {
          'key': 'DetailTangki_Jumlah_Tangki',
          'title': 'Jumlah Tangki',
          'KategoriID': 28,
          'SubKategoriID': 17,
          'min_value': "0",
          'max_value': "1000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'DetailTangki_Jumlah_Tangki', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "jumlah_tangki_gudang_tangki-rangefield",
        },
        {
          'key': 'DetailTangki_Tipe_Tangki',
          'title': 'Tipe Tangki',
          'KategoriID': 28,
          'SubKategoriID': 17,
          'tag_frontend': "tipe_tangki_gudang_tangki-checkboxfield",
        },
        {
          'key': 'MampuMenanganiBarang',
          'title': 'Mampu Menangani Barang',
          'KategoriID': 28,
          'SubKategoriID': 17,
          'tag_frontend': "mampu_menangani_gudang_tangki-checkboxfield",
        },
        {
          'key': 'Layanan',
          'title': 'Layanan',
          'KategoriID': 28,
          'SubKategoriID': 17,
          'tag_frontend': "layanan_gudang_tangki-checkboxfield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 107,
          'SubKategoriID': 37,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Property & Warehouse | Gudang Dijual
    else if (subKategoriId == '15') {
      return [
        {
          'key': 'TipeProperti',
          'title': 'Tipe Properti',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'tag_frontend': "tipe_properti_gudang_dijual-checkboxfield"
        },
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'tag_frontend': "lokasi_gudang_dijual-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "harga_iklan_gudang_dijual-rangefield",
        },
        {
          'key': 'TahunDibangun',
          'title': 'Tahun Dibangun',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunDibangun', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_dibangun_gudang_dijual-rangefield",
          'number_type': NumberType.YEAR
        },
        {
          'key': 'TahunRenov',
          'title': 'Tahun Terakhir Renovasi',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunRenov', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_terakhir_renovasi_gudang_dijual-rangefield",
          'number_type': NumberType.YEAR
        },
        // ADA MASALAH
        {
          'key': 'LuasTanah',
          'title': 'Luas Tanah (m²)',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'LuasTanah', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "luas_tanah_gudang_dijual-rangefield",
        },
        {
          'key': 'LuasBangunan',
          'title': 'Luas Bangunan (m²)',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'LuasBangunan', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "luas_bangunan_gudang_dijual-rangefield",
        },
        {
          'key': 'DayaListrik',
          'title': 'Daya Listrik (Watt)',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'DayaListrik', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "watt_gudang_dijual-rangefield",
        },
        // ADA MASALAH
        {
          'key': 'LebarJalan',
          'title': 'Lebar Jalan (m)',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'LebarJalan', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "lebar_jalan_gudang_dijual-rangefield",
        },
        {
          'key': 'Hadap',
          'title': 'Hadap',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'tag_frontend': "hadap_gudang_dijual-checkboxfield"
        },
        {
          'key': 'Fasilitas',
          'title': 'Fasilitas',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'tag_frontend': "fasilitas_gudang_dijual-checkboxfield"
        },
        {
          'key': 'BarangKhusus',
          'title': 'Barang Khusus yang dapat Disimpan',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'tag_frontend': "barang_khusus_gudang_dijual-checkboxfield"
        },
        {
          'key': 'KendaraanYangLewat',
          'title': 'Kendaraan yang dapat Lewat',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'tag_frontend': "kendaraan_dapat_lewat_gudang_dijual-checkboxfield"
        },
        {
          'key': 'tipe_penjual',
          'title': 'Tipe Penjual',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'tag_frontend': "tipe_penjual-checkboxfield",
          'value_alias': "Individu,Perusahaan/Badan Hukum Lainnya",
          'value': "0,1",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 26,
          'SubKategoriID': 15,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi",
          'value': "1",
        },
      ];
    }

    // Andy13 <
    // Transportasi Intermoda | Sea Freight
    else if (subKategoriId == '32') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 36,
          'SubKategoriID': 32,
          'tag_frontend': "lokasi_sea_freight-lokasifield",
        },
        {
          'key': 'CakupanLayanan',
          'title': 'Cakupan Layanan',
          'KategoriID': 36,
          'SubKategoriID': 32,
          'tag_frontend': "cakupan_layanan_sea_freight-checkboxfield",
        },
        // Rute yang Dilayani [PENDING]
        {
          'key': 'TahunBerdiri',
          'title': 'Tahun Berdiri',
          'KategoriID': 36,
          'SubKategoriID': 32,
          'min_value': "1970",
          'max_value': DateTime.now().year.toString(),
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunBerdiri', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_berdiri_jasa_sea_freight-rangefield",
          'number_type': NumberType.YEAR
        },
        {
          'key': 'JumlahKantordiIndonesia',
          'title': 'Jumlah Kantor di Indonesia',
          'KategoriID': 36,
          'SubKategoriID': 32,
          'min_value': '0',
          'max_value': '1000',
          'dynamic_min_key': '-',
          'dynamic_max_key': 'JumlahKantordiIndonesia',
          'tag_frontend': "jumlah_kantor_indonesia_sea_freight-rangefield",
        },
        {
          'key': 'JumlahKantordiluarnegeri',
          'title': 'Jumlah Kantor di Luar Negeri',
          'KategoriID': 36,
          'SubKategoriID': 32,
          'min_value': '0',
          'max_value': '1000',
          'dynamic_min_key': '-',
          'dynamic_max_key': 'JumlahKantordiluarnegeri',
          'tag_frontend': "jumlah_kantor_luar_sea_freight-rangefield",
        },
      ];
    }
    // Repair & Maintenance | Teknisi
    else if (subKategoriId == '12') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 24,
          'SubKategoriID': 12,
          'tag_frontend': "lokasi_teknisi-lokasifield",
        },
        {
          'key': 'MerkYangDilayani',
          'title': 'Merk yang Dilayani',
          'KategoriID': 24,
          'SubKategoriID': 12,
          'tag_frontend': "merk_dilayani_teknisi-checkboxfield",
        },
        {
          'key': 'JenisServis',
          'title': 'Layanan/Jenis Service',
          'KategoriID': 24,
          'SubKategoriID': 12,
          'tag_frontend': "jenis_servis_teknisi-checkboxfield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penyedia Jasa',
          'KategoriID': 24,
          'SubKategoriID': 12,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Teknisi yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    else if (subKategoriId == '57') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 46,
          'SubKategoriID': 57,
          'tag_frontend': "lokasi_teknisi-lokasifield",
        },
        {
          'key': 'Layanan',
          'title': 'Layanan',
          'KategoriID': 46,
          'SubKategoriID': 57,
          'tag_frontend': "layanan_hr_training-checkboxfield"
        },
      ];
    }
    // Andy13 >

    // Khabib13 < 
    // Dealer & Karoseri | Katalog Produk Dealer
    else if (
      subKategoriId == '24'
    ) {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 40,
          'SubKategoriID': 24,
          'tag_frontend': "lokasi_karoseri-lokasifield",
        },
        {
          'key': 'Harga_harga',
          'title': 'Rentang Harga',
          'KategoriID': 40,
          'SubKategoriID': 24,
          'min_value': '0',
          'max_value': '1000000000',
          'dynamic_min_key': '-',
          'dynamic_max_key': 'Harga_harga',
          'tag_frontend': "harga_produk_dealer-rangefield",
        },
        {
          'key': 'JenisTruk',
          'title': 'Jenis Truk',
          'KategoriID': 40,
          'SubKategoriID': 24,
          'tag_frontend': "jenis_truck_katalog_dealer-checkboxfield",
        },
        {
          'key': 'OutputHP',
          'title': 'Output Engine Power (HP/PS)',
          'KategoriID': 40,
          'SubKategoriID': 24,
          'min_value': '0',
          'max_value': '1000000000',
          'dynamic_min_key': '-',
          'dynamic_max_key': 'OutputHP',
          'tag_frontend': "outputhp_produk_dealer-rangefield",
        },
        {
          'key': 'CocokUntukTipeBody',
          'title': 'Cocok Untuk Karoseri',
          'KategoriID': 40,
          'SubKategoriID': 24,
          'tag_frontend': "cocok_katalog_dealer-checkboxfield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 40,
          'SubKategoriID': 24,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Dealer & Karoseri | Karoseri
    else if (subKategoriId == '25') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 41,
          'SubKategoriID': 25,
          'tag_frontend': "lokasi_karoseri-lokasifield",
        },
        {
          'key': 'JenisKaroseri',
          'title': 'Jenis Karoseri yang Dilayani',
          'KategoriID': 41,
          'SubKategoriID': 25,
          'tag_frontend': "jenis_katalog_karoseri-checkboxfield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 40,
          'SubKategoriID': 23,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Dealer & Karoseri | Katalog Produk Karoseri
    else if (
      subKategoriId == '26'
    ) {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 40,
          'SubKategoriID': 24,
          'tag_frontend': "lokasi_karoseri-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 40,
          'SubKategoriID': 24,
          'min_value': '0',
          'max_value': '1000000000',
          'dynamic_min_key': '-',
          'dynamic_max_key': 'Harga',
          'tag_frontend': "harga_produk_karoseri-rangefield",
        },
        {
          'key': 'JenisKaroseri',
          'title': 'Jenis Karoseri yang Dilayani',
          'KategoriID': 41,
          'SubKategoriID': 25,
          'tag_frontend': "jenis_katalog_karoseri-checkboxfield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 41,
          'SubKategoriID': 25,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Human Capital | Lowongan Professional
    else if (
      subKategoriId == '54' // Human Capital | Lowongan Professional
    ) {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'tag_frontend': "lokasi_loker-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Estimasi Gaji',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'min_value': '0',
          'max_value': '1000000000',
          'dynamic_min_key': '-',
          'dynamic_max_key': 'Harga_estimasi_akhir',
          'tag_frontend': "harga_produk_karoseri-rangefield",
        },
        {
          'key': 'BatasanUmur',
          'title': 'Batasan Umur',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'min_value': '0',
          'max_value': '60',
          // 'dynamic_min_key': '-',
          // 'dynamic_max_key': 'BatasanUmur',
          'tag_frontend': "harga_produk_karoseri-rangefield",
        },
        {
          'key': 'MinimumPengalaman',
          'title': 'Pengalaman Kerja',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'min_value': '0',
          'max_value': '30',
          // 'dynamic_min_key': '-',
          // 'dynamic_max_key': 'BatasanUmur',
          'tag_frontend': "minimum_pengalaman_lowongan_professional-rangefield",
        },
        {
          'key': 'TipePekerjaan',
          'title': 'Tipe Pekerjaan',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'tag_frontend': "tipe_pekerjaan_lowongan_professional-checkboxfield",
        },
        {
          'key': 'SistemKerja',
          'title': 'Sistem Kerja',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'tag_frontend': "sistem_kerja_lowongan_professional-checkboxfield",
        },
        {
          'key': 'JenisKelamin',
          'title': 'Jenis Kelamin',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'tag_frontend': "jenis_kelamin_lowongan_professional-checkboxfield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Human Capital | Lowongan Umum
    else if (
      subKategoriId == '55' // Human Capital | Lowongan Umum
    ) {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'tag_frontend': "lokasi_loker-lokasifield",
        },
        {
          'key': 'MinimumPengalaman',
          'title': 'Pengalaman Kerja',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'min_value': '0',
          'max_value': '30',
          // 'dynamic_min_key': '-',
          // 'dynamic_max_key': 'BatasanUmur',
          'tag_frontend': "minimum_pengalaman_lowongan_professional-rangefield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Human Capital | Job Seekers
    else if (
      subKategoriId == '56' // Human Capital | Job Seekers
    ) {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Preferensi Lokasi Kerja',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'tag_frontend': "lokasi_loker-lokasifield",
        },
        {
          'key': 'PengalamanKerja',
          'title': 'Pengalaman Kerja',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'min_value': '0',
          'max_value': '30',
          // 'dynamic_min_key': '-',
          // 'dynamic_max_key': 'BatasanUmur',
          'tag_frontend': "pengalaman_kerja-rangefield",
        },
        {
          'key': 'Umur',
          'title': 'Batasan Umur',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'min_value': '0',
          'max_value': '60',
          'dynamic_min_key': '-',
          'dynamic_max_key': 'Umur',
          'tag_frontend': "harga_produk_karoseri-rangefield",
        },
        {
          'key': 'JenisKelamin',
          'title': 'Jenis Kelamin',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'tag_frontend': "jenis_kelamin_lowongan_professional-checkboxfield",
        },
        {
          'key': 'JenjangPendidikan',
          'title': 'Tingkat Pendidikan',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'tag_frontend': "pendidikan_terakhir_job_seeker-checkboxfield",
          'value': "Sekolah Dasar (SD),Sekolah Menengah Pertama (SMP),SMU/SMK/STM,Diploma (D3),Sarjana (S1),Master (S2),Doktor (S3)",
        },
        {
          'key': 'PosisiPekerjaanTerakhir',
          'header': 'Cari Berdasarkan',
          'title': 'Profesionalitas',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'hint': "Contoh : General Manager",
          'tag_frontend': "posisi_pekerjaan_terakhir-checkboxfretextfield",
        },
        {
          'key': 'Keahlian',
          'header': 'Cari Berdasarkan',
          'title': 'Keahlian',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'hint': "Contoh : Mesin Bubut",
          'tag_frontend': "keahlian-checkboxfretextfield",
        },
        {
          'key': 'Bakat',
          'header': 'Cari Berdasarkan',
          'title': 'Bakat',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'hint': "Contoh : General Manager",
          'tag_frontend': "bakat-checkboxfretextfield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 43,
          'SubKategoriID': 54,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Khabib13 >

    // Octa13 <
    // Property & Warehouse | Gudang Disewakan
    else if (subKategoriId == '16') {
      return [
        {
          'key': 'TipeProperti',
          'title': 'Tipe Properti',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'tag_frontend': "tipe_properti_gudang_disewakan-checkboxfield"
        },
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'tag_frontend': "lokasi_gudang_disewakan-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "harga_iklan_gudang_disewakan-rangefield",
        },
        {
          'key': 'TahunDibangun',
          'title': 'Tahun Dibangun',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunDibangun', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_dibangun_gudang_disewakan-rangefield",
          'number_type': NumberType.YEAR
        },
        {
          'key': 'TahunRenov',
          'title': 'Tahun Terakhir Renovasi',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunRenov', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_terakhir_renovasi_gudang_disewakan-rangefield",
          'number_type': NumberType.YEAR
        },
        // ADA MASALAH
        {
          'key': 'LuasTanah',
          'title': 'Luas Tanah (m²)',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'LuasTanah', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "luas_tanah_gudang_disewakan-rangefield",
        },
        // ADA MASALAH
        {
          'key': 'LuasBangunan',
          'title': 'Luas Bangunan (m²)',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'LuasBangunan', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "luas_bangunan_gudang_disewakan-rangefield",
        },
        {
          'key': 'DayaListrik',
          'title': 'Daya Listrik (Watt)',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'DayaListrik', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "watt_gudang_disewakan-rangefield",
        },
        // ADA MASALAH
        {
          'key': 'LebarJalan',
          'title': 'Lebar Jalan (m)',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'LebarJalan', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "lebar_jalan_gudang_disewakan-rangefield",
        },
        {
          'key': 'Hadap',
          'title': 'Hadap',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'tag_frontend': "hadap_gudang_disewakan-checkboxfield"
        },
        {
          'key': 'Fasilitas',
          'title': 'Fasilitas',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'tag_frontend': "fasilitas_gudang_disewakan-checkboxfield"
        },
        {
          'key': 'BarangKhusus',
          'title': 'Barang Khusus yang dapat Disimpan',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'tag_frontend': "barang_khusus_gudang_disewakan-checkboxfield"
        },
        {
          'key': 'KendaraanYangLewat',
          'title': 'Kendaraan yang dapat Lewat',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'tag_frontend': "kendaraan_dapat_lewat_gudang_disewakan-checkboxfield"
        },
        {
          'key': 'tipe_penjual',
          'title': 'Tipe Penjual',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'tag_frontend': "tipe_penjual-checkboxfield",
          'value_alias': "Individu,Perusahaan/Badan Hukum Lainnya",
          'value': "0,1",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 27,
          'SubKategoriID': 16,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi",
          'value': "1",
        },
      ];
    }
    // Transportasi Intermoda | Road Transportation
    else if (subKategoriId == '29') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 33,
          'SubKategoriID': 29,
          'tag_frontend': "lokasi_road_transportation-lokasifield",
        },
        {
          'key': 'Ruteyangdilayani',
          'title': null,
          'KategoriID': 33,
          'SubKategoriID': 29,
          'tag_frontend': "rute_dilayani_road_transportation-dropdown-left",
          'group_by_title': 'Rute yang Dilayani'
        },
        {
          'key': 'Ruteyangdilayani',
          'title': null,
          'KategoriID': 33,
          'SubKategoriID': 29,
          'tag_frontend': "rute_dilayani_road_transportation-dropdown-right",
          'group_by_title': 'Rute yang Dilayani'
        },
        {
          'key': 'TahunBerdiri',
          'title': 'Tahun Berdiri',
          'KategoriID': 33,
          'SubKategoriID': 29,
          'min_value': "1970",
          'max_value': DateTime.now().year.toString(),
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunBerdiri', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_berdiri_jasa_road_transportation_hard-rangefield",
          'number_type': NumberType.YEAR
        },
        {
          'key': 'JumlahKantordiIndonesia',
          'title': 'Jumlah Kantor di Indonesia',
          'KategoriID': 33,
          'SubKategoriID': 29,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'JumlahKantordiIndonesia', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "jumlah_kantor_road_transportation-rangefield",
        },
      ];
    }
    // Transportasi Intermoda | Road Transportation
    else if (subKategoriId == '29') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 33,
          'SubKategoriID': 29,
          'tag_frontend': "lokasi_road_transportation-lokasifield",
        },
        {
          'key': 'Ruteyangdilayani',
          'title': null,
          'KategoriID': 33,
          'SubKategoriID': 29,
          'tag_frontend': "rute_dilayani_road_transportation-dropdown-left",
          'group_by_title': 'Rute yang Dilayani'
        },
        {
          'key': 'Ruteyangdilayani',
          'title': null,
          'KategoriID': 33,
          'SubKategoriID': 29,
          'tag_frontend': "rute_dilayani_road_transportation-dropdown-right",
          'group_by_title': 'Rute yang Dilayani'
        },
        {
          'key': 'TahunBerdiri',
          'title': 'Tahun Berdiri',
          'KategoriID': 33,
          'SubKategoriID': 29,
          'min_value': "1970",
          'max_value': DateTime.now().year.toString(),
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunBerdiri', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_berdiri_jasa_road_transportation_hard-rangefield",
          'number_type': NumberType.YEAR
        },
        {
          'key': 'JumlahKantordiIndonesia',
          'title': 'Jumlah Kantor di Indonesia',
          'KategoriID': 33,
          'SubKategoriID': 29,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'JumlahKantordiIndonesia', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "jumlah_kantor_road_transportation-rangefield",
        },
      ];
    }
    // Transportasi Intermoda | Road Transportation
    else if (subKategoriId == '29') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 33,
          'SubKategoriID': 29,
          'tag_frontend': "lokasi_road_transportation-lokasifield",
        },
        {
          'key': 'Ruteyangdilayani',
          'title': null,
          'KategoriID': 33,
          'SubKategoriID': 29,
          'tag_frontend': "rute_dilayani_road_transportation-dropdown-left",
          'group_by_title': 'Rute yang Dilayani'
        },
        {
          'key': 'Ruteyangdilayani',
          'title': null,
          'KategoriID': 33,
          'SubKategoriID': 29,
          'tag_frontend': "rute_dilayani_road_transportation-dropdown-right",
          'group_by_title': 'Rute yang Dilayani'
        },
        {
          'key': 'TahunBerdiri',
          'title': 'Tahun Berdiri',
          'KategoriID': 33,
          'SubKategoriID': 29,
          'min_value': "1970",
          'max_value': DateTime.now().year.toString(),
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunBerdiri', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_berdiri_jasa_road_transportation_hard-rangefield",
          'number_type': NumberType.YEAR
        },
        {
          'key': 'JumlahKantordiIndonesia',
          'title': 'Jumlah Kantor di Indonesia',
          'KategoriID': 33,
          'SubKategoriID': 29,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'JumlahKantordiIndonesia', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "jumlah_kantor_road_transportation-rangefield",
        },
      ];
    }
    // Transportasi Intermoda | Air Freight
    else if (subKategoriId == '30') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 34,
          'SubKategoriID': 30,
          'tag_frontend': "lokasi_air_freight-lokasifield",
        },
        {
          'key': 'CakupanLayanan',
          'title': 'Cakupan Layanan',
          'KategoriID': 34,
          'SubKategoriID': 30,
          'tag_frontend': "cangkupan_layanan_air_freight-checkboxfield"
        },
        {
          'key': 'Ruteyangdilayani',
          'title': null,
          'KategoriID': 34,
          'SubKategoriID': 30,
          'tag_frontend': "rute_dilayani_air_freight-dropdown-left",
          'group_by_title': 'Rute yang Dilayani'
        },
        {
          'key': 'Ruteyangdilayani',
          'title': null,
          'KategoriID': 34,
          'SubKategoriID': 30,
          'tag_frontend': "rute_dilayani_air_freight-dropdown-right",
          'group_by_title': 'Rute yang Dilayani'
        },
        {
          'key': 'TahunBerdiri',
          'title': 'Tahun Berdiri',
          'KategoriID': 34,
          'SubKategoriID': 30,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunBerdiri', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_berdiri_jasa_air_freight-rangefield",
        },
        {
          'key': 'JumlahKantordiIndonesia',
          'title': 'Jumlah Kantor di Indonesia',
          'KategoriID': 34,
          'SubKategoriID': 30,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'JumlahKantordiIndonesia', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "jumlah_kantor_indonesia_air_freight-rangefield",
        },
        {
          'key': 'JumlahKantordiluarnegeri',
          'title': 'Jumlah Kantor di Luar Negeri',
          'KategoriID': 34,
          'SubKategoriID': 30,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'JumlahKantordiluarnegeri', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "jumlah_kantor_luar_air_freight-rangefield",
        },
      ];
    }
    // Transportasi Intermoda | Rail Freight
    else if (subKategoriId == '31') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 35,
          'SubKategoriID': 31,
          'tag_frontend': "lokasi_rail_freight-lokasifield",
        },
        {
          'key': 'Ruteyangdilayani',
          'title': null,
          'KategoriID': 35,
          'SubKategoriID': 31,
          'tag_frontend': "rute_dilayani_rail_freight-dropdown-left",
          'group_by_title': 'Rute yang Dilayani'
        },
        {
          'key': 'Ruteyangdilayani',
          'title': null,
          'KategoriID': 35,
          'SubKategoriID': 31,
          'tag_frontend': "rute_dilayani_rail_freight-dropdown-right",
          'group_by_title': 'Rute yang Dilayani'
        },
        {
          'key': 'TahunBerdiri',
          'title': 'Tahun Berdiri',
          'KategoriID': 35,
          'SubKategoriID': 31,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunBerdiri', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_berdiri_jasa_rail_freight-rangefield",
        },
        {
          'key': 'JumlahKantordiIndonesia',
          'title': 'Jumlah Kantor di Indonesia',
          'KategoriID': 35,
          'SubKategoriID': 31,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'JumlahKantordiIndonesia', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "jumlah_kantor_indonesia_rail_freight-rangefield",
        },
      ];
    }
    // Octa13 >

    // Pras13 <
    else if (
      subKategoriId == '22' // Property & Warehous | Perusahaan Lainnya
      || subKategoriId == '28' // Property & Warehous | Perusahaan Lainnya
      || subKategoriId == '14' // Repair & Maintenance | Perusahaan Lainnya
      || subKategoriId == '48' // Transportation Store | Perusahaan Lainnya
      || subKategoriId == '40' // Transportasi Intermoda | Perusahaan Lainnya
      || subKategoriId == '53' // Human Capital | Perusahaan Lainnya

    ) {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'tag_frontend': "lokasi_perusahaan_lainnya-lokasifield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi",
          'value': "1",
        }
      ];
    }
    else if (
      subKategoriId == '19' // Property & Warehous | PLB
    ) {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 30,
          'SubKategoriID': 19,
          'tag_frontend': "lokasi_plb-lokasifield",
        },
        {
          'key': 'TahunBerdiri',
          'title': 'Tahun Berdiri',
          'KategoriID': 30,
          'SubKategoriID': 19,
          'min_value' : '1970',
          'max_value' : DateTime.now().year.toString(),
          'dynamic_min_key': '-',
          'dynamic_max_key': 'TahunBerdiri',
          'tag_frontend': "tahun_berdiri_plb_hard-rangefield",
          'number_type': NumberType.YEAR
        },
        {
          'key': 'Layanan',
          'title': 'Layanan Lainnya',
          'KategoriID': 30,
          'SubKategoriID': 19,
          'tag_frontend': "layanan_plb-checkboxfield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 30,
          'SubKategoriID': 19,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    else if (
      subKategoriId == '18' // Property & Warehous | Jasa Pergudangan
    ) {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 30,
          'SubKategoriID': 19,
          'tag_frontend': "lokasi_jasa_pergudangan-lokasifield",
        },
        {
          'key': 'TahunBerdiri',
          'title': 'Tahun Berdiri',
          'KategoriID': 29,
          'SubKategoriID': 18,
          'min_value' : '1970',
          'max_value' : DateTime.now().year.toString(),
          'dynamic_min_key': '-',
          'dynamic_max_key': 'TahunBerdiri',
          'tag_frontend': "tahun_berdiri_jasa_pergudangan_hard-rangefield",
          'number_type': NumberType.YEAR
        },
        {
          'key': 'Layanan',
          'title': 'Layanan',
          'KategoriID': 29,
          'SubKategoriID': 18,
          'tag_frontend': "layanan_jasa_pergudangan-checkboxfield",
        },
        {
          'key': 'MenanganiSpesialHandling',
          'title': 'Menangani Spesial Handling',
          'KategoriID': 29,
          'SubKategoriID': 18,
          'tag_frontend': "menangani_heading_jasa_pergudangan-checkboxfield",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 29,
          'SubKategoriID': 18,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }  
    // Pras13 >

    // Refo13 <
    // Transportation Store | Container
    else if(subKategoriId == '41'){
      return [
        {
          'key': 'Kondisi',
          'title': 'Kondisi Container',
          'KategoriID': 22,
          'SubKategoriID': 41,
          'tag_frontend': "kondisi_cotainer-radiofield"
        },
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 22,
          'SubKategoriID': 41,
          'tag_frontend': "lokasi_container-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 22,
          'SubKategoriID': 41,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "harga_iklan_container-rangefield"
        },
        {
          'key': 'Ukuran',
          'title': 'Ukuran',
          'KategoriID': 22,
          'SubKategoriID': 41,
          'tag_frontend': "ukuran_container-checkboxfield",
        },
        {
          'key': 'JenisContainer',
          'title': 'Jenis Container',
          'KategoriID': 22,
          'SubKategoriID': 41,
          'tag_frontend': "jenis_container_container-checkboxfield",
        },
        {
          'key': 'tipe_penjual',
          'title': 'Tipe Penjual',
          'KategoriID': 22,
          'SubKategoriID': 41,
          'tag_frontend': "tipe_penjual-checkboxfield",
          'value_alias': "Individu,Perusahaan",
          'value': "0,1",
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 22,
          'SubKategoriID': 41,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    if (subKategoriId == '21') {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 32,
          'SubKategoriID': 21,
          'tag_frontend': "lokasi_iklan_produk_lainnya-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 32,
          'SubKategoriID': 21,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': 'Harga_terendah', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "harga_produk_lainnya-rangefield",
        },
        {
          'key': 'opsi_penjual',
          'title': 'Opsi Penjual',
          'KategoriID': 32,
          'SubKategoriID': 21,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value': "Hanya Tampilkan Penjual yang Terverifikasi",
        },
      ];
    }
    else if(subKategoriId == '20'){
      return [
        {
          'key': 'Kondisi',
          'title': 'Kondisi',
          'KategoriID': 31,
          'SubKategoriID': 20,
          'tag_frontend': "kondisi_peralatan_gudang-radiofield",
        },
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 31,
          'SubKategoriID': 20,
          'tag_frontend': "lokasi_peralatan_gudang-lokasifield",
        },
        {
          'key': 'Harga',
          'title': 'Rentang Harga',
          'KategoriID': 31,
          'SubKategoriID': 20,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': 'Harga_terendah', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'Harga', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "harga_iklan_peralatan_gudang-rangefield",
        },
        {
          'key': 'JenisPeralatan',
          'title': 'Jenis Peralatan',
          'KategoriID': 31,
          'SubKategoriID': 20,
          'tag_frontend': "jenis_peralatan_peralatan_gudang-checkboxfield",
        },
        {
          'key': 'tipe_penjual',
          'title': 'Tipe Penjual',
          'KategoriID': 31,
          'SubKategoriID': 20,
          'tag_frontend': "tipe_penjual-checkboxfield",
          'value': "Individu,Perusahaan",
        },
        {
          'key': 'opsi_penjual',
          'title': 'Opsi Penjual',
          'KategoriID': 31,
          'SubKategoriID': 20,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value': "Hanya Tampilkan Penjual yang Terverifikasi",
        },
      ];
    }
     else if (
      subKategoriId == '34' // Transportasi Intermoda | 3 - 5 Company
     ) {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 38,
          'SubKategoriID': 34,
          'tag_frontend': "lokasi_3pl_company-lokasifield",
        },
        {
          'key': 'TingkatLayanan',
          'title': 'Tingkat Layanan',
          'KategoriID': 38,
          'SubKategoriID': 34,
          'tag_frontend': "tingkat_layanan_3pl_company-checkboxfield"
        },
        {
          'key': 'TahunBerdiri',
          'title': 'Tahun Berdiri',
          'KategoriID': 38,
          'SubKategoriID': 34,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunBerdiri', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_berdiri_jasa_3pl_company-rangefield",
        },
      ];
    }
      else if (
      subKategoriId == '33' // Transportasi Intermoda | Freight Forwarding
      // || subKategoriId == '11' // Repair & Maintenance | Bengkel
     ) {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 37,
          'SubKategoriID': 33,
          'tag_frontend': "lokasi_freight_forwarding-lokasifield",
        },
        {
          'key': 'CakupanLayanan',
          'title': 'Cakupan Layanan',
          'KategoriID': 37,
          'SubKategoriID': 33,
          'tag_frontend': "cangkupan_layanan_freight_forwardding-checkboxfield"
        },
        {
          'key': 'TahunBerdiri',
          'title': 'Tahun Berdiri',
          'KategoriID': 37,
          'SubKategoriID': 33,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'TahunBerdiri', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "tahun_berdiri_jasa_freight_forwardding-rangefield",
        },
        {
          'key': 'JumlahKantordiIndonesia',
          'title': 'Jumlah Kantor di Indonesia',
          'KategoriID': 37,
          'SubKategoriID': 33,
          'min_value': "0",
          'max_value': "10000",
          'dynamic_min_key': '-', // get the key that you want to dynamically adjust the max data.
          'dynamic_max_key': 'JumlahKantordiIndonesia', // get the key that you want to dynamically adjust the max data.
          'tag_frontend': "jumlah_kantor_indonesia_freight_forwardding-rangefield",
        },
      ];
    }
    else if (
      subKategoriId == '11' // Repair & Maintenance | Bengkel
     ) {
      return [
        {
          'key': 'LokasiIklan',
          'title': 'Lokasi',
          'KategoriID': 23,
          'SubKategoriID': 11,
          'tag_frontend': "lokasi_iklan_bengkel-lokasifield",
        },
        {
          'key': 'MerkYangDilayani',
          'title': 'Merk yang Dilayani',
          'KategoriID': 23,
          'SubKategoriID': 11,
          'tag_frontend': "merk_bengkel-checkboxfield"
        },
        {
          'key': 'LayananService',
          'title': 'Layanan Servis Khusus',
          'KategoriID': 23,
          'SubKategoriID': 11,
          'tag_frontend': "layanan_service_bengkel-checkboxfield"
        },
        {
          'key': 'TipeLayanan',
          'title': 'Tipe Layanan',
          'KategoriID': 23,
          'SubKategoriID': 11,
          'tag_frontend': "tipe_layanan_bengkel-checkboxfield"
        },
        {
          'key': 'verified',
          'title': 'Opsi Penjual',
          'KategoriID': 23,
          'SubKategoriID': 11,
          'tag_frontend': "opsi_penjual-checkboxfield",
          'value_alias': "Hanya Tampilkan Penjual yang Terverifikasi", // must be have the same length as value
          'value': "1",
        },
      ];
    }
    // Refo13 >

    return [
      {
        'key': 'kondisi_kendaraan',
        'title': 'Kondisi Kendaraan',
        'KategoriID': 21,
        'SubKategoriID': 37,
        'tag_frontend': "kondisi_kendaraan_kargo-radiofield",
      }
    ];
  }

}