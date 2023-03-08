import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/testimoni_profile/testimoni_profile_controller.dart';
import 'package:muatmuat/app/modules/ubah_testimoni_profile/ubah_testimoni_profile_view.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:muatmuat/app/utils/response_state.dart';

import 'testimoni_profile_model.dart';

class TestimoniProfileView extends GetView<TestimoniProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(
        title: "Testimoni Anda",
        isCenter: false,
        isBlueMode: true,
        isWithBackgroundImage: true,
      ),
      body: Column(
        children: [
          // search
          Container(
            padding: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(context) * 14,
              horizontal: GlobalVariable.ratioWidth(context) * 16,
            ),
            height: GlobalVariable.ratioWidth(context) * 68,
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: GlobalVariable.ratioWidth(context) * 1,
                  color: Color(ListColor.colorLightGrey10),
                ),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
              ),
              child: _searchTextField,
            ),
          ),
          // content
          Expanded(
            child: Obx(() {
              if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
                return controller.dataList.isEmpty ? _contentEmpty(context) : _content(context, controller.dataList);
              } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
                return ErrorDisplayComponent("${controller.dataModelResponse.value.exception}",
                  onRefresh: () => controller.fetchDataTestimoni(),
                );
              }
              return LoadingComponent();
            }),
          ),
        ],
      ),
    );
  }

  Widget _contentEmpty(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/ic_laptop_empty_search.svg',
              width: GlobalVariable.ratioWidth(context) * 99.44,
              height: GlobalVariable.ratioWidth(context) * 86,
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(context) * 14,
            ),
            RichText(
              text: TextSpan(
                text: controller.searchResult.isEmpty ? "" : "Tidak ditemukan hasil pencarian untuk ",
                children: [
                  TextSpan(
                    text: controller.searchResult.isEmpty ? "Anda belum memiliki testimoni" : "\"${controller.searchResult.length > 100 ? '${controller.searchResult.substring(0, 96)} ... ' : controller.searchResult}\"",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: GlobalVariable.ratioWidth(context) * 14,
                      color: Color(ListColor.colorBlue),
                      fontFamily: "AvenirNext",
                      height: GlobalVariable.ratioWidth(context) * 1.2,
                    ),
                  ),
                ],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: GlobalVariable.ratioWidth(context) * 14,
                  color: Color(ListColor.colorBlue),
                  fontFamily: "AvenirNext",
                  height: GlobalVariable.ratioWidth(context) * 1.2,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context, List<Data> data) {
    return SmartRefresher(
      enablePullUp: true,
      controller: controller.refreshController,
      onLoading: () {
        controller.fetchDataTestimoni(
          refresh: false,
        );
      },
      onRefresh: () {
        controller.fetchDataTestimoni();
      },
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (ctx, i) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(context) * 12,
              horizontal: GlobalVariable.ratioWidth(context) * 14,
            ),
            margin: EdgeInsets.only(
              bottom: GlobalVariable.ratioWidth(context) * 14,
            ),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(context) * 101,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText("${data[i].transporterName}",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(context) * 6,
                          ),
                          Row(
                            children: [
                              ...List.generate(data[i].rate, 
                                (index) => SvgPicture.asset('assets/ic_star_frame.svg',
                                  width: GlobalVariable.ratioWidth(context) * 15,
                                  height: GlobalVariable.ratioWidth(context) * 15,
                                ),
                              ).toList(),
                              ...List.generate(5-data[i].rate, 
                                (index) => SvgPicture.asset('assets/ic_star_frame.svg',
                                  width: GlobalVariable.ratioWidth(context) * 15,
                                  height: GlobalVariable.ratioWidth(context) * 15,
                                  color: Color(ListColor.colorLightGrey2),
                                ),
                              ).toList(),
                              SizedBox(
                                width: GlobalVariable.ratioWidth(context) * 5,
                              ),
                              CustomText("${data[i].tanggalMobile ?? '-'}",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(context) * 8,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(context) * 2,
                      ),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context, 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 17),
                                topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 17),
                              ),
                            ),
                            backgroundColor: Colors.white,
                            builder: (ctx) {
                              return Container(
                                height: GlobalVariable.ratioWidth(context) * 138,
                                padding: EdgeInsets.symmetric(
                                  horizontal: GlobalVariable.ratioWidth(context) * 16,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                                        color: Color(ListColor.colorLightGrey16),
                                      ),
                                      width: GlobalVariable.ratioWidth(context) * 38,
                                      height: GlobalVariable.ratioWidth(context) * 2.74,
                                      margin: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(context) * 8,
                                        bottom: GlobalVariable.ratioWidth(context) * 13.26,
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: GlobalVariable.ratioWidth(context) * 24,
                                          height: GlobalVariable.ratioWidth(context) * 24,
                                          child: InkWell(
                                            onTap: Get.back,
                                            child: SvgPicture.asset('assets/ic_close1,5.svg',
                                              width: GlobalVariable.ratioWidth(context) * 15,
                                              height: GlobalVariable.ratioWidth(context) * 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          constraints: BoxConstraints(
                                            minHeight: GlobalVariable.ratioWidth(context) * 18,
                                          ),
                                          margin: EdgeInsets.only(
                                            top:  GlobalVariable.ratioWidth(context) * 2,
                                          ),
                                          child: CustomText("Opsi",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(ListColor.colorBlue),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      height: GlobalVariable.ratioWidth(context) * 56.5,
                                      width: GlobalVariable.ratioWidth(context) * 328,
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {

                                            },
                                            child: Container(
                                              width: GlobalVariable.ratioWidth(context) * 328,
                                              height: GlobalVariable.ratioWidth(context) * 28,
                                              child: CustomText("Lihat Perusahaan Transporter",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: GlobalVariable.ratioWidth(context) * 328,
                                            height: GlobalVariable.ratioWidth(context) * 0.5,
                                            color: Color(ListColor.colorLightGrey5),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              final res = await GetToPage.toNamed<UbahTestimoniProfileView>(
                                                Routes.UBAH_TESTIMONI_PROFILE,
                                                arguments: data[i],
                                              );
                                              Get.back();
                                              if (res != null && res == true) {
                                                controller.fetchDataTestimoni();
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.bottomLeft,
                                              width: GlobalVariable.ratioWidth(context) * 328,
                                              height: GlobalVariable.ratioWidth(context) * 28,
                                              child: CustomText("Ubah Testimoni",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ]
                                      ),
                                    ),
                                    SizedBox(
                                      height:  GlobalVariable.ratioWidth(context) * 18,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: SvgPicture.asset('assets/ic_more_vert.svg',
                          width: GlobalVariable.ratioWidth(context) * 24,
                          height: GlobalVariable.ratioWidth(context) * 24,
                          color: Color(ListColor.colorBlue),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(context) * 8,
                  ),
                  width: GlobalVariable.ratioWidth(context) * 284,
                  constraints: BoxConstraints(
                    maxHeight: GlobalVariable.ratioWidth(context) * 102,
                  ),
                  child: CustomText("${data[i].content ?? '-'}",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(ListColor.colorGrey3),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget get _searchTextField => Obx(() => Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: CustomTextField(
              context: Get.context,
              controller: controller.searchController,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.left,
              textInputAction: TextInputAction.go,
              style: TextStyle(
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: "AvenirNext",
                  color: Colors.black),
              inputFormatters: [
                LengthLimitingTextInputFormatter(255),
              ],
              newInputDecoration: InputDecoration(
                  fillColor: Colors.transparent,
                  hintStyle: TextStyle(
                      fontSize: GlobalVariable.ratioWidth(Get.context) * 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: "AvenirNext",
                      color: Color(ListColor.colorLightGrey2)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  // prefixIcon: Icon(
                  //   Icons.search,
                  //   color: Colors.grey,
                  // ),
                  hintText: "Cari Transporter",
                  filled: true,
                  isDense: true,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 48,
                      GlobalVariable.ratioWidth(Get.context) * 2,
                      GlobalVariable.ratioWidth(Get.context) * 48,
                      GlobalVariable.ratioWidth(Get.context) * 0)),
              onSubmitted: (String str) async {
                controller.search.value = str;
                controller.fetchDataTestimoni();
              },
              onChanged: (String str) async {
                controller.search.value = str;
              },
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
              left: GlobalVariable.ratioWidth(Get.context) * 16,
            ),
            child: SvgPicture.asset(
              "assets/ic_search.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 24,
              height: GlobalVariable.ratioWidth(Get.context) * 24,
              color: Color(controller.search.value.trim().isNotEmpty ? ListColor.colorBlack : ListColor.colorLightGrey2),
            ),
          ),
          controller.search.value.trim().isNotEmpty
              ? Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(
                  right: GlobalVariable.ratioWidth(Get.context) * 16,
                ),
                child: SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                    height: GlobalVariable.ratioWidth(Get.context) * 24,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          controller.searchController.clear();
                          controller.search.value = "";                
                          controller.fetchDataTestimoni();
                        },
                        child: SvgPicture.asset('assets/ic_close1,5.svg',
                          width: GlobalVariable.ratioWidth(Get.context) * 15,
                          height: GlobalVariable.ratioWidth(Get.context) * 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
              )
              : SizedBox.shrink()
        ],
      ));

}