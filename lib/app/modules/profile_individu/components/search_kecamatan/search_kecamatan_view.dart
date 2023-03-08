import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/profile_individu/components/search_kecamatan/search_kecamatan_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class SearchKecamatanView extends GetView<SearchKecamatanController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SearchKecamatanController());
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(context) * 16,
                  GlobalVariable.ratioWidth(context) * 12,
                  GlobalVariable.ratioWidth(context) * 6,
                  GlobalVariable.ratioWidth(context) * 12,
                ),
                width: GlobalVariable.ratioWidth(context) * 24,
                height: GlobalVariable.ratioWidth(context) * 24,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 25),
                  ),
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    "assets/ic_back_seller.svg",
                    color: Color(ListColor.colorWhite),
                    width: GlobalVariable.ratioWidth(context) * 24,
                    height: GlobalVariable.ratioWidth(context) * 24,
                  ),
                )),
            CustomText(
              "GeneralDistrictLabelCariKecamatan".tr,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ],
        ),
        titleSpacing: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(context) * 16,
              GlobalVariable.ratioWidth(context) * 16,
              GlobalVariable.ratioWidth(context) * 0,
              GlobalVariable.ratioWidth(context) * 16,
            ),
            child: CustomText(
              "GeneralDistrictLabelCariKecamatan".tr,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(context) * 16,
              GlobalVariable.ratioWidth(context) * 0,
              GlobalVariable.ratioWidth(context) * 16,
              GlobalVariable.ratioWidth(context) * 18,
            ),
            height: GlobalVariable.ratioWidth(context) * 40,
            decoration: BoxDecoration(
                border: Border.all(width: GlobalVariable.ratioWidth(context) * 1, color: Color(ListColor.colorLightGrey10)),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6)),
            padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(context) * 13.5,
              GlobalVariable.ratioWidth(context) * 8,
              GlobalVariable.ratioWidth(context) * 12,
              GlobalVariable.ratioWidth(context) * 8,
            ),
            child: Obx(() => Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: GlobalVariable.ratioWidth(context) * 8,
                      ),
                      child: SvgPicture.asset(
                        "assets/ic_search.svg",
                        width: GlobalVariable.ratioWidth(context) * 24,
                        height: GlobalVariable.ratioWidth(context) * 24,
                        color: controller.text == "" ? Color(ListColor.colorLightGrey21) : Color(ListColor.colorBlack),
                      ),
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        context: context,
                        autofocus: false,
                        onChanged: (value) {
                          controller.search(search: value);
                        },
                        controller: controller.searchController,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.2,
                        ),
                        textSize: 14,
                        newInputDecoration: InputDecoration(
                            hintText: "GeneralDistrictLabelMasukkanNamaKecamatan".tr,
                            hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Color(ListColor.colorLightGrey2)),
                            fillColor: Colors.transparent,
                            filled: true,
                            isDense: true,
                            isCollapsed: true,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none),
                      ),
                    ),
                  ],
                )),
          ),
          Divider(
            thickness: 1,
            color: Color(ListColor.colorLightGrey10),
            indent: GlobalVariable.ratioWidth(context) * 16,
            endIndent: GlobalVariable.ratioWidth(context) * 16,
            height: 0,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 2),
          Obx(() => Expanded(
                child: ListView.builder(
                    itemCount: controller.listKecamatan.length,
                    itemBuilder: (context, index) {
                      int districtId = controller.listKecamatan[index][controller.districtIdKey];
                      String districtName = controller.listKecamatan[index][controller.districtNameKey];
                      String cityName = controller.listKecamatan[index][controller.cityNameKey];
                      String provinceName = controller.listKecamatan[index][controller.provinceNameKey];
                      int cityId = controller.listKecamatan[index][controller.cityIdKey];
                      int provinceId = controller.listKecamatan[index][controller.provinceIdKey];

                      return controller.listKecamatan.length == 0
                          ? [
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Image.asset('assets/ic_laptop_empty_search.svg'),
                                ),
                              ),
                            ]
                          : GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                controller.onTap(
                                    districtId: districtId,
                                    districtName: districtName,
                                    cityName: cityName,
                                    provinceName: provinceName,
                                    cityId: cityId,
                                    provinceId: provinceId);
                              },
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  GlobalVariable.ratioWidth(context) * 16,
                                  GlobalVariable.ratioWidth(context) * 16.5,
                                  GlobalVariable.ratioWidth(context) * 16,
                                  GlobalVariable.ratioWidth(context) * 0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: GlobalVariable.ratioWidth(context) * 3),
                                        SvgPicture.asset(
                                          "assets/ic_marker2.svg",
                                          width: GlobalVariable.ratioWidth(context) * 12,
                                          height: GlobalVariable.ratioWidth(context) * 15.75,
                                          color: Color(ListColor.colorBlue),
                                        ),
                                        SizedBox(width: GlobalVariable.ratioWidth(context) * 11),
                                        Expanded(
                                          child: CustomText(
                                            "${districtName.split(" - ")[0]}, $cityName, $provinceName",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            height: 1.2,
                                            withoutExtraPadding: true,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: GlobalVariable.ratioWidth(context) * 16.5),
                                    if (index != controller.listKecamatan.length - 1) ...[
                                      Divider(
                                        thickness: 1,
                                        color: Color(ListColor.colorLightGrey10),
                                        height: 0,
                                        indent: (GlobalVariable.ratioWidth(context) * 3) +
                                            (GlobalVariable.ratioWidth(context) * 12) +
                                            (GlobalVariable.ratioWidth(context) * 11),
                                      ),
                                    ]
                                  ],
                                ),
                              ),
                            );
                    }),
              ))
        ],
      ),
    );
  }
}
