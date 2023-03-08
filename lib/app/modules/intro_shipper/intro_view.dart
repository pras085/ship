import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/before_login/beforeLoginUser_controller.dart';
import 'package:muatmuat/app/modules/intro_shipper/intro_controller.dart';
import 'package:muatmuat/app/modules/intro_shipper/intro_snapping.dart';
import 'package:muatmuat/app/modules/login/login_controller.dart';
import 'package:muatmuat/app/modules/login/login_view.dart';
import 'package:muatmuat/app/modules/register_user/register_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class IntroShipperView extends GetView<IntroShipperController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuild());
    PageController pageController = PageController();
    Chat.newInstance();
    return Stack(
      children: [
        Obx(
          () {
            if (controller.loadingSplash.value) {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
            } else {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
            }
            return Container(
              color: Color(
                controller.loadingSplash.value
                    ? ListColor.colorBlue
                    : ListColor.colorWhite,
              ),
              child: SafeArea(
                  child: Scaffold(
                body: controller.loadingSplash.value
                    // SPLASH SCREEN
                    ? Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                            height: double.infinity,
                            alignment: Alignment.center,
                            color: Color(ListColor.colorBlue),
                            child: SvgPicture.asset(
                              "assets/ic_logo_muatmuat_putih.svg",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 200,
                            ),
                          ),
                          Image.asset(
                            "assets/meteor_putih.png",
                            width: GlobalVariable.ratioWidth(Get.context) * 91,
                            height: GlobalVariable.ratioWidth(Get.context) * 91,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              "assets/meteor_putih.png",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 91,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 91,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 12),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                  Container(
                                    padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 12),
                                    child: Obx(()=> CustomText(controller.loadingText.value, color: Colors.white, fontSize: 12))
                                  )
                                ],
                              )
                            )
                          ),
                        ],
                      )
                      // INTRO / ONBOARDING
                    : Stack(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            color: Colors.white,
                            width: double.infinity,
                            height: double.infinity,
                            child: Image.asset(
                              "assets/meteor_biru.png",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 91,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 91,
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // TOP SECTION / APPBAR ONBOARD
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        // LOGO
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24),
                                          child: SvgPicture.asset(
                                            "assets/ic_logo_muatmuat.svg",
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                21,
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                120,
                                          ),
                                        ),
                                        // BUTTON CHANGE LANGUAGE
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.showlan();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                right: GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                                top: GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        24,
                                              ),
                                              child: controller
                                                          .selectedLang.value ==
                                                      'true'
                                                  ? Image.asset(
                                                      'assets/chglan.png',
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          18,
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          46,
                                                    )
                                                  : Image.asset(
                                                      'assets/chglanen.png',
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          18,
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          46,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(context) *
                                              42,
                                    ),
                                    // CONTENT
                                    Container(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          376,
                                      child: PageView(
                                        onPageChanged: (index) {
                                          controller.slideIndex.value = index;
                                        },
                                        controller: pageController,
                                        children: [
                                          for (int i = 0;
                                              i < controller.listSlides.length;
                                              i++)
                                            Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        bottom:
                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                58),
                                                    height:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            180,
                                                    width:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            180,
                                                    child: CachedNetworkImage(
                                                        height:
                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                180,
                                                        fit: BoxFit.cover,
                                                        imageUrl: controller
                                                                .listSlides[i]
                                                                .image ??
                                                            "")),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16,
                                                      right: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16,
                                                      bottom: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          18),
                                                  child: CustomText(
                                                    controller
                                                        .listSlides[i].title,
                                                    fontSize: 18,
                                                    height: 1.2,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(
                                                        ListColor.colorBlue),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16,
                                                  ),
                                                  child: Html(
                                                    data: controller
                                                        .listSlides[i].desc,
                                                    style: {
                                                      "p": Style(
                                                        textAlign:
                                                            TextAlign.center,
                                                        margin: EdgeInsets.zero,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        fontFamily:
                                                            "AvenirNext",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        lineHeight:
                                                            LineHeight(1.2),
                                                        color: Color(ListColor
                                                            .colorGrey3),
                                                        // color: Color(ListColor.colorBlue),
                                                        fontSize: FontSize(
                                                            GlobalVariable
                                                                    .ratioFontSize(
                                                                        Get.context) *
                                                                12),
                                                      ),
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          // top:
                                          //     GlobalVariable.ratioWidth(Get.context) * 22,
                                          bottom: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              42),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          for (int i = 0;
                                              i < controller.listSlides.length;
                                              i++)
                                            _buildPageIndicator(i),
                                        ],
                                      ),
                                    ),
                                    Obx(
                                      () => _button(
                                          // text: controller.slideIndex.value ==
                                          //         controller.listSlides.length - 1 ? "BFTMLogin".tr : "BFTMRegisterAllSelanjutnya".tr,
                                          text: controller.slideIndex.value ==
                                                  controller.listSlides.length -
                                                      1
                                              ? "BFTMRegisterAllSelanjutnya".tr
                                              : "BFTMRegisterAllSelanjutnya".tr,
                                          height: 35,
                                          maxWidth: true,
                                          marginLeft: 16,
                                          marginRight: 16,
                                          // marginTop: 12,
                                          marginBottom: 12,
                                          fontSize: 14,
                                          backgroundColor:
                                              Color(ListColor.colorBlue),
                                          color: Color(ListColor.colorWhite),
                                          onTap: () async {
                                            //jika slide terakhir
                                            if (controller.slideIndex.value ==
                                                controller.listSlides.length -
                                                    1) {
                                              // update value sharedPref
                                              await controller.setStatusIntro();
                                              //pergi ke register
                                              // GetToPage.offNamed<
                                              //         SyaratDanKetentuanController>(
                                              //     Routes.SYARAT_DAN_KETENTUAN);
                                              // GetToPage.offNamed<
                                              //           // GetToPage.offNamed<
                                              //           LoginSellerController>(
                                              //       Routes.LOGIN);

                                              // GetToPage.offNamed<
                                              //           // GetToPage.offNamed<
                                              //           LoginController>(
                                              //       Routes.LOGIN);
                                              GetToPage.offNamed<
                                                      BeforeLoginUserController>(
                                                  Routes.BEFORE_LOGIN_USER);
                                            } else {
                                              // GetToPage.offNamed<
                                              //           // GetToPage.offNamed<
                                              //           LoginController>(
                                              //       Routes.LOGIN);

                                              pageController.animateToPage(
                                                  controller.slideIndex.value +
                                                      1,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.linear);
                                            }
                                          }),
                                    ),
                                    controller.slideIndex.value !=
                                            controller.listSlides.length - 1
                                        ? GestureDetector(
                                            onTap: () {
                                              pageController.animateToPage(
                                                  controller.listSlides.length -
                                                      1,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.linear);
                                            },
                                            child: CustomText(
                                              "BFTMSkip".tr,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color:
                                                  Color(ListColor.colorGrey3),
                                            ),
                                          )
                                        : SizedBox.shrink()
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
              )),
            );
          },
        ),
        Obx(() => controller.show.value
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Color(0xFF000000).withOpacity(0.2),
              )
            : Container(),
        ),
        Obx(() =>
            controller.show.value ? SimpleSnappingSheet() : SizedBox.shrink()),
        Obx(() => controller.chglan.value
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Color(0xFF000000).withOpacity(0.25),
              )
            : SizedBox.shrink()),
        //  Obx(() => controller.show.value? Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, color: Color(0xFF000000).withOpacity(0.2), child: Center(child: CircularProgressIndicator(),)) : Container()),
        Obx(() => controller.chglan.value
            ? Center(
                child: Container(
                    width: 50, height: 50, child: CircularProgressIndicator()),
              )
            : SizedBox.shrink()),
      ],
    );
  }

  Widget _buildPageIndicator(int i) {
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 4),
        height: GlobalVariable.ratioWidth(Get.context) * 8,
        width: GlobalVariable.ratioWidth(Get.context) * 8,
        decoration: BoxDecoration(
          color: controller.slideIndex.value == i
              ? Color(ListColor.colorBlue)
              : Color(ListColor.colorLightBlue3),
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * 12),
        ),
      ),
    );
  }

  List<Widget> getSliderView() {
    List<Widget> listSliderWidget = List<Widget>();
    for (int i = 0; i < controller.listSlides.length; i++) {
      listSliderWidget.add(SlideTile(
        imagePath: controller.listSlides[i].image,
        title: controller.listSlides[i].title,
        subTitle: "-",
        desc: controller.listSlides[i].desc,
      ));
    }
    return listSliderWidget;
  }

  Widget _button({
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = true,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  final String imagePath, title, subTitle, desc;

  SlideTile({this.imagePath, this.title, this.subTitle, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Color(0xFF176CF7),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 20,
          ),
          CustomText(
            title,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
            fontSize: 21,
            color: Colors.white,
          ),
          ((subTitle.isEmpty)
              ? SizedBox(
                  height: 30,
                )
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: CustomText(
                    subTitle,
                    textAlign: TextAlign.center,
                    fontSize: 21,
                    color: Colors.white,
                  ),
                )),
          CustomText(desc,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.white)
        ],
      ),
    );
  }
}
