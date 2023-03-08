import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/peserta_pratender/peserta_pratender_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class PesertaPratenderView extends GetView<PesertaPratenderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("PratenderDetailParticipantList".tr),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt_rounded, color: Colors.white),
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: ((context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(13),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                    side: BorderSide(color: Color(ListColor.color4), width: 2)),
                onPressed: () {},
                padding: EdgeInsets.all(11),
                minWidth: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Image(
                        image: AssetImage("assets/gambar_example.jpeg"),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText("PT. Truk Indah Sentosa",
                                color: Color(ListColor.color4),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            CustomText("Jl. Gubeng Raya No. 9", fontSize: 12),
                            CustomText("Surabaya, Jawa Timur", fontSize: 12),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: MaterialButton(
                                  color: Color(ListColor.color4),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  onPressed: () {},
                                  child: CustomText(
                                      "PratenderParticipantDownloadTerms".tr,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void FilterDialog() {}
}
