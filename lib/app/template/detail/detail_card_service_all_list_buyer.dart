import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/appbar/appbar_detail_buyer.dart';
import 'package:muatmuat/app/template/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class DetailCardServiceAllListBuyer extends StatelessWidget {
  final Map data;

  DetailCardServiceAllListBuyer({
    Key key,
    @required this.data
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailBuyer(
        onClickBack: Get.back,
        title: 'Jasa Service',
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(context),
                divider(context),
                body(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 180),
          clipBehavior: Clip.antiAlias,
          child: Material(
            borderOnForeground: true,
            elevation: GlobalVariable.ratioWidth(context) * 2,
            child: SizedBox(
              width: GlobalVariable.ratioWidth(context) * 59,
              height: GlobalVariable.ratioWidth(context) * 59,
              child: CachedNetworkImage(
                imageUrl: data['LogoPerusahaan'][0] ?? '',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(width: GlobalVariable.ratioWidth(context) * 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              data['data_seller']['nama_seller'] ?? '',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
            if (data['data_seller']['verfied'] != '0')
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    GlobalVariable.urlImageTemplateBuyer + 'ic_buyer_verified_template.svg',
                    height: GlobalVariable.ratioWidth(context) * 13,
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(context) * 4),
                  CustomText(
                    "Verified",
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(ListColor.colorGreen6),
                    withoutExtraPadding: true,
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Widget divider(BuildContext context) {
    return Container(
      width: double.infinity,
      height: GlobalVariable.ratioWidth(context) * 0.5,
      color: Color(ListColor.colorGreyTemplate2),
      margin: EdgeInsets.only(
        top: GlobalVariable.ratioWidth(context) * 12,
        bottom: GlobalVariable.ratioWidth(context) * 12,
      ),
    );
  }

  Widget body(BuildContext context) {
    List listData;
    if (data != null && (data['JasaServis'] as List).length > 0) {
      listData = data['JasaServis'];
    }

    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: GlobalVariable.ratioWidth(context) * 10,
      crossAxisSpacing: GlobalVariable.ratioWidth(context) * 16,
      children: [
        for (var i = 0; i < listData.length; i++)
          GestureDetector(
            onTap: () {

            },
            child: Container(
              width: GlobalVariable.ratioWidth(context) * 156,
              margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(context) * 8),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(context) * 10,
                vertical: GlobalVariable.ratioWidth(context) * 14,
              ),
              decoration: BoxDecoration(
                color: Color(ListColor.colorWhiteTemplate),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 9),
                border: Border.all(
                  width: GlobalVariable.ratioWidth(context) * 1, 
                  color: Color(ListColor.colorGreyTemplate2),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(GlobalVariable.ratioWidth(context) * 0, GlobalVariable.ratioWidth(context) * 10),
                    blurRadius: GlobalVariable.ratioWidth(context) * 13,
                    spreadRadius: GlobalVariable.ratioWidth(context) * 0,
                    color: Color(ListColor.colorShadowTemplate1).withOpacity(0.15),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: GlobalVariable.ratioWidth(context) * 118,
                    width: GlobalVariable.ratioWidth(context) * 136,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 5),
                      child: CachedNetworkImage(
                        imageUrl: listData[i]['JasaServis_image'][0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                  Container(
                    height: GlobalVariable.ratioWidth(context) * 28,
                    child: CustomText(
                      listData[i]['JasaServis_judul'],
                      withoutExtraPadding: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 1.2,
                    ),
                  ),
                  if (listData[i]['JasaServis_Harga_JasaServis_Awal'].isNotEmpty || listData[i]['JasaServis_Harga_JasaServis_Akhir'].isNotEmpty) ...[
                    SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                    CustomText(
                      'Harga Jasa',
                      withoutExtraPadding: true,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      height: 1.2,
                      color: Color(ListColor.colorGreyTemplate2),
                    ),
                    SizedBox(height: GlobalVariable.ratioWidth(context) * 2),
                    CustomText(
                      listData[i]['JasaServis_Harga_JasaServis_Awal'].isNotEmpty && listData[i]['JasaServis_Harga_JasaServis_Awal'].isNotEmpty ?
                        "${Utils.formatCurrency(value: double.parse(listData[i]['JasaServis_Harga_JasaServis_Awal']))} - ${Utils.formatCurrency(value: double.parse(listData[i]['JasaServis_Harga_JasaServis_Akhir']))}"
                        : listData[i]['JasaServis_Harga_JasaServis_Awal'].isEmpty ? 
                          Utils.formatCurrency(value: double.parse(listData[i]['JasaServis_Harga_JasaServis_Akhir'])) 
                          : Utils.formatCurrency(value: double.parse(listData[i]['JasaServis_Harga_JasaServis_Awal'])),
                      withoutExtraPadding: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 1.2,
                    ),
                  ]
                ],
              ),
            ),
          )
      ],
    );
  }
}