
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/template/widgets/card/card_company.dart';
import 'package:muatmuat/app/template/widgets/card/card_product.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class RepairAndMainTenances extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Bengkel
        CardCompany(
          imageUrl: "",
          title: "ALS Cargo International Indonesia",
          address: "Jl. Re. Martadinata Arteri Puri Anjasmoro Puri Anjasmoro, Kota Semarang, Jawa Tengah",
          date: DateTime.now(),
          detail: {
            "Tipe Layanan" : "Engine Repair dan Overhaul",
            "Merk yang Dilayani" : "Mercedess Benz, Mitsubishi, Isuzu",
            "Tahun Berdiri" : "2010",
          },
          detailValueStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          favorite: true,
          highlight: true,
          location: "Semarang, Kota Semarang",
          onTap: (){
          },
          onFavorited: () {

          },
          verified: true,
        ),

        //Teknisi
        CardCompany(
          imageUrl: "",
          title: "Pardi Supardi Slamet Supriyo",
          address: "Ahli Perbaikan Dinamo/Starter Mobil Truk",
          date: DateTime.now(),
          detail: {
            "Tipe Layanan" : "Engine Repair dan Overhaul",
            "Merk yang Dilayani" : "Mercedess Benz, Mitsubishi, Isuzu",
            "Tahun Berdiri" : "2010",
          },
          detailValueStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          favorite: true,
          highlight: true,
          location: "Semarang, Kota Semarang",
          onTap: (){
          },
          onFavorited: () {

          },
          verified: true,
        ),

        //Perusahaan Lainnya
        CardCompany(
          imageUrl: "",
          title: "Toko Terang Jaya",
          address: "Jl. Re. Martadinata Arteri Puri Anjasmoro Puri Anjasmoro, Kota Semarang, Jawa Tengah",
          date: DateTime.now(),
          detail: {
            "Layanan Perusahaan" : "Jual Beli Truk dan Pickup Baru dan Bekas",
            "Tahun Berdiri" : "2010",
          },
          detailValueStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          favorite: true,
          highlight: true,
          location: "Semarang, Kota Semarang",
          onTap: (){
          },
          onFavorited: () {

          },
          verified: true,
        ),

        //Card bengkel yg individu
        CardCompany(
          imageUrl: "",
          title: "ALS Cargo International Indonesia",
          address: "Jl. Re. Martadinata Arteri Puri Anjasmoro Puri Anjasmoro, Kota Semarang, Jawa Tengah",
          date: DateTime.now(),
          detail: {
            "Tipe Layanan" : "Engine Repair dan Overhaul",
            "Merk yang Dilayani" : "Mercedess Benz, Mitsubishi, Isuzu",
            "Tahun Berdiri" : "2010",
          },
          detailValueStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          favorite: true,
          highlight: true,
          location: "Semarang, Kota Semarang",
          onTap: (){
          },
          onFavorited: () {

          },
          verified: true,
        ),

        //Produk Lainnya
        CardProduct(
          onTap: () {
            
          },
          highlight: true,
          verified: true,
          favorite: true,
          onFavorited: (){

          },
          date: DateTime.parse("2023-02-16"),
          imageUrl: "",
          useNegotiationPrice: ['Harga'].toString().isEmpty,
          price: double.parse('12000'),
          description: "Jual Minyak Oli Bekas, Buatan Jerman",
          location: "Semarang, Kota Semarang",

          showDateAtFooter: true, // menyesuaikan berdasarkan modul
        ),
      ],
    );
  }

  // void showTutorial() {
  //   TutorialCoachMark tutorial = TutorialCoachMark(
  //     Get.context,
  //     targets: targets, // List<TargetFocus>
  //     colorShadow: Colors.red, // DEFAULT Colors.black
  //      // alignSkip: Alignment.bottomRight,
  //      // textSkip: "SKIP",
  //      // paddingFocus: 10,
  //      // focusAnimationDuration: Duration(milliseconds: 500),
  //      // pulseAnimationDuration: Duration(milliseconds: 500),
  //     onFinish: (){
  //       print("finish");
  //     },
  //     onClickTarget: (target){
  //       print(target);
  //     },
  //     onSkip: (){
  //       print("skip");
  //     }
  //   )..show();

  //   // tutorial.skip();
  //   // tutorial.finish();
  //   // tutorial.next(); // call next target programmatically
  //   // tutorial.previous(); // call previous target programmatically
  // }
}