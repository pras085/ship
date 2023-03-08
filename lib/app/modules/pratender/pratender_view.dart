import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/pratender/pratender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class PratenderView extends GetView<PratenderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          child: Container(
            color: Color(ListColor.color4),
            height: 2,
          ),
          preferredSize: Size.fromHeight(2),
        ),
        title: CustomText('PratenderActivePratenderTotal'.tr,
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.arrow_downward,
                  color: Colors.black,
                )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CREATE_PRATENDER);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return tenderView(index == 3);
        },
      )),
    );
  }

  Widget tenderView(bool last) {
    return Container(
      padding: EdgeInsets.only(
          top: 24, left: 10, right: 10, bottom: (last) ? 24 : 0),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Color(ListColor.color4))),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: CustomText('TD-012',
                            color: Color(ListColor.color4), fontSize: 12)),
                    CustomText('10-10-2020', color: Colors.grey, fontSize: 12)
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  width: double.infinity,
                  child: CustomText('Tender Pengiriman Rutin',
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 7.5),
                  height: 1,
                  color: Colors.grey,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2, color: Color(ListColor.color4))),
                      ),
                      CustomText('Surabaya', fontSize: 12, color: Colors.grey)
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 4),
                      child: Dash(
                        direction: Axis.vertical,
                        length: 24,
                        dashLength: 5,
                        dashThickness: 3,
                        dashColor: Color(ListColor.color4),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(ListColor.color4)),
                      ),
                      CustomText('Jakarta', fontSize: 12, color: Colors.grey)
                    ],
                  )
                ]),
                Container(
                  margin: EdgeInsets.only(top: 19, bottom: 24),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/ic_truck_border.svg",
                        color: Color(ListColor.color4),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 16),
                          child: CustomText('Tronton/Wingbox - 10 unit',
                              fontSize: 12, color: Colors.grey))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        'Exp 10-10-2020',
                        color: Color(ListColor.color4),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 7),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                        color: Color(ListColor.color4),
                        onPressed: () {
                          Get.toNamed(Routes.DETAIL_PRATENDER);
                        },
                        child: CustomText('PratenderIndexDetail'.tr,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
