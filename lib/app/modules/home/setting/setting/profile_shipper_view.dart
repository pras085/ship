import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/setting/profile_shipper_menu_model.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'profile_shipper_controller.dart';

class ProfileShipperView extends GetView<ProfileShipperController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(ListColor.color4),
        child: Stack(children: [
          Positioned(
            top: 10,
            right: -10,
            child: Image(
              image: AssetImage("assets/fallin_star_3_icon.png"),
              height: 150,
              fit: BoxFit.fitHeight,
            ),
          ),
          SafeArea(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.83,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Obx(
                          () => Material(
                              shape: CircleBorder(),
                              clipBehavior: Clip.hardEdge,
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    child: controller.profileShipperModel.value
                                                .avatar ==
                                            null
                                        ? _defaultImage()
                                        : controller.profileShipperModel.value
                                                    .avatar ==
                                                ""
                                            ? _defaultImage()
                                            : CachedNetworkImage(
                                                imageUrl:
                                                    GlobalVariable.urlImage +
                                                        controller
                                                            .profileShipperModel
                                                            .value
                                                            .avatar,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: 130,
                                                  height: 130,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover)),
                                                ),
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                              ),
                                  ))),
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomText(GlobalVariable.userModelGlobal.name,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(ListColor.colorDarkGrey3)),
                      SizedBox(height: 5),
                      CustomText(GlobalVariable.userModelGlobal.email,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(ListColor.colorDarkGrey3)),
                      Obx(
                        () => CustomText(
                            controller.profileShipperModel.value.city +
                                ", " +
                                controller.profileShipperModel.value.province,
                            fontSize: 10,
                            color: Color(ListColor.colorDarkGrey3)),
                      ),
                      SizedBox(height: 26),
                      Expanded(
                        child: Obx(
                          () => ListView.separated(
                              itemBuilder: (context, index) {
                                return _menuProfileWidget(
                                    controller.listMenu[index], context);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: controller.listMenu.length),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(ListColor.color4)),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent,
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: CustomText(
                                                'SettingLabelConfirmationLogOut'
                                                    .tr),
                                            actions: [
                                              FlatButton(
                                                child: CustomText(
                                                    'GlobalButtonYES'.tr),
                                                onPressed: () {
                                                  controller.signOut();
                                                },
                                              ),
                                              FlatButton(
                                                child: CustomText(
                                                    'GlobalButtonNO'.tr),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: Center(
                                      child: CustomText(
                                          'ProfileShipperLabelLogout'.tr,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800))),
                            )),
                      )
                    ]),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: ClipOval(
                            child: Material(
                                shape: CircleBorder(),
                                color: Colors.white,
                                child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        child: Center(
                                            child: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          size: 30 * 0.7,
                                          color: Color(ListColor.color4),
                                        ))))),
                          ),
                        ),
                        Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  //Get.back();
                                },
                                child: Icon(
                                  Icons.settings,
                                  size: 30,
                                  color: Colors.white,
                                )))
                      ]),
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }

  Widget _defaultImage() {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      width: 130,
      height: 130,
    );
    // Ink.image(
    //   image: AssetImage("assets/gambar_example.jpeg"),
    //   fit: BoxFit.cover,
    //   width: 130,
    //   height: 130,
    // );
  }

  Widget _menuProfileWidget(
      ProfileShipperMenuModel data, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              width: 1,
              color: Color(ListColor.colorLightGrey2).withOpacity(0.4)),
          color: data.isEnabled
              ? Color(ListColor.colorLightGrey8)
              : Color(ListColor.colorLightGrey2)),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          onTap: data.onTap,
          child: Container(
              padding: EdgeInsets.all(18),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    child: Center(
                      child: SvgPicture.asset(
                        data.urlIcon,
                        color: data.title ==
                                "ProfileShipperLabelManajemenLokasi".tr
                            ? null
                            : (data.isEnabled
                                ? Color(ListColor.colorDarkGrey3)
                                : Color(ListColor.colorLightGrey9)),
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: CustomText(data.title,
                        color: data.isEnabled
                            ? Color(ListColor.colorDarkGrey3)
                            : Color(ListColor.colorLightGrey9),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: data.isEnabled
                        ? Color(ListColor.colorDarkGrey3)
                        : Color(ListColor.colorLightGrey9),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
