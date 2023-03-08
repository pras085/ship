import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/template/appbar/appbar_detail_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_card_promo_buyer.dart';
import 'package:muatmuat/app/template/example/example_detail_card/example_detail_all_card.dart';
import 'package:muatmuat/app/template/example/example_detail_card/example_detail_card_desc.dart';
import 'package:muatmuat/global_variable.dart';

class ExampleDetailCard extends StatelessWidget {
  List<Map<String, dynamic>> cardList = [
    {
      'id': '1',
      'name': 'Promo Merdeka',
      'image':
          'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'desc':
          'Dapatkan promo service lengkap hanya dengan RP. 30.000. Dapatkan juga diskon tambahan hingga Rp. 20000. Dapatkan promo service lengkap hanya dengan RP. 30.000. Dapatkan juga diskon tambahan hingga Rp. 20000'
    },
    {
      'id': '2',
      'name': 'Promo Nasional',
      'image':
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'desc':
          'Dapatkan promo service lengkap hanya dengan RP. 30.000. Dapatkan juga diskon tambahan hingga Rp. 20000. Dapatkan promo service lengkap hanya dengan RP. 30.000. Dapatkan juga diskon tambahan hingga Rp. 20000'
    },
    {
      'id': '3',
      'name': 'Katalog Bulan November',
      'image':
          'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'desc':
          'Dapatkan promo service lengkap hanya dengan RP. 30.000. Dapatkan juga diskon tambahan hingga Rp. 20000. Dapatkan promo service lengkap hanya dengan RP. 30.000. Dapatkan juga diskon tambahan hingga Rp. 20000'
    },
    {
      'id': '4',
      'name': 'Promo Nasional',
      'image':
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'desc':
          'Dapatkan promo service lengkap hanya dengan RP. 30.000. Dapatkan juga diskon tambahan hingga Rp. 20000. Dapatkan promo service lengkap hanya dengan RP. 30.000. Dapatkan juga diskon tambahan hingga Rp. 20000'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailBuyer(
        onClickBack: () => Get.back(),
        isWithPrefix: false,
        title: 'Example Detail Card Buyer',
      ),
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 16,
          ),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailCardPromoBuyer(
                  // title: 'Pilihan Promo Hari Ini',
                  // subtitle: 'Lihat Semua',
                  cardList: cardList,
                  //textAlign: TextAlign.left,
                  // onCardTap: (i) => Get.to(
                  //   ExampleDetailCardDescView(),
                  //   arguments: [
                  //     {
                  //       'image': cardList[i]['image'],
                  //       'name': cardList[i]['name'],
                  //       'desc': cardList[i]['desc'],
                  //     }
                  //   ],
                  // ),
                  onCardTap: (i) {},
                  onShowAllTap: () {}
                  // Get.to(
                  //   ExampleDetailAllCard(),
                  ),
              DetailCardBrosurBuyer(
                // title: 'Brosur',
                // subtitle: 'Lihat Semua',
                cardList: cardList,
                // textAlign: TextAlign.center,
                onCardTap: (i) {},
                onShowAllTap: () {},
                // onCardTap: (i) {
                //   log(':::: ' + i.toString());
                // },
                // onShowAllTap: () => Get.to(
                //   () => ExampleDetailAllCard(),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
