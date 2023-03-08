import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/manajemen_order_entry/manajemen_order_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class ManajemenOrderView extends GetView<ManajemenOrderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("BigFleetsLabelMenuOrderEntryManagement".tr),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CREATE_ORDER_ENTRY);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                    side: BorderSide(color: Color(ListColor.color4), width: 2)),
                onPressed: () {
                  Get.toNamed(Routes.DETAIL_MANAJEMEN_ORDER_ENTRY);
                },
                minWidth: 0,
                padding: EdgeInsets.all(0),
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("No. Order: T-0$index",
                            fontWeight: FontWeight.bold, fontSize: 16),
                        CustomText("PT. Logistik Jaya Abadi",
                            fontWeight: FontWeight.bold, fontSize: 14),
                        CustomText("OrderEntryManagementPickupLocation".tr,
                            fontWeight: FontWeight.bold, fontSize: 13),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: CustomText("Jakarta")),
                        CustomText("OrderEntryManagementDestinationLocation".tr,
                            fontWeight: FontWeight.bold, fontSize: 13),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: CustomText("Surabaya")),
                        CustomText("OrderEntryManagementDeliveryTime".tr,
                            fontWeight: FontWeight.bold, fontSize: 13),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: CustomText("11.45, 12/01/2021")),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomText(
                              "OrderEntryManagementWaitingConfirmation".tr,
                              textAlign: TextAlign.end,
                              color: Colors.green),
                        )
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
