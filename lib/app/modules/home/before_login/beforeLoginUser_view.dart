import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/before_login/beforeLoginUser_controller.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/modules/login/login_controller.dart';
import 'package:muatmuat/app/modules/register_user/register_controller.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';
import 'package:muatmuat/app/modules/setting/setting_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart' as lc;
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/app/template/widgets/card/card_company.dart';
import 'package:muatmuat/app/template/widgets/card/card_product.dart';
import 'package:muatmuat/app/widgets/scaffold_with_bottom_navbar.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_shadow/simple_shadow.dart';

class BeforeLoginUserView extends GetView<BeforeLoginUserController> {
  final double _sizeIconHeader = 30;
  final double _sizeIconBalance = 30;
  final double _heightBalance = 150;
  final double _sizeIconBelowBalance = 30;
  final double _spaceMenu = GlobalVariable.ratioWidth(Get.context) * 20;
  DateTime currentBackPressTime;
  double _getWidthOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double _getHeightOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double _getSizeSmallestWidthHeight(BuildContext context) =>
      _getWidthOfScreen(context) < _getHeightOfScreen(context)
          ? _getWidthOfScreen(context)
          : _getHeightOfScreen(context);
  double _marginHorizontal() => _spaceMenu * 2;
  double _widthContainer(BuildContext context) =>
      _getSizeSmallestWidthHeight(context) - 32;
  double _widthPerMenu(BuildContext context) =>
      (_widthContainer(context) - _marginHorizontal()) / 3;
  double _heightPerMenu(BuildContext context) =>
      (_widthPerMenu(context) * 1.17).roundToDouble();
  double _sizeTextMenu(BuildContext context) => _heightPerMenu(context) / 11.2;
  double _sizeIconMenu(BuildContext context) => _widthPerMenu(context) / 1.5;

  @override
  void onInit() async {}

  double widthArticle(BuildContext context) =>
      MediaQuery.of(context).size.width - 40;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.firstInit());
    return Obx(() => ScaffoldWithBottomNavbar(
      beforeLogin: true,
      newNotif: controller.newNotif.value,
      body: !controller.loading.value
              ? SafeArea(
                  bottom: false,
                  child: Container(
                    color: Color(ListColor.colorBackHome1),
                    child: WillPopScope(
                      onWillPop: onWillPop,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: GlobalVariable.ratioWidth(Get.context) *
                                    130),
                            child: Image(
                              image: AssetImage(
                                  GlobalVariable.backgroundAfterLogin),
                              width: MediaQuery.of(Get.context).size.width,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        //header
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    16,
                                            vertical: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                24,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                GlobalVariable.imagePath +
                                                    "white_logo_icon.png",
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        24,
                                              ),
                                              // Container(
                                              //   child: Column(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment.start,
                                              //     crossAxisAlignment:
                                              //         CrossAxisAlignment.start,
                                              //     children: [
                                              //       CustomText(
                                              //         controller.salam,
                                              //         color: Colors.white,
                                              //         fontSize: 12,
                                              //         fontWeight:
                                              //             FontWeight.w500,
                                              //       ),
                                              //       CustomText(
                                              //         controller.namaUser,
                                              //         color: Colors.white,
                                              //         fontSize: 16,
                                              //         fontWeight:
                                              //             FontWeight.w700,
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              Container(
                                                child: Wrap(
                                                  children: [
                                                    Container(
                                                      child: SvgPicture.asset(
                                                        GlobalVariable
                                                                .imagePathArk +
                                                            "calluser.svg",
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            24,
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            24,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          12,
                                                    ),
                                                    Container(
                                                      child: SvgPicture.asset(
                                                        GlobalVariable
                                                                .imagePath +
                                                            "question-circle.svg",
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            24,
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            24,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //Carousel
                                        CarouselSlider(
                                          items: controller.imageSliders.value,
                                          options: CarouselOptions(
                                            autoPlay: false,
                                            enlargeCenterPage: false,
                                            viewportFraction: 1,
                                            height: GlobalVariable.ratioWidth(
                                                    context) *
                                                82,
                                            onPageChanged: (index, reason) {
                                              controller.indexImageSlider
                                                  .value = index;
                                            },
                                          ),
                                        ),
                                        Obx(
                                          () => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      controller.imageSliders
                                                          .value.length;
                                                  i++)
                                                i ==
                                                        controller
                                                            .indexImageSlider
                                                            .value
                                                    ? _buildPageIndicator(true)
                                                    : _buildPageIndicator(
                                                        false),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        GlobalVariable.ratioWidth(context) * 10,
                                      ),
                                      topRight: Radius.circular(
                                        GlobalVariable.ratioWidth(context) * 10,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      !controller.login
                                          ? Container(
                                              decoration: BoxDecoration(
                                                color: Color(
                                                    ListColor.colorLightBlue3),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                    GlobalVariable.ratioWidth(
                                                            context) *
                                                        10,
                                                  ),
                                                  topRight: Radius.circular(
                                                    GlobalVariable.ratioWidth(
                                                            context) *
                                                        10,
                                                  ),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                                horizontal:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        22,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                    "ManajemenUserLandingPageDaftarMuatMuatSekarangDanJelajahiLebihLuas"
                                                        .tr,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  SizedBox(
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          12),
                                                  Container(
                                                      child: Row(children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: MaterialButton(
                                                        elevation: 0,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          vertical: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              8,
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            26)),
                                                            side: BorderSide(
                                                                width: GlobalVariable
                                                                        .ratioWidth(Get
                                                                            .context) *
                                                                    1.5,
                                                                color: Color(
                                                                    ListColor
                                                                        .color4))),
                                                        color: Colors.white,
                                                        onPressed: () {
                                                          GetToPage.toNamed<
                                                                  LoginController>(
                                                              Routes.LOGIN);
                                                        },
                                                        child: CustomText(
                                                          "ManajemenUserLandingPageMasuk"
                                                              .tr, //Masuk
                                                          color: Color(
                                                              ListColor.color4),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            12),
                                                    Expanded(
                                                        flex: 1,
                                                        child: MaterialButton(
                                                          elevation: 0,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                8,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(
                                                                      GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          26))),
                                                          color: Color(
                                                              ListColor.color4),
                                                          onPressed: () {
                                                            GetToPage.toNamed<
                                                                    RegisterUserController>(
                                                                Routes
                                                                    .REGISTER_USER);
                                                          },
                                                          child: CustomText(
                                                            "ManajemenUserLandingPageDaftar"
                                                                .tr, // Daftar
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12,
                                                          ),
                                                        )),
                                                  ]))
                                                ],
                                              ))
                                          : SizedBox(),
                                      SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                      ),
                                      Obx(
                                        () => _buildMenu(
                                            controller.listWidgetLogistic.value,
                                            "ManajemenUserLandingPagePengirimanBarang"
                                                .tr,
                                            controller.listWidgetLogistic.length
                                                    .toString() +
                                                " " +
                                                "ManajemenUserLandingPageLayananTersedia"
                                                    .tr,
                                            context,
                                            true),
                                      ),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24),
                                      Obx(
                                        () => _buildMenu(
                                            controller.listWidgetSupport.value,
                                            "ManajemenUserLandingPageKebutuhanLogistik"
                                                .tr,
                                            controller.listWidgetSupport.length
                                                    .toString() +
                                                " " +
                                                "ManajemenUserLandingPageLayananTersedia"
                                                    .tr,
                                            context,
                                            false),
                                      ),
                                      SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                      ),
                                      Stack(
                                        children: [
                                          Positioned(
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                      GlobalVariable
                                                              .imagePathArk +
                                                          "section.png",
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          142))),
                                          Positioned.fill(
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  33,
                                              bottom: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  23,
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .openOtherApps();
                                                      },
                                                      child: Container(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            165,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              22,
                                                          vertical: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              6,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white, // white
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            20))),
                                                        child: CustomText(
                                                          "ManajemenUserLandingPageBergabungSeller"
                                                              .tr, // Bergabung Seller/Partner
                                                          color: Color(
                                                              ListColor.color4),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 10,
                                                        ),
                                                      ))))
                                        ],
                                      ),
                                      SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                      ),
                                      // //BUYER
                                      // //BUYER
                                      // Container(
                                      //     margin: EdgeInsets.only(
                                      //         left: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             16,
                                      //         right: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             16),
                                      //     child: Row(
                                      //       children: [
                                      //         SvgPicture.asset(
                                      //           GlobalVariable.imagePathArk +
                                      //               "transporation_store.svg",
                                      //           width:
                                      //               GlobalVariable.ratioWidth(
                                      //                       Get.context) *
                                      //                   24,
                                      //           height:
                                      //               GlobalVariable.ratioWidth(
                                      //                       Get.context) *
                                      //                   24,
                                      //         ),
                                      //         SizedBox(
                                      //           width:
                                      //               GlobalVariable.ratioWidth(
                                      //                       Get.context) *
                                      //                   6,
                                      //         ),
                                      //         CustomText("Transportation Store",
                                      //             fontWeight: FontWeight.w600,
                                      //             fontSize: 14,
                                      //             color: Colors.black),
                                      //         Expanded(child: CustomText("")),
                                      //         GestureDetector(
                                      //             onTap: () {
                                      //               controller.lainnya(
                                      //                   "TRANSPORTATION_STORE");
                                      //             },
                                      //             child: Container(
                                      //                 child: CustomText(
                                      //                     "ManajemenUserLandingPageLihatSemua"
                                      //                         .tr, // Lihat Semua
                                      //                     fontWeight:
                                      //                         FontWeight.w600,
                                      //                     fontSize: 12,
                                      //                     color: Color(ListColor
                                      //                         .colorBlue)))),
                                      //       ],
                                      //     )),
                                      // controller.transporationStoreList
                                      //             .length ==
                                      //         0
                                      //     ? SizedBox(
                                      //         height: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             24,
                                      //       )
                                      //     : SizedBox(
                                      //         height: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             16,
                                      //       ),
                                      // controller.transporationStoreList
                                      //             .length ==
                                      //         0
                                      //     ? SizedBox()
                                      //     : Obx(() => Container(
                                      //         width: MediaQuery.of(Get.context)
                                      //             .size
                                      //             .width,
                                      //         child: SingleChildScrollView(
                                      //             scrollDirection:
                                      //                 Axis.horizontal,
                                      //             child: Row(children: [
                                      //               for (var x = 0;
                                      //                   x <
                                      //                       controller
                                      //                           .transporationStoreList
                                      //                           .length;
                                      //                   x++)
                                      //                 Container(
                                      //                     padding: EdgeInsets.only(
                                      //                         bottom:
                                      //                             GlobalVariable.ratioWidth(Get.context) *
                                      //                                 24),
                                      //                     margin: EdgeInsets.only(
                                      //                         left: x == 0
                                      //                             ? GlobalVariable.ratioWidth(Get.context) *
                                      //                                 16
                                      //                             : 0,
                                      //                         right: (x < controller.transporationStoreList.length - 1
                                      //                             ? GlobalVariable.ratioWidth(Get.context) *
                                      //                                 10
                                      //                             : GlobalVariable.ratioWidth(
                                      //                                     Get.context) *
                                      //                                 16)),
                                      //                     child: x == controller.transporationStoreList.length - 1
                                      //                         &&  controller.transporationStoreList.length > 20
                                      //                         ? GestureDetector(
                                      //                             onTap: () {
                                      //                               controller
                                      //                                   .lainnya(
                                      //                                       "TRANSPORTATION_STORE");
                                      //                             },
                                      //                             child: Container(
                                      //                                 width: GlobalVariable.ratioWidth(Get.context) * 156,
                                      //                                 height: GlobalVariable.ratioWidth(Get.context) * 255,
                                      //                                 decoration: BoxDecoration(
                                      //                                   borderRadius:
                                      //                                       BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                      //                                           8),
                                      //                                   boxShadow: [
                                      //                                     BoxShadow(
                                      //                                         offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13),
                                      //                                         blurRadius: GlobalVariable.ratioWidth(Get.context) * 10,
                                      //                                         spreadRadius: 0,
                                      //                                         color: Colors.black.withOpacity(0.1))
                                      //                                   ],
                                      //                                 ),
                                      //                                 child: Stack(
                                      //                                   children: [
                                      //                                     Positioned.fill(
                                      //                                         child: Align(alignment: Alignment.center, child: Container(width: GlobalVariable.ratioWidth(Get.context) * 156, height: GlobalVariable.ratioWidth(Get.context) * 255, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 8), border: Border.all(width: GlobalVariable.ratioWidth(Get.context) * 1, color: Color(ListColor.color4)))))),
                                      //                                     Positioned.fill(
                                      //                                         child: Align(
                                      //                                             alignment: Alignment.center,
                                      //                                             child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      //                                               SimpleShadow(
                                      //                                                 child: SvgPicture.asset(GlobalVariable.imagePathArk + "button_next.svg", width: GlobalVariable.ratioWidth(Get.context) * 80, height: GlobalVariable.ratioWidth(Get.context) * 80),
                                      //                                                 opacity: 0.5,
                                      //                                                 color: Colors.black.withOpacity(0.1),
                                      //                                                 offset: Offset(0, 5),
                                      //                                                 sigma: 3,
                                      //                                               ),
                                      //                                               SizedBox(
                                      //                                                 height: GlobalVariable.ratioWidth(Get.context) * 12,
                                      //                                               ),
                                      //                                               Container(
                                      //                                                   padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 20),
                                      //                                                   child: CustomText(
                                      //                                                     "ManajemenUserLandingPageLihatPenawaranLainnya".tr, // LIHAT PENAWARAN LAINNYA
                                      //                                                     fontSize: 12,
                                      //                                                     height: 1.2,
                                      //                                                     textAlign: TextAlign.center,
                                      //                                                     fontWeight: FontWeight.w600,
                                      //                                                     color: Color(ListColor.color4),
                                      //                                                   ))
                                      //                                             ]))),
                                      //                                     Positioned.fill(
                                      //                                         //right: GlobalVariable.ratioWidth(Get.context) * 0.5,
                                      //                                         bottom: GlobalVariable.ratioWidth(Get.context) * 1,
                                      //                                         child: Align(
                                      //                                           alignment: Alignment.bottomRight,
                                      //                                           child: ClipRRect(
                                      //                                               borderRadius: BorderRadius.only(
                                      //                                                 bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 8),
                                      //                                               ),
                                      //                                               child: Image.asset(GlobalVariable.imagePathArk + "set_lingkaran.png", width: GlobalVariable.ratioWidth(Get.context) * 60, height: GlobalVariable.ratioWidth(Get.context) * 60)),
                                      //                                         ))
                                      //                                   ],
                                      //                                 )))
                                      //                         : CardProduct(
                                      //                             cardShadow: BoxShadow(offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13), blurRadius: GlobalVariable.ratioWidth(Get.context) * 10, spreadRadius: 0, color: Colors.black.withOpacity(0.1)),
                                      //                             onTap: () {
                                      //                               controller
                                      //                                   .popUpDetail(
                                      //                                       "TRANSPORTATION_STORE");
                                      //                             },
                                      //                             onFavorited: () {
                                      //                               if (controller
                                      //                                   .login) {
                                      //                                 controller
                                      //                                     .setFavourite(
                                      //                                         x,
                                      //                                         "TRANSPORTATION_STORE");
                                      //                               } else {
                                      //                                 controller
                                      //                                     .popUpDaftar();
                                      //                               }
                                      //                             },
                                      //                             favorite: controller.transporationStoreList[x]['favorit'] == "1" ? true : false,
                                      //                             verified: controller.transporationStoreList[x]['isverified'] == "1" ? true : false,
                                      //                             highlight: controller.transporationStoreList[x]['ishighlight'] == "1" ? true : false,
                                      //                             detail: controller.transporationStoreList[x]['detail'],
                                      //                             price: double.parse(controller.transporationStoreList[x]['Harga'] == "" || controller.transporationStoreList[x]['Harga'] == null ? "0" : controller.transporationStoreList[x]['Harga']),
                                      //                             imageUrl: controller.transporationStoreList[x]['gambar'],
                                      //                             date: DateTime.parse(controller.transporationStoreList[x]['Created'].toString()),
                                      //                             title: controller.transporationStoreList[x]['Judul'],
                                      //                             location: controller.transporationStoreList[x]['LokasiIklan'])),
                                      //             ])))),
                                      // //BUYER
                                      // Container(
                                      //     margin: EdgeInsets.only(
                                      //         left: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             16,
                                      //         right: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             16),
                                      //     child: Row(
                                      //       children: [
                                      //         SvgPicture.asset(
                                      //           GlobalVariable.imagePathArk +
                                      //               "dealer.svg",
                                      //           width:
                                      //               GlobalVariable.ratioWidth(
                                      //                       Get.context) *
                                      //                   24,
                                      //           height:
                                      //               GlobalVariable.ratioWidth(
                                      //                       Get.context) *
                                      //                   24,
                                      //         ),
                                      //         SizedBox(
                                      //           width:
                                      //               GlobalVariable.ratioWidth(
                                      //                       Get.context) *
                                      //                   6,
                                      //         ),
                                      //         CustomText("Dealer & Karoseri",
                                      //             fontWeight: FontWeight.w600,
                                      //             fontSize: 14,
                                      //             color: Colors.black),
                                      //         Expanded(child: CustomText("")),
                                      //         GestureDetector(
                                      //             onTap: () {
                                      //               controller.lainnya(
                                      //                   "DEALER_KAROSERI");
                                      //             },
                                      //             child: Container(
                                      //                 child: CustomText(
                                      //                     "ManajemenUserLandingPageLihatSemua"
                                      //                         .tr, // Lihat Semua
                                      //                     fontWeight:
                                      //                         FontWeight.w600,
                                      //                     fontSize: 12,
                                      //                     color: Color(ListColor
                                      //                         .colorBlue)))),
                                      //       ],
                                      //     )),
                                      // controller.dealerKaroseriList.length == 0
                                      //     ? SizedBox(
                                      //         height: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             24)
                                      //     : SizedBox(
                                      //         height: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             16,
                                      //       ),
                                      // controller.dealerKaroseriList.length == 0
                                      //     ? SizedBox()
                                      //     : Obx(() => Container(
                                      //         width: MediaQuery.of(Get.context)
                                      //             .size
                                      //             .width,
                                      //         child: SingleChildScrollView(
                                      //             scrollDirection:
                                      //                 Axis.horizontal,
                                      //             child: Row(children: [
                                      //               for (var x = 0;
                                      //                   x <
                                      //                       controller
                                      //                           .dealerKaroseriList
                                      //                           .length;
                                      //                   x++)
                                      //                 Container(
                                      //                     padding: EdgeInsets.only(
                                      //                         bottom:
                                      //                             GlobalVariable.ratioWidth(Get.context) *
                                      //                                 24),
                                      //                     margin: EdgeInsets.only(
                                      //                         left: x == 0
                                      //                             ? GlobalVariable.ratioWidth(Get.context) *
                                      //                                 16
                                      //                             : 0,
                                      //                         right: (x <
                                      //                                 controller
                                      //                                         .dealerKaroseriList
                                      //                                         .length -
                                      //                                     1
                                      //                             ? GlobalVariable.ratioWidth(Get.context) * 10
                                      //                             : GlobalVariable.ratioWidth(Get.context) * 16)),
                                      //                     child: x == controller.dealerKaroseriList.length - 1
                                      //                         && controller.dealerKaroseriList.length > 20
                                      //                         ? GestureDetector(
                                      //                             onTap: () {
                                      //                               controller
                                      //                                   .lainnya(
                                      //                                       "DEALER_KAROSERI");
                                      //                             },
                                      //                             child: Container(
                                      //                                 width: GlobalVariable.ratioWidth(Get.context) * 156,
                                      //                                 height: GlobalVariable.ratioWidth(Get.context) * 339,
                                      //                                 decoration: BoxDecoration(
                                      //                                   color: Colors
                                      //                                       .white,
                                      //                                   borderRadius:
                                      //                                       BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                      //                                           8),
                                      //                                   boxShadow: [
                                      //                                     BoxShadow(
                                      //                                         offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13),
                                      //                                         blurRadius: GlobalVariable.ratioWidth(Get.context) * 10,
                                      //                                         spreadRadius: 0,
                                      //                                         color: Colors.black.withOpacity(0.1))
                                      //                                   ],
                                      //                                 ),
                                      //                                 child: Stack(
                                      //                                   children: [
                                      //                                     Positioned.fill(
                                      //                                         child: Align(alignment: Alignment.center, child: Container(width: GlobalVariable.ratioWidth(Get.context) * 156, height: GlobalVariable.ratioWidth(Get.context) * 339, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 8), border: Border.all(width: GlobalVariable.ratioWidth(Get.context) * 1, color: Color(ListColor.color4)))))),
                                      //                                     Positioned.fill(
                                      //                                         child: Align(
                                      //                                             alignment: Alignment.center,
                                      //                                             child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      //                                               SimpleShadow(
                                      //                                                 child: SvgPicture.asset(GlobalVariable.imagePathArk + "button_next.svg", width: GlobalVariable.ratioWidth(Get.context) * 80, height: GlobalVariable.ratioWidth(Get.context) * 80),
                                      //                                                 opacity: 0.5,
                                      //                                                 color: Colors.black.withOpacity(0.1),
                                      //                                                 offset: Offset(0, 5),
                                      //                                                 sigma: 3,
                                      //                                               ),
                                      //                                               SizedBox(
                                      //                                                 height: GlobalVariable.ratioWidth(Get.context) * 12,
                                      //                                               ),
                                      //                                               Container(
                                      //                                                   padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 20),
                                      //                                                   child: CustomText(
                                      //                                                     "ManajemenUserLandingPageLihatPenawaranLainnya".tr, // LIHAT PENAWARAN LAINNYA
                                      //                                                     fontSize: 12,
                                      //                                                     height: 1.2,
                                      //                                                     textAlign: TextAlign.center,
                                      //                                                     fontWeight: FontWeight.w600,
                                      //                                                     color: Color(ListColor.color4),
                                      //                                                   ))
                                      //                                             ]))),
                                      //                                     Positioned.fill(
                                      //                                         bottom: GlobalVariable.ratioWidth(Get.context) * 1,
                                      //                                         child: Align(
                                      //                                           alignment: Alignment.bottomRight,
                                      //                                           child: ClipRRect(
                                      //                                               borderRadius: BorderRadius.only(
                                      //                                                 bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 8),
                                      //                                               ),
                                      //                                               child: Image.asset(GlobalVariable.imagePathArk + "set_lingkaran.png", width: GlobalVariable.ratioWidth(Get.context) * 60, height: GlobalVariable.ratioWidth(Get.context) * 60)),
                                      //                                         ))
                                      //                                   ],
                                      //                                 )))
                                      //                         : CardProduct(
                                      //                             cardShadow: BoxShadow(offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13), blurRadius: GlobalVariable.ratioWidth(Get.context) * 10, spreadRadius: 0, color: Colors.black.withOpacity(0.1)),
                                      //                             onTap: () {
                                      //                               controller
                                      //                                   .popUpDetail(
                                      //                                       "DEALER_KAROSERI");
                                      //                             },
                                      //                             onFavorited: () {
                                      //                               if (controller
                                      //                                   .login) {
                                      //                                 controller
                                      //                                     .setFavourite(
                                      //                                         x,
                                      //                                         "DEALER_KAROSERI");
                                      //                               } else {
                                      //                                 controller
                                      //                                     .popUpDaftar();
                                      //                               }
                                      //                             },
                                      //                             favorite: controller.dealerKaroseriList[x]['favorit'] == "1" ? true : false,
                                      //                             verified: controller.dealerKaroseriList[x]['isverified'] == "1" ? true : false,
                                      //                             highlight: controller.dealerKaroseriList[x]['ishighlight'] == "1" ? true : false,
                                      //                             detail: controller.dealerKaroseriList[x]['detail'],
                                      //                             price: double.tryParse(controller.dealerKaroseriList[x]['Harga']) ?? 0, // Tidak Ada Response
                                      //                             imageUrl: controller.dealerKaroseriList[x]['gambar'],
                                      //                             date: DateTime.parse(controller.dealerKaroseriList[x]['Created'].toString()),
                                      //                             showDateAtFooter: true,
                                      //                             company: controller.dealerKaroseriList[x]['data_seller']['nama_individu_perusahaan'],
                                      //                             title: controller.dealerKaroseriList[x]['TipeUnitTruk'],
                                      //                             location: controller.dealerKaroseriList[x]['LokasiIklan'])),
                                      //             ])))),
                                      // //BUYER
                                      // Container(
                                      //     margin: EdgeInsets.only(
                                      //         left: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             16,
                                      //         right: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             16),
                                      //     child: Row(
                                      //       children: [
                                      //         SvgPicture.asset(
                                      //           GlobalVariable.imagePathArk +
                                      //               "workshop_services.svg",
                                      //           width:
                                      //               GlobalVariable.ratioWidth(
                                      //                       Get.context) *
                                      //                   24,
                                      //           height:
                                      //               GlobalVariable.ratioWidth(
                                      //                       Get.context) *
                                      //                   24,
                                      //         ),
                                      //         SizedBox(
                                      //           width:
                                      //               GlobalVariable.ratioWidth(
                                      //                       Get.context) *
                                      //                   6,
                                      //         ),
                                      //         CustomText("Repair & Maintenance",
                                      //             fontWeight: FontWeight.w600,
                                      //             fontSize: 14,
                                      //             color: Colors.black),
                                      //         Expanded(child: CustomText("")),
                                      //         GestureDetector(
                                      //             onTap: () {
                                      //               controller.lainnya(
                                      //                   "REPAIR_MAINTENANCE");
                                      //             },
                                      //             child: Container(
                                      //                 child: CustomText(
                                      //                     "ManajemenUserLandingPageLihatSemua"
                                      //                         .tr, // Lihat Semua
                                      //                     fontWeight:
                                      //                         FontWeight.w600,
                                      //                     fontSize: 12,
                                      //                     color: Color(ListColor
                                      //                         .colorBlue)))),
                                      //       ],
                                      //     )),
                                      // controller.repairMaintenanceList.length ==
                                      //         0
                                      //     ? SizedBox(
                                      //         height: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             24)
                                      //     : SizedBox(
                                      //         height: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             16,
                                      //       ),
                                      // controller.repairMaintenanceList.length ==
                                      //         0
                                      //     ? SizedBox()
                                      //     : Obx(() => Container(
                                      //         child: SingleChildScrollView(
                                      //             scrollDirection:
                                      //                 Axis.vertical,
                                      //             child: Column(children: [
                                      //               for (var x = 0;
                                      //                   x <
                                      //                       controller
                                      //                           .repairMaintenanceList
                                      //                           .length;
                                      //                   x++)
                                      //                 Container(
                                      //                     margin: EdgeInsets.only(
                                      //                         left: GlobalVariable.ratioWidth(Get.context) *
                                      //                             16,
                                      //                         right:
                                      //                             GlobalVariable.ratioWidth(Get.context) *
                                      //                                 16,
                                      //                         bottom: (x < controller.repairMaintenanceList.length - 1
                                      //                             ? GlobalVariable.ratioWidth(Get.context) *
                                      //                                 10
                                      //                             : GlobalVariable.ratioWidth(Get.context) *
                                      //                                 24)),
                                      //                     child: CardCompany(
                                      //                         cardShadow: BoxShadow(
                                      //                             offset: Offset(
                                      //                                 0,
                                      //                                 GlobalVariable.ratioWidth(Get.context) * 13),
                                      //                             blurRadius: GlobalVariable.ratioWidth(Get.context) * 10,
                                      //                             spreadRadius: 0,
                                      //                             color: Colors.black.withOpacity(0.1)),
                                      //                         onTap: () {
                                      //                           controller
                                      //                               .popUpDetail(
                                      //                                   "REPAIR_MAINTENANCE");
                                      //                         },
                                      //                         onFavorited: () {
                                      //                           if (controller
                                      //                               .login) {
                                      //                             controller
                                      //                                 .setFavourite(
                                      //                                     x,
                                      //                                     "REPAIR_MAINTENANCE");
                                      //                           } else {
                                      //                             controller
                                      //                                 .popUpDaftar();
                                      //                           }
                                      //                         },
                                      //                         favorite: controller.repairMaintenanceList[x]['favorit'] == "1" ? true : false,
                                      //                         verified: controller.repairMaintenanceList[x]['isverified'] == "1" ? true : false,
                                      //                         highlight: controller.repairMaintenanceList[x]['ishighlight'] == "1" ? true : false,
                                      //                         detail: controller.repairMaintenanceList[x]['detail'], // Tidak Ada Response
                                      //                         imageUrl: controller.repairMaintenanceList[x]['gambar'],
                                      //                         address: controller.repairMaintenanceList[x]['Alamat'],
                                      //                         date: DateTime.parse(controller.repairMaintenanceList[x]['Created'].toString()),
                                      //                         title: controller.repairMaintenanceList[x]['data_seller']['nama_individu_perusahaan'],
                                      //                         location: controller.repairMaintenanceList[x]['LokasiIklan']))
                                      //             ])))),
                                      // //BUYER
                                      // Container(
                                      //     margin: EdgeInsets.only(
                                      //         left: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             16,
                                      //         right: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             16),
                                      //     child: Row(
                                      //       children: [
                                      //         SvgPicture.asset(
                                      //           GlobalVariable.imagePathArk +
                                      //               "property_warehoue.svg",
                                      //           width:
                                      //               GlobalVariable.ratioWidth(
                                      //                       Get.context) *
                                      //                   24,
                                      //           height:
                                      //               GlobalVariable.ratioWidth(
                                      //                       Get.context) *
                                      //                   24,
                                      //         ),
                                      //         SizedBox(
                                      //           width:
                                      //               GlobalVariable.ratioWidth(
                                      //                       Get.context) *
                                      //                   6,
                                      //         ),
                                      //         CustomText("Property & Warehouse",
                                      //             fontWeight: FontWeight.w600,
                                      //             fontSize: 14,
                                      //             color: Colors.black),
                                      //         Expanded(child: CustomText("")),
                                      //         GestureDetector(
                                      //             onTap: () {
                                      //               controller.lainnya(
                                      //                   "PROPERTY_WAREHOUSE");
                                      //             },
                                      //             child: Container(
                                      //                 child: CustomText(
                                      //                     "ManajemenUserLandingPageLihatSemua"
                                      //                         .tr, // Lihat Semua
                                      //                     fontWeight:
                                      //                         FontWeight.w600,
                                      //                     fontSize: 12,
                                      //                     color: Color(ListColor
                                      //                         .colorBlue)))),
                                      //       ],
                                      //     )),
                                      // controller.propertyWarehouseList.length ==
                                      //         0
                                      //     ? SizedBox(
                                      //         height: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             24)
                                      //     : SizedBox(
                                      //         height: GlobalVariable.ratioWidth(
                                      //                 Get.context) *
                                      //             16,
                                      //       ),
                                      // controller.propertyWarehouseList.length ==
                                      //         0
                                      //     ? SizedBox()
                                      //     : Obx(() => Container(
                                      //         child: SingleChildScrollView(
                                      //             scrollDirection:
                                      //                 Axis.horizontal,
                                      //             child: Row(children: [
                                      //               for (var x = 0;
                                      //                   x <
                                      //                       controller
                                      //                           .propertyWarehouseList
                                      //                           .length;
                                      //                   x++)
                                      //                 Container(
                                      //                     padding: EdgeInsets.only(
                                      //                         bottom:
                                      //                             GlobalVariable.ratioWidth(Get.context) *
                                      //                                 24),
                                      //                     margin: EdgeInsets.only(
                                      //                         left: x == 0
                                      //                             ? GlobalVariable.ratioWidth(Get.context) *
                                      //                                 16
                                      //                             : 0,
                                      //                         right: (x <
                                      //                                 controller
                                      //                                         .propertyWarehouseList
                                      //                                         .length -
                                      //                                     1
                                      //                             ? GlobalVariable.ratioWidth(Get.context) * 10
                                      //                             : GlobalVariable.ratioWidth(Get.context) * 16)),
                                      //                     child: x == controller.propertyWarehouseList.length - 1
                                      //                         && controller.propertyWarehouseList.length > 20
                                      //                         ? GestureDetector(
                                      //                             onTap: () {
                                      //                               controller
                                      //                                   .lainnya(
                                      //                                       "PROPERTY_WAREHOUSE");
                                      //                             },
                                      //                             child: Container(
                                      //                                 width: GlobalVariable.ratioWidth(Get.context) * 156,
                                      //                                 height: GlobalVariable.ratioWidth(Get.context) * 282,
                                      //                                 decoration: BoxDecoration(
                                      //                                   color: Colors
                                      //                                       .white,
                                      //                                   borderRadius:
                                      //                                       BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                      //                                           8),
                                      //                                   boxShadow: [
                                      //                                     BoxShadow(
                                      //                                         offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13),
                                      //                                         blurRadius: GlobalVariable.ratioWidth(Get.context) * 10,
                                      //                                         spreadRadius: 0,
                                      //                                         color: Colors.black.withOpacity(0.1))
                                      //                                   ],
                                      //                                 ),
                                      //                                 child: Stack(
                                      //                                   children: [
                                      //                                     Positioned.fill(
                                      //                                         child: Align(alignment: Alignment.center, child: Container(width: GlobalVariable.ratioWidth(Get.context) * 156, height: GlobalVariable.ratioWidth(Get.context) * 282, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 8), border: Border.all(width: GlobalVariable.ratioWidth(Get.context) * 1, color: Color(ListColor.color4)))))),
                                      //                                     Positioned.fill(
                                      //                                         child: Align(
                                      //                                             alignment: Alignment.center,
                                      //                                             child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      //                                               SimpleShadow(
                                      //                                                 child: SvgPicture.asset(GlobalVariable.imagePathArk + "button_next.svg", width: GlobalVariable.ratioWidth(Get.context) * 80, height: GlobalVariable.ratioWidth(Get.context) * 80),
                                      //                                                 opacity: 0.5,
                                      //                                                 color: Colors.black.withOpacity(0.1),
                                      //                                                 offset: Offset(0, 5),
                                      //                                                 sigma: 3,
                                      //                                               ),
                                      //                                               SizedBox(
                                      //                                                 height: GlobalVariable.ratioWidth(Get.context) * 12,
                                      //                                               ),
                                      //                                               Container(
                                      //                                                   padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 20),
                                      //                                                   child: CustomText(
                                      //                                                     "ManajemenUserLandingPageLihatPenawaranLainnya".tr, // LIHAT PENAWARAN LAINNYA
                                      //                                                     fontSize: 12,
                                      //                                                     height: 1.2,
                                      //                                                     textAlign: TextAlign.center,
                                      //                                                     fontWeight: FontWeight.w600,
                                      //                                                     color: Color(ListColor.color4),
                                      //                                                   ))
                                      //                                             ]))),
                                      //                                     Positioned.fill(
                                      //                                         bottom: GlobalVariable.ratioWidth(Get.context) * 1,
                                      //                                         child: Align(
                                      //                                             alignment: Alignment.bottomRight,
                                      //                                             child: Container(
                                      //                                               child: ClipRRect(
                                      //                                                   borderRadius: BorderRadius.only(
                                      //                                                     bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 8),
                                      //                                                   ),
                                      //                                                   child: Image.asset(GlobalVariable.imagePathArk + "set_lingkaran.png", width: GlobalVariable.ratioWidth(Get.context) * 60, height: GlobalVariable.ratioWidth(Get.context) * 60)),
                                      //                                             )))
                                      //                                   ],
                                      //                                 )))
                                      //                         : CardProduct(
                                      //                             cardShadow: BoxShadow(offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13), blurRadius: GlobalVariable.ratioWidth(Get.context) * 10, spreadRadius: 0, color: Colors.black.withOpacity(0.1)),
                                      //                             onTap: () {
                                      //                               controller
                                      //                                   .popUpDetail(
                                      //                                       "PROPERTY_WAREHOUSE");
                                      //                             },
                                      //                             onFavorited: () {
                                      //                               if (controller
                                      //                                   .login) {
                                      //                                 controller
                                      //                                     .setFavourite(
                                      //                                         x,
                                      //                                         "PROPERTY_WAREHOUSE");
                                      //                               } else {
                                      //                                 controller
                                      //                                     .popUpDaftar();
                                      //                               }
                                      //                             },
                                      //                             favorite: controller.propertyWarehouseList[x]['favorit'] == "1" ? true : false,
                                      //                             verified: controller.propertyWarehouseList[x]['isverified'] == "1" ? true : false,
                                      //                             highlight: controller.propertyWarehouseList[x]['ishighlight'] == "1" ? true : false,
                                      //                             detail: controller.propertyWarehouseList[x]['detail'],
                                      //                             price: double.parse(controller.propertyWarehouseList[x]['Harga'] == "" || controller.propertyWarehouseList[x]['Harga'] == null ? "0" : controller.propertyWarehouseList[x]['Harga']), // Tidak Ada Response
                                      //                             imageUrl: controller.propertyWarehouseList[x]['gambar'],
                                      //                             date: DateTime.parse(controller.propertyWarehouseList[x]['Created'].toString()),
                                      //                             title: controller.propertyWarehouseList[x]['Judul'],
                                      //                             location: controller.propertyWarehouseList[x]['LokasiIklan'])),
                                      //             ])))),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                            left: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            right: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                21),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                  "ManajemenUserLandingPageArtikel"
                                                      .tr, //Artikel
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black),
                                            ),
                                            InkWell(
                                              onTap: () =>
                                                  Get.toNamed(Routes.ARTICLE),
                                              child: CustomText(
                                                'ManajemenUserLandingPageLihatSemua'
                                                    .tr, //Lihat Semua
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Color(ListColor.colorBlue),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 17, bottom: 90),
                                        child: SizedBox(
                                          // height:
                                          //     MediaQuery.of(context).size.width -
                                          //         130,
                                          height: GlobalVariable.ratioWidth(
                                                  context) *
                                              250,
                                          child: ListView.separated(
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        10,
                                              );
                                            },
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 5,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                Container(
                                              margin: EdgeInsets.only(
                                                left: index == 0
                                                    ? GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12
                                                    : 0,
                                                right: index == 5 - 1
                                                    ? GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12
                                                    : 0,
                                                bottom:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        20,
                                              ),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  154,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              10)),
                                                ),
                                                elevation: 5,
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.toNamed(Routes.WEBVIEW);
                                                  },
                                                  child: Container(
                                                      child: Center(
                                                    child: IntrinsicWidth(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Container(
                                                            height: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                72,
                                                            width: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                154,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        6),
                                                                topRight: Radius
                                                                    .circular(
                                                                        6),
                                                              ),
                                                              child: controller.listArticle[
                                                                              index]
                                                                          [
                                                                          "Image"] ==
                                                                      null
                                                                  ? Image(
                                                                      image: AssetImage(
                                                                          GlobalVariable.imagePath +
                                                                              "gambar_example.jpeg"),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : Image
                                                                      .network(
                                                                      controller
                                                                              .listArticle[index]
                                                                          [
                                                                          "Image"],
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                72,
                                                            margin:
                                                                EdgeInsets.only(
                                                              top: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  12,
                                                              right: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  12,
                                                              left: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  12,
                                                            ),
                                                            child: CustomText(
                                                              controller.listArticle[
                                                                      index]
                                                                  ["title"],
                                                              maxLines: 4,
                                                              color: Color(ListColor
                                                                  .colorTextTitleArticle),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                              wrapSpace: true,
                                                              height: 1.2,
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                              horizontal: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  12,
                                                              vertical: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  8,
                                                            ),
                                                            child: CustomText(
                                                              controller.listArticle[
                                                                      index]
                                                                  ["category"],
                                                              color: Color(
                                                                ListColor
                                                                    .colorLightGrey4,
                                                              ),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              bottom: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  12,
                                                              left: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  12,
                                                              right: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  12,
                                                            ),
                                                            child: CustomText(
                                                              controller.listArticle[
                                                                      index][
                                                                  "last_edited"],
                                                              color: Color(
                                                                ListColor
                                                                    .colorLightGrey4,
                                                              ),
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
        : Center(child: CircularProgressIndicator())
        ));
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      CustomToast.show(
          context: Get.context, message: 'GlobalLabelBackAgainExit'.tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget _buildMenu(List<Widget> listData, String title, String desc,
      BuildContext context, bool probadge) {
    return Container(
      // margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: _widthContainer(context),
            // width:GlobalVariable.ratioWidth(Get.context) * 96,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title,
                      textAlign: TextAlign.left,
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 3,
                    ),
                    probadge
                        ? Container(
                            width: GlobalVariable.ratioWidth(Get.context) * 42,
                            // height: GlobalVariable.ratioWidth(Get.context) * 20,
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(ListColor.colorLightBlue3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 6,
                                ),
                              ),
                            ),
                            child: Center(
                              child: CustomText(
                                "PRO",
                                color: Color(ListColor.colorBlue),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                CustomText(
                  desc,
                  textAlign: TextAlign.left,
                  fontSize: 12.0,
                  color: Color(ListColor.colorTextDescriptionMenu1),
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(Get.context).size.width,
              margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 18),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
              child: Column(children: [
                for (var x = 0; x < listData.length; x++)
                  if (x % 3 == 0)
                    Container(
                        width: MediaQuery.of(Get.context).size.width,
                        padding: EdgeInsets.only(
                            bottom:
                                GlobalVariable.ratioWidth(Get.context) * 18),
                        child: Row(children: [
                          listData[x],
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 20),
                          (x + 1) % 3 == 1 && (x + 1) < listData.length
                              ? listData[x + 1]
                              : Expanded(child: CustomText("")),
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 20),
                          (x + 2) % 3 == 2 && (x + 2) < listData.length
                              ? listData[x + 2]
                              : Expanded(child: CustomText("")),
                        ]))
              ])),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(Get.context) * 24,
        horizontal: GlobalVariable.ratioWidth(Get.context) * 3,
      ),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isCurrentPage
              ? Color(ListColor.colorIndicatorSelectedHome)
              : Color(ListColor.colorGreyTemplate6),
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * 12),
          border: Border.all(width: 1, color: Colors.white)),
    );
  }

  Widget _buildMenuBelowBalanceCustomWidget(
      Widget widget, String title, Function() onTapFunction) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTapFunction();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              child: Center(
                child: widget,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 5),
                child: CustomText(title,
                    color: Color(ListColor.colorDarkGrey),
                    fontWeight: FontWeight.w700,
                    fontSize: 10))
          ]),
        ),
      ),
    );
  }
}
