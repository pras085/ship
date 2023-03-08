import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class StaticCardBuyer extends StatelessWidget {

  final bool isBigFleet;
  final bool isTransportMarket;

  const StaticCardBuyer({ 
    Key key,
    this.isBigFleet = true,
    this.isTransportMarket = true,
  }) : super(key: key);

  List<Map> get _listMenu => [
    if (isBigFleet)
    {
      'title': "Keuntungan Transporter Bergabung di Big Fleets",
      'subtitle': "Dapat terhubung dan berkomunikasi dengan Shipper skala besar",
      'icon': "${GlobalVariable.urlImageTemplateBuyer}places_bf_transporter.png",
      'onTap': () {},
    },
    if (isTransportMarket)
    {
      'title': "Keuntungan Transporter Bergabung di Transport Market",
      'subtitle': "Menemukan Penawaran terbaik dari Shipper dengan cepat dan mudah",
      'icon': "${GlobalVariable.urlImageTemplateBuyer}places_tm_transporter.png",
      'onTap': () {},
    },
    if (isBigFleet)
    {
      'title': "Keuntungan Shipper Bergabung di Big Fleets",
      'subtitle': "Memudahkan pengelolaan Tender",
      'icon': "${GlobalVariable.urlImageTemplateBuyer}places_bf_shipper.png",
      'onTap': () {},
    },
    if (isTransportMarket)
    {
      'title': "Keuntungan Shipper Bergabung di Transport Market",
      'subtitle': "Membuat dan mengelola Lelang untuk rencana pengiriman Anda dengan mudah",
      'icon': "${GlobalVariable.urlImageTemplateBuyer}places_tm_shipper.png",
      'onTap': () {},
    },
  ];

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: GlobalVariable.ratioWidth(context) * 10,
      crossAxisSpacing: GlobalVariable.ratioWidth(context) * 16,
      children: [
        for (int i=0;i<_listMenu.length;i++)
          GestureDetector(
            onTap: _listMenu[i]['onTap'],
            child: Container(
              width: GlobalVariable.ratioWidth(context) * 156,
              height: GlobalVariable.ratioWidth(context) * 264,
              padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(ListColor.colorGreyTemplate2),
                  width: GlobalVariable.ratioWidth(context) * 1,
                ),
                borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(context) * 10,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, GlobalVariable.ratioWidth(context) * 13),
                    blurRadius: GlobalVariable.ratioWidth(context) * 20,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.1)
                  ),
                ]
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 42,
                          child: CustomText(_listMenu[i]['title'],
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            height: 14.4/12,
                            textAlign: TextAlign.center,
                            withoutExtraPadding: true,
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 14,
                        ),
                        Image.asset(_listMenu[i]['icon'],
                          width: GlobalVariable.ratioWidth(context) * 100,
                          height: GlobalVariable.ratioWidth(context) * 100,
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 14,
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 49,
                          child: CustomText(_listMenu[i]['subtitle'],
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            height: 12/10,
                            textAlign: TextAlign.center,
                            withoutExtraPadding: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 16,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText('Lihat Selengkapnya',
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            height: 12/10,
                            textAlign: TextAlign.center,
                            withoutExtraPadding: true,
                            color: Color(0xFF002D84),
                          ),
                        ),
                        SvgPicture.asset("${GlobalVariable.urlImageTemplateBuyer}ic_arrow_right_frame.svg",
                          width: GlobalVariable.ratioWidth(context) * 16,
                          height: GlobalVariable.ratioWidth(context) * 16,
                          color: Color(0xFF002D84),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }

}