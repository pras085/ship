import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class GroupMitraView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Detail Group"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(13),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(right: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image(
                        image: AssetImage("assets/gambar_example.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomText("Group 1",
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13)),
                                    side: BorderSide(
                                        color: Colors.blue, width: 2)),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, color: Colors.blue),
                                    CustomText("Edit", color: Colors.blue)
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                              width: double.infinity,
                              child: CustomText(
                                  "Daftar transporter langganan di Surabaya"))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(13),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: CustomText("Daftar Mitra (5)", fontSize: 18)),
            Expanded(
              child: Container(
                color: Color(0xFF101010),
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.listMitra.length,
                    itemBuilder: (context, index) {
                      var mitra = controller.listMitra[index];
                      return Container(
                        color: Colors.white,
                        margin: EdgeInsets.fromLTRB(11, 11, 11,
                            index != controller.listMitra.length - 1 ? 0 : 11),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                              side: BorderSide(
                                  color: Color(ListColor.color4), width: 2)),
                          onPressed: () {
                            Get.toNamed(Routes.TRANSPORTER, arguments: [
                              mitra.id,
                              mitra.name,
                              mitra.avatar,
                              mitra.isGold
                            ]);
                          },
                          padding: EdgeInsets.all(11),
                          minWidth: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/gambar_example.jpeg"),
                                        fit: BoxFit.cover),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(35))),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 11),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomText(mitra.name,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.close,
                                                color: Colors.blue),
                                          )
                                        ],
                                      ),
                                      Container(height: 5),
                                      CustomText("ListTransporterLabelArea".tr,
                                          fontWeight: FontWeight.bold),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: CustomText(mitra.address,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
