// import 'dart:developer';

// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:muatmuat/app/style/list_colors.dart';
// import 'package:muatmuat/app/widgets/custom_text.dart';

// import '../../../../global_variable.dart';

class ExampleDetailProductBuyerController  {
  bool favorite;
//   CarouselController carouselC;
//   var current = 0.obs;
//   var testiList = [
//     {'id': '1', 'name': 'Pelayanan Kami'},
//     {'id': '2', 'name': 'Portfolio Perusahaan'},
//     {'id': '3', 'name': 'Daftar Customer'},
//     {'id': '4', 'name': 'Daftar Awards'}
//   ];
//   var photoList = [
//     'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//     'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//     'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   ];

//   List<Map<String, dynamic>> dataProfile = [
//     {
//       'name': 'Isi Sgell Super 10 Gratis 1 Lt',
//       'discount': 'Rp150.000',
//       'price': 'Rp200.000',
//       'periode': '15 Nov 2022 - 30 Nov 2022',
//       'address': 'Semarang',
//       'date': '21 Nov 2022',
//     }
//   ];

//   List<String> image;

//   @override
//   void onInit() {
//     // text = dataProfile.map((e) => e.map((map) => map['text']).toList());
//     // image = imgList.map((map) => map['image']).toList();
//     super.onInit();
//   }

//   Widget carouselImage(BuildContext context) {
//     return Container(
//       height: GlobalVariable.ratioWidth(context) * 203,
//       width: double.infinity,
//       child: CarouselSlider(
//         items: imageSliders,
//         carouselController: carouselC,
//         options: CarouselOptions(
//           viewportFraction: 1.0,
//           initialPage: 0,
//           enlargeCenterPage: false,
//           onPageChanged: (index, reason) {
//             current.value = index;
//           },
//         ),
//       ),
//     );
//   }

//   List<Widget> imageSliders = image.map((item) {
//     return Container(
//       width: double.infinity,
//       child: Stack(
//         alignment: AlignmentDirectional.center,
//         children: <Widget>[
//           GestureDetector(
//             onTap: () {
//               log(':::: INDEX = ' + photoList.indexOf(item).toString());
//             },
//             child: Image.network(
//               item,
//               fit: BoxFit.cover,
//               width: Get.width,
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
//                 color: Color(ListColor.colorBlackTemplate).withOpacity(0.8),
//               ),
//               padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 6),
//               child: CustomText(
//                 '${imgList.indexOf(item) + 1}/${imgList.length}',
//                 withoutExtraPadding: true,
//                 color: Color(ListColor.colorWhiteTemplate),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }).toList();
}
