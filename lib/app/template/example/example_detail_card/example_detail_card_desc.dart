import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/template/appbar/appbar_detail_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_card_with_desc.dart';
import 'package:muatmuat/app/template/media_preview/media_preview_buyer.dart';

class ExampleDetailCardDescView extends StatelessWidget {
  // var data = Get.arguments;
  // var data = [
  //   {
  //     'image ':
  //         'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  //     'name': 'Promo Merdekaa',
  //     'desc':
  //         'lorem ipsum osawetdfghjkxcvbnm,lorem ipsum osawetdfghjkxcvbnm,lorem ipsum osawetdfghjkxcvbnm,lorem ipsum osawetdfghjkxcvbnm,lorem ipsum osawetdfghjkxcvbnm,lorem ipsum osawetdfghjkxcvbnm,lorem ipsum osawetdfghjkxcvbnm,lorem ipsum osawetdfghjkxcvbnm,lorem ipsum osawetdfghjkxcvbnm,lorem ipsum osawetdfghjkxcvbnm,lorem ipsum osawetdfghjkxcvbnm,'
  //   }
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailBuyer(
        onClickBack: () => Get.back,
        isWithPrefix: false,
        title: 'Detail Promo',
      ),
      body: SafeArea(
        child: DetailCardWithDesc(
          imageUrl:
              'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
          name: 'Promo Merdekaa',
          desc:
              'lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum  lorem ipsum ',
          onTap: () => Get.to(
            () => MediaPreviewBuyer(
              urlMedia:[
                'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
              ],
              hideIndicator: true,
            ),
          ),
        ),
      ),
    );
  }
}
