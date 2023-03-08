import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/modules/ARK/tender/tender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/global_variable.dart' as gv;
import 'dart:math' as math;

class TenderView extends GetView<TenderController> {
  // double _heightAppBar = AppBar().preferredSize.height + 30;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
          child: Container(
            alignment: Alignment.center,
            height: GlobalVariable.ratioWidth(Get.context) * 56,
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 16),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(GlobalVariable.urlImageNavbar),
                    fit: BoxFit.fill),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
                color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + "ic_back_button.svg",
                            color: GlobalVariable.tabDetailAcessoriesMainColor,
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24))),
                Container(
                  child: CustomText(
                    "TenderMenuIndexLabelJudulHalaman".tr, //Tender
                    fontWeight: FontWeight.w700,
                    fontSize: 16.00,
                    // color: Color(ListColor.colorWhite),
                    color: GlobalVariable.tabDetailAcessoriesMainColor,
                  ),
                ),
                Container(
                    child: GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + "ic_back_button.svg",
                            color: Colors.transparent,
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24))),
              ],
            ),
          )),
      bottomNavigationBar: BottomAppBarMuat(
        centerItemText: '',
        color: Colors.grey,
        backgroundColor: Colors.white,
        selectedColor: Color(ListColor.colorSelectedBottomMenu),
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (index) async {
          switch (index) {
            case 0:
              {
                // Get.toNamed(Routes.INBOX);
                await Chat.init(GlobalVariable.docID, gv.GlobalVariable.fcmToken);
                Chat.toInbox();
                break;
              }
            case 1:
              {
                Get.toNamed(Routes.PROFIL);
                break;
              }
          }
        },
        items: [
          BottomAppBarItemModel(iconName: 'message_menu_icon.svg', text: ''),
          BottomAppBarItemModel(iconName: 'user_menu_icon.svg', text: ''),
        ],
        iconSize: 40,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(),
        child: FloatingActionButton(
          backgroundColor: Color(ListColor.colorYellow),
          onPressed: () {
            Get.reset();
            Get.offAllNamed(Routes.AFTER_LOGIN_SUBUSER, arguments: [true]);
          },
          child: Image(
            image: AssetImage(
                GlobalVariable.imagePath + "smile_muat_muat_icon.png"),
            width: 60,
            height: 60,
          ),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 90.0)),
              side: BorderSide(color: Colors.white, width: 4.0)),
        ),
      ),
      body: SafeArea(
          child: Obx(
        () => !controller.onLoading.value
            ? ListView(
                children: [
                  //Memanggil List dari menuTender yang ada pada Controller
                  for (var i = 0; i < controller.menuTender.length; i++)
                    controller.menuTender[i],
                  controller.showFirstTime.value
                      ? controller.firstTimeYellowBox()
                      : SizedBox.shrink()
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      )),
    ));
  }
}
