import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/appbar/appbar_detail_buyer.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ExampleDetailAllCard extends StatelessWidget {
  var list = [
    {
      'icon': 'assets/smile_icon.png',
      'nama': 'PT. BUMEN REDJA ABADI',
      'isVerified': '1',
      'photoList': [
        {
          'id': '1',
          'name': 'Promo Merdeka',
          'image':
              'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
        },
        {
          'id': '2',
          'name': 'Promo Nasional',
          'image':
              'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
        },
        {
          'id': '3',
          'name': 'Promo Merdeka',
          'image':
              'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
        },
        {
          'id': '4',
          'name': 'Promo Nasional',
          'image':
              'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
        },
      ]
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailBuyer(
        onClickBack: Get.back,
        title: 'Promo',
        isWithPrefix: false,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(context) * 16,
            GlobalVariable.ratioWidth(context) * 24,
            GlobalVariable.ratioWidth(context) * 16,
            GlobalVariable.ratioWidth(context) * 12,
          ),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, idx) {
              var isVerif = list[idx]['isVerified'].toString();
              return Column(
                children: [
                  header(context, idx, isVerif),
                  divider(context),
                  // WIDGET FOR DETAIL
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget divider(BuildContext context) {
    return Container(
      width: double.infinity,
      height: GlobalVariable.ratioWidth(context) * 0.5,
      color: Color(ListColor.colorGreyTemplate2),
      margin: EdgeInsets.only(
        top: GlobalVariable.ratioWidth(context) * 12,
        bottom: GlobalVariable.ratioWidth(context) * 10,
      ),
    );
  }

  Widget header(BuildContext context, int idx, String isVerif) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 180),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: GlobalVariable.ratioWidth(context) * 59,
            height: GlobalVariable.ratioWidth(context) * 59,
            child: Image.asset(
              list[idx]['icon'],
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: GlobalVariable.ratioWidth(context) * 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              list[idx]['nama'],
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            if (isVerif == '1')
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                  SvgPicture.asset(
                    GlobalVariable.urlImageTemplateBuyer + 'ic_buyer_verified_template.svg',
                    height: GlobalVariable.ratioWidth(context) * 13,
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(context) * 4),
                  CustomText(
                    "Verified",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(ListColor.colorGreenTemplate),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
