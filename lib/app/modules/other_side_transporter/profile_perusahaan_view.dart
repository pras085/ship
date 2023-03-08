import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/report/report_controller.dart';
import 'package:muatmuat/app/modules/notification/notif_controller.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/data_armada/data_armada_controller.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/foto_dan_video/foto_video_controller.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/tentang_perusahaan/tentang_perusahaan_controller.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/profile_perusahaan_map_component.dart';
// import 'package:muatmuat/app/modules/foto_dan_video/foto_video_controller.dart';
// import 'package:muatmuat/app/modules/tentang_perusahaan/tentang_perusahaan_controller.dart';
// import 'package:muatmuat/app/modules/testimoni_perusahaan/testimoni_perusahaan_controller.dart';
// import 'package:muatmuat/app/modules/testimoni_profile/testimoni_profile_controller.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas/ubah_kelengkapan_legalitas_controller.dart';
// import 'package:muatmuat/app/modules/validasi_gold_transporter/validasi_gold_transporter_controller.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/ubah_data_perusahaan_controller.dart';
import 'package:muatmuat/app/modules/ubah_kontak_pic/ubah_kontak_pic_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_expansion_component.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/tooltip_overlay.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/global_variable.dart';

// import 'components/reputasi_expansion_component.dart';
// import 'components/profile_perusahaan_map_component.dart';
import 'component/kontak_pic/kontak_pic_controller.dart';
import 'profile_perusahaan_controller.dart';
import 'profile_perusahaan_model.dart';

class OtherSideTransView extends GetView<OtherSideTransController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(
        isBlueMode: true,
        title: "Profil Transporter",
        isWithShadow: false,
        prefixIcon: [
          InkWell(
            onTap: () {
              GetToPage.toNamed<NotifControllerNew>(
                                    Routes.NOTIF);
            },
            child: SvgPicture.asset('assets/ic_notif_on.svg',
              width: GlobalVariable.ratioWidth(context) * 24,
              height: GlobalVariable.ratioWidth(context) * 24,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
          return _content(context, controller.dataModelResponse.value.data);
        } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
          return ErrorDisplayComponent("${controller.dataModelResponse.value.exception}",
            onRefresh: () => controller.fetchDataCompany(),
          );
        }
        return Container();
        // return LoadingComponent();
      }),
    );
  }

  Widget _content(BuildContext context, ProfilePerusahaanModel snapData) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: GlobalVariable.ratioWidth(context) * 126,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ColoredBox(
                      color: Color(ListColor.colorBlue),
                    ),
                  ),
                  Positioned(
                    top: GlobalVariable.ratioWidth(context) * 3,
                    right: 0,
                    child: Image.asset('assets/fallin_star_3_icon.png',
                      width: GlobalVariable.ratioWidth(context) * 138,
                      height: GlobalVariable.ratioWidth(context) * 58.14,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: GlobalVariable.ratioWidth(context) * 65.14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
                          topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: GlobalVariable.ratioWidth(context) * 110,
                      height: GlobalVariable.ratioWidth(context) * 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 120),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl: snapData.data.companyLogo,
                          width: GlobalVariable.ratioWidth(context) * 94,
                          height: GlobalVariable.ratioWidth(context) * 94,
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   right: GlobalVariable.ratioWidth(context) * 118,
                  //   bottom: GlobalVariable.ratioWidth(context) * 8,
                  //   child: Material(
                  //     shape: CircleBorder(
                  //       side: BorderSide(
                  //         color: Color(ListColor.colorBlue),
                  //         width: GlobalVariable.ratioWidth(context) * 1,
                  //       ),
                  //     ),
                  //     color: Colors.white,
                  //     clipBehavior: Clip.antiAlias,
                  //     child: InkWell(
                  //       onTap: () {
                  //         controller.showUpload();
                  //       },
                  //       child: SizedBox(
                  //         width: GlobalVariable.ratioWidth(context) * 35,
                  //         height: GlobalVariable.ratioWidth(context) * 35,
                  //         child: Center(
                  //           child: SvgPicture.asset('assets/edit_icon_2.svg',
                  //             width: GlobalVariable.ratioWidth(context) * 12,
                  //             height: GlobalVariable.ratioWidth(context) * 12,
                  //             color: Color(ListColor.colorBlue),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // company profile start here
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(context) * 9,
                left: GlobalVariable.ratioWidth(context) * 58,
                right: GlobalVariable.ratioWidth(context) * 58,
              ),
              margin: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(context) * 16,
              ),
              child: Column(
                children: [
                  CustomText("${snapData.data.companyName}",
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 10,
                  ),
                  CustomText("${snapData.data.companyBusinessEntity}",
                    textAlign: TextAlign.center,
                    fontSize: 14,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 10,
                  ),
                  CustomText("${snapData.data.companyBusinessField}",
                    textAlign: TextAlign.center,
                    fontSize: 14,
                    color: Color(ListColor.colorLightGrey4),
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 16,
                  ),
                ],
              ),
            ),
            controller.statusexpand.value == false ?
            GestureDetector(
              onTap: (){controller.statusexpand.value = true;},
              child: controller.gold.value == 'true' ? goldNormal() : Container()
              ) 
            : 
            GestureDetector(
              onTap: (){controller.statusexpand.value = false;},
              child: controller.gold.value == 'true' ? goldExpand() : Container()
              ),

            SizedBox(height: GlobalVariable.ratioWidth(context) * 16,),
            
            controller.statusexpand.value == false ?
            GestureDetector(
              onTap: (){controller.statusexpand.value = true;},
              child: controller.gold.value == 'false' ? normalNormal() : Container()
              ) 
            : 
            GestureDetector(
              onTap: (){controller.statusexpand.value = false;},
              child: 
              controller.gold.value == 'false' ? normalExpand() : Container()
              ),
            //reputasi administrasi regular
            SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 16,
                  ),

            // SizedBox(
            //         height: GlobalVariable.ratioWidth(context) * 16,
            //       ),  
          Container(
            height: GlobalVariable.ratioWidth(context) * 285,
            width: GlobalVariable.ratioWidth(context) * 360,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  // height: GlobalVariable.ratioWidth(context) * 71,
                  width: GlobalVariable.ratioWidth(context) * 328,
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 20),
                      CustomText('Tanggal Bergabung', fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF676767),),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/joined.png', height: GlobalVariable.ratioWidth(context) *30, width: GlobalVariable.ratioWidth(context) *30,),
                          SizedBox(width: GlobalVariable.ratioWidth(context) * 8,),
                          CustomText(controller.joinedbf.value.toString(), fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black,),
                          SizedBox(height: GlobalVariable.ratioWidth(context) * 2,),
                        ],
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 16
                      ),
                      Divider(
                          color: Color(ListColor.colorGrey6),
                          thickness: GlobalVariable.ratioWidth(Get.context) * 1,
                          height: 0,
                          ),
                    ],
                  ),
                ),
                SizedBox(height: GlobalVariable.ratioWidth(context) * 16,),
                Container(
                  height: GlobalVariable.ratioWidth(context) * 71,
                  width: GlobalVariable.ratioWidth(context) * 328,
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
                      CustomText('Total Armada', fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF676767),),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/totaled.png', height: GlobalVariable.ratioWidth(context) *30, width: GlobalVariable.ratioWidth(context) *30,),
                          SizedBox(width: GlobalVariable.ratioWidth(context) * 8,),
                          CustomText(controller.totalunittruck.toString() + ' Unit', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black,),

                        ],
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 16,),
                      Divider(
                          color: Color(ListColor.colorGrey6),
                          thickness: GlobalVariable.ratioWidth(Get.context) * 1,
                          height: 0,
                          ),
                    ],
                ),),
                Container(
                  // height: GlobalVariable.ratioWidth(context) * 71,
                  width: GlobalVariable.ratioWidth(context) * 328,
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
                      CustomText('Testimoni', fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF676767),),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/stared.png', height: GlobalVariable.ratioWidth(context) *30, width: GlobalVariable.ratioWidth(context) *30,),
                          SizedBox(width: GlobalVariable.ratioWidth(context) * 8,),
                          Row(
                            children: [
                              CustomText(controller.averagetestimoni.toString()+ ' ', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black,),
                              CustomText('(' + controller.totaltestimoni.toString()+' Ulasan)', fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF676767),),
                            ],
                          ),
                          SizedBox(height: GlobalVariable.ratioWidth(context) * 2,),
                        ],
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 16
                      ),
                      Divider(
                          color: Color(ListColor.colorGrey6),
                          thickness: GlobalVariable.ratioWidth(Get.context) * 1,
                          height: 0,
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // detail data perusahaan
          // company profile start here
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 16,
          ),
           // detail data perusahaan
            // company profile start here
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(context) * 20,
                horizontal: GlobalVariable.ratioWidth(context) * 16,
              ),
              margin: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(context) * 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomText("Data Perusahaan",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(context) * 8,
                          ),
                          TooltipOverlay(
                            message: "Data Perusahaan akan ditampilkan pada profil Anda untuk pengguna lainnya",
                            child: SvgPicture.asset('assets/ic_info_blue.svg',
                              width: GlobalVariable.ratioWidth(context) * 14,
                              height: GlobalVariable.ratioWidth(context) * 14,
                            ),
                          ),
                        ],
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     GetToPage.toNamed<UbahDataPerusahaanController>(Routes.UBAH_DATA_PERUSAHAAN);
                      //   },
                      //   child: Row(
                      //     children: [
                      //       CustomText("Ubah",
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w600,
                      //         textAlign: TextAlign.end,
                      //         color: Color(ListColor.colorBlue),
                      //       ),
                      //       SizedBox(
                      //         width: GlobalVariable.ratioWidth(context) * 4,
                      //       ),
                      //       // SvgPicture.asset('assets/edit_icon_2.svg',
                      //       //   width: GlobalVariable.ratioWidth(context) * 14,
                      //       //   height: GlobalVariable.ratioWidth(context) * 14,
                      //       //   color: Color(ListColor.colorBlue),
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  // content
                  _contentDataPerusahaan(
                    context: context, 
                    title: "No. Telp Perusahaan", 
                    value1: "${snapData.data.companyPhone}",
                  ),
                  _contentDataPerusahaan(
                    context: context, 
                    title: "Alamat", 
                    value1: "${snapData.data.companyAddress}",
                  ),
                  _contentDataPerusahaan(
                    context: context, 
                    title: "Detail Alamat", 
                    value1: "${snapData.data.companyAddressDetail}",
                  ),
                  _contentDataPerusahaan(
                    context: context,
                    withoutHorizontalPadding: true,
                    child: ProfilePerusahaanMapComponentt(
                      model: snapData,
                    ),
                  ),
                ],
              ),
            ),
            Container(width: GlobalVariable.ratioWidth(context) * 360,
          color: Color(0xFFD1E2FD),
          height: GlobalVariable.ratioWidth(context) * 46,
          child: Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText('Transporter bermasalah?', fontWeight: FontWeight.w500, fontSize: 14,),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 2,),
              Image.asset('assets/flag_other.png', height: GlobalVariable.ratioWidth(context) * 14, width: GlobalVariable.ratioWidth(context) * 14,),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 2,),
              CustomText('Laporkan', fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF176CF7),),
            ],
          ),),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 16,),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(context) * 16,
                GlobalVariable.ratioWidth(context) * 20,
                GlobalVariable.ratioWidth(context) * 16,
                GlobalVariable.ratioWidth(context) * 20,
              ),
              margin: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(context) * 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("Data Transporter",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 4,
                  ),
                 _contentDataShipperMenu(
                    context: context,
                    title: "Kontak PIC",
                    onTap: () => GetToPage.toNamed<KontakPICController>(Routes.KONTAK_PIC),
                  ),
                  _contentDataShipperMenu(
                    context: context,
                    title: "Tentang Perusahaan",
                    onTap: () => GetToPage.toNamed<TentangPerusahaanController>(Routes.TENTANG_PERUSAHAAN),
                  ),
                  _contentDataShipperMenu(
                    context: context,
                    title: "Data Armada",
                    onTap: () => GetToPage.toNamed<DataArmadaController>(Routes.DATA_ARMADA),
                  ),
                  _contentDataShipperMenu(
                    context: context,
                    title: "Foto dan Video",
                    onTap: () => GetToPage.toNamed<FotoDanVideoController>(Routes.FOTO_VIDEO),
                  ),
                  _contentDataShipperMenu(
                    context: context,
                    title: "Testimoni",
                    onTap: () {
                      // GetToPage.toNamed<TestimoniPerusahaanController>(Routes.TESTIMONI_PERUSAHAAN);
                         GetToPage.toNamed<ReportController>(Routes.TESTIMONI);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } 

  Widget goldNormal(){
    return   //reputasi adminisrasi gold
          Container(
          height: GlobalVariable.ratioWidth(Get.context) * 92,
          width: GlobalVariable.ratioWidth(Get.context) * 360,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20,),
              Padding(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16),
                child: Row(
                  children: [
                    CustomText('Reputasi Administrasi'),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8,),
                     TooltipOverlay(
                              message: "",
                              customMessage: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText("Tingkat Reputasi Administrasi",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                    color: Colors.white,
                                  ),

                                  SizedBox(
                                    height:  GlobalVariable.ratioWidth(Get.context) * 10,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset("assets/ic_silver_medal.png",
                                        width: GlobalVariable.ratioWidth(Get.context) * 15,
                                        height: GlobalVariable.ratioWidth(Get.context) * 20,
                                      ),
                                      SizedBox(
                                        width:  GlobalVariable.ratioWidth(Get.context) * 11,
                                      ),
                                      CustomText("Regular Transporter",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        textAlign: TextAlign.center,
                                        color: Colors.white
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:  GlobalVariable.ratioWidth(Get.context) * 4,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset("assets/ic_gold_medal.png",
                                        width: GlobalVariable.ratioWidth(Get.context) * 20.25,
                                        height: GlobalVariable.ratioWidth(Get.context) * 27,
                                      ),
                                      SizedBox(
                                        width:  GlobalVariable.ratioWidth(Get.context) * 7.75,
                                      ),
                                      CustomText("Gold Transporter",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset('assets/ic_info_blue.svg',
                                width: GlobalVariable.ratioWidth(Get.context) * 14,
                                height: GlobalVariable.ratioWidth(Get.context) * 14,
                              ),
                            ),
                          
                    // Container(
                    //   height: GlobalVariable.ratioWidth(context) * 14,
                    //   width: GlobalVariable.ratioWidth(context) * 14,
                    //   color: Colors.yellow,
                    // ),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 142,),
                    Image.asset('assets/down_arrow.png', height: GlobalVariable.ratioWidth(Get.context) * 16, width:GlobalVariable.ratioWidth(Get.context) * 16)
                    // Container(
                    //   height: GlobalVariable.ratioWidth(context) * 16,
                    //   width: GlobalVariable.ratioWidth(context) * 16,
                    //   color: Colors.yellow,
                    // ),

                  ],
                ),
                
              ),
              SizedBox(height: 4 ,),
              Padding(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16,),
                child: Container(
                              height: GlobalVariable.ratioWidth(Get.context) * 32,
                              width: GlobalVariable.ratioWidth(Get.context) * 198,
                              // color: Colors.green,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/ic_gold_medal.png",
                                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                                        height: GlobalVariable.ratioWidth(Get.context) * 32,
                                      ),
                                  SizedBox(
                                    width: GlobalVariable.ratioWidth(Get.context) * 8,
                                  ),
                                  CustomText('Gold Transporter', fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFD49A29),)
                                ],
                              ),
                            ),
              )
            ],
          ),
          );
          // SizedBox(
          //         height: GlobalVariable.ratioWidth(context) * 16,
          //       ),
  }


  Widget goldExpand(){
    return Container(
          height: GlobalVariable.ratioWidth(Get.context) * 234,
          width: GlobalVariable.ratioWidth(Get.context) * 360,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 21,),
              Padding(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16),
                child: Row(
                  children: [
                    CustomText('Reputasi Administrasi'),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8,),
                    TooltipOverlay(
                              message: "",
                              customMessage: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText("Tingkat Reputasi Administrasi",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                    color: Colors.white,
                                  ),

                                  SizedBox(
                                    height:  GlobalVariable.ratioWidth(Get.context) * 10,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset("assets/ic_silver_medal.png",
                                        width: GlobalVariable.ratioWidth(Get.context) * 15,
                                        height: GlobalVariable.ratioWidth(Get.context) * 20,
                                      ),
                                      SizedBox(
                                        width:  GlobalVariable.ratioWidth(Get.context) * 11,
                                      ),
                                      CustomText("Regular Transporter",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        textAlign: TextAlign.center,
                                        color: Colors.white
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:  GlobalVariable.ratioWidth(Get.context) * 4,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset("assets/ic_gold_medal.png",
                                        width: GlobalVariable.ratioWidth(Get.context) * 20.25,
                                        height: GlobalVariable.ratioWidth(Get.context) * 27,
                                      ),
                                      SizedBox(
                                        width:  GlobalVariable.ratioWidth(Get.context) * 7.75,
                                      ),
                                      CustomText("Gold Transporter",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset('assets/ic_info_blue.svg',
                                width: GlobalVariable.ratioWidth(Get.context) * 14,
                                height: GlobalVariable.ratioWidth(Get.context) * 14,
                              ),
                            ),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 142,),
                    Image.asset('assets/up_arrow.png', height: GlobalVariable.ratioWidth(Get.context) * 16, width:GlobalVariable.ratioWidth(Get.context) * 16)

                  ],
                ),
                
              ),
              SizedBox(height: 4 ,),
              Padding(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16,),
                child: Container(
                              height: GlobalVariable.ratioWidth(Get.context) * 32,
                              width: GlobalVariable.ratioWidth(Get.context) * 198,
                              // color: Colors.green,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/ic_gold_medal.png",
                                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                                        height: GlobalVariable.ratioWidth(Get.context) * 32,
                                      ),
                                  SizedBox(
                                    width: GlobalVariable.ratioWidth(Get.context) * 8,
                                  ),
                                  CustomText('Gold Transporter', fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFD49A29),)
                                ],
                              ),
                            ),
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16,),
              Padding(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 28),
                child: Row(
                  children: [
                    Image.asset('assets/check_repu.png',
                    height: GlobalVariable.ratioWidth(Get.context) * 16,
                    width: GlobalVariable.ratioWidth(Get.context) * 16,
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8,),
                    CustomText('Copy STNK sesuai jumlah truk', fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF1B1B1B),),
                  ],
                ),
              ),

              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10),

              Padding(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 28),
                child: Row(
                  children: [
                    Image.asset('assets/check_repu.png',
                    height: GlobalVariable.ratioWidth(Get.context) * 16,
                    width: GlobalVariable.ratioWidth(Get.context) * 16,
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8,),
                    CustomText('Melengkapi Profil Perusahaan', fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF1B1B1B),),
                  ],
                ),
              ),

              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10),

              Padding(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 28),
                child: Row(
                  children: [
                    Image.asset('assets/check_repu.png',
                    height: GlobalVariable.ratioWidth(Get.context) * 16,
                    width: GlobalVariable.ratioWidth(Get.context) * 16,
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8,),
                    CustomText('Kelengkapan Persyaratan Legalitas', fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF1B1B1B),),
                  ],
                ),
              ),

              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10),

              Padding(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 28),
                child: Row(
                  children: [
                    Image.asset('assets/check_repu.png',
                    height: GlobalVariable.ratioWidth(Get.context) * 16,
                    width: GlobalVariable.ratioWidth(Get.context) * 16,
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8,),
                    CustomText('Menerima minimal 1 testimoni', fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF1B1B1B),),
                  ],
                ),
              ),

              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10),

              Padding(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 28),
                child: Row(
                  children: [
                    Image.asset('assets/check_repu.png',
                    height: GlobalVariable.ratioWidth(Get.context) * 16,
                    width: GlobalVariable.ratioWidth(Get.context) * 16,
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8,),
                    CustomText('Mengunggah minimal 1 foto dan/atau video', fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF1B1B1B),),
                  ],
                ),
              ),


            ],
          ),
          );
  }
  
  Widget normalNormal(){
    return Container(
            height: GlobalVariable.ratioWidth(Get.context) * 81,
            width: GlobalVariable.ratioWidth(Get.context) * 360,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 21,),
                Padding(
                  padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16),
                  child: Row(
                    children: [
                      CustomText('Reputasi Administrasi'),
                      SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8,),
                      TooltipOverlay(
                                message: "",
                                customMessage: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText("Tingkat Reputasi Administrasi",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                      color: Colors.white,
                                    ),

                                    SizedBox(
                                      height:  GlobalVariable.ratioWidth(Get.context) * 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset("assets/ic_silver_medal.png",
                                          width: GlobalVariable.ratioWidth(Get.context) * 15,
                                          height: GlobalVariable.ratioWidth(Get.context) * 20,
                                        ),
                                        SizedBox(
                                          width:  GlobalVariable.ratioWidth(Get.context) * 11,
                                        ),
                                        CustomText("Regular Transporter",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          textAlign: TextAlign.center,
                                          color: Colors.white
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:  GlobalVariable.ratioWidth(Get.context) * 4,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset("assets/ic_gold_medal.png",
                                          width: GlobalVariable.ratioWidth(Get.context) * 20.25,
                                          height: GlobalVariable.ratioWidth(Get.context) * 27,
                                        ),
                                        SizedBox(
                                          width:  GlobalVariable.ratioWidth(Get.context) * 7.75,
                                        ),
                                        CustomText("Gold Transporter",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          textAlign: TextAlign.center,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset('assets/ic_info_blue.svg',
                                  width: GlobalVariable.ratioWidth(Get.context) * 14,
                                  height: GlobalVariable.ratioWidth(Get.context) * 14,
                                ),
                              ),
                      SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 142,),
                      Image.asset('assets/down_arrow.png', height: GlobalVariable.ratioWidth(Get.context) * 16, width:GlobalVariable.ratioWidth(Get.context) * 16)

                    ],
                  ),
                  
                ),
                SizedBox(height: 4 ,),
                Padding(
                  padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16,),
                  child: Container(
                                height: GlobalVariable.ratioWidth(Get.context) * 21,
                                width: GlobalVariable.ratioWidth(Get.context) * 180,
                                // color: Colors.green,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/ic_silver_medal.png",
                                          width: GlobalVariable.ratioWidth(Get.context) * 15,
                                          height: GlobalVariable.ratioWidth(Get.context) * 21,
                                        ),
                                    SizedBox(
                                      width: GlobalVariable.ratioWidth(Get.context) * 8,
                                    ),
                                    CustomText('Regular Transporter', fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF176CF7),)
                                  ],
                                ),
                              ),
                )
              ],
            ),
            );
  }
  
  Widget normalExpand(){
    return Container(
            height: GlobalVariable.ratioWidth(Get.context) * 113,
            width: GlobalVariable.ratioWidth(Get.context) * 360,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 21,),
                Padding(
                  padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16),
                  child: Row(
                    children: [
                      CustomText('Reputasi Administrasi'),
                      SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8,),
                      TooltipOverlay(
                                message: "",
                                customMessage: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText("Tingkat Reputasi Administrasi",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                      color: Colors.white,
                                    ),

                                    SizedBox(
                                      height:  GlobalVariable.ratioWidth(Get.context) * 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset("assets/ic_silver_medal.png",
                                          width: GlobalVariable.ratioWidth(Get.context) * 15,
                                          height: GlobalVariable.ratioWidth(Get.context) * 20,
                                        ),
                                        SizedBox(
                                          width:  GlobalVariable.ratioWidth(Get.context) * 11,
                                        ),
                                        CustomText("Regular Transporter",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          textAlign: TextAlign.center,
                                          color: Colors.white
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:  GlobalVariable.ratioWidth(Get.context) * 4,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset("assets/ic_gold_medal.png",
                                          width: GlobalVariable.ratioWidth(Get.context) * 20.25,
                                          height: GlobalVariable.ratioWidth(Get.context) * 27,
                                        ),
                                        SizedBox(
                                          width:  GlobalVariable.ratioWidth(Get.context) * 7.75,
                                        ),
                                        CustomText("Gold Transporter",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          textAlign: TextAlign.center,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset('assets/ic_info_blue.svg',
                                  width: GlobalVariable.ratioWidth(Get.context) * 14,
                                  height: GlobalVariable.ratioWidth(Get.context) * 14,
                                ),
                              ),
                      SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 142,),
                      Image.asset('assets/up_arrow.png', height: GlobalVariable.ratioWidth(Get.context) * 16, width:GlobalVariable.ratioWidth(Get.context) * 16)

                    ],
                  ),
                  
                ),
                SizedBox(height: 4 ,),
                Padding(
                  padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16,),
                  child: Container(
                                height: GlobalVariable.ratioWidth(Get.context) * 21,
                                width: GlobalVariable.ratioWidth(Get.context) * 180,
                                // color: Colors.green,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/ic_silver_medal.png",
                                          width: GlobalVariable.ratioWidth(Get.context) * 15,
                                          height: GlobalVariable.ratioWidth(Get.context) * 21,
                                        ),
                                    SizedBox(
                                      width: GlobalVariable.ratioWidth(Get.context) * 8,
                                    ),
                                    CustomText('Regular Transporter', fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF176CF7),),

                                  ],
                                ),
                              ),
                ),
                SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16,),
                Padding(
                  padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 28),
                  child: Row(
                    children: [
                      Image.asset('assets/check_repu.png',
                      height: GlobalVariable.ratioWidth(Get.context) * 16,
                      width: GlobalVariable.ratioWidth(Get.context) * 16,
                      ),
                      SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8,),
                      CustomText('Copy STNK sesuai jumlah truk', fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF1B1B1B),),
                    ],
                  ),
                )
              ],
            ),
            );
  }
  
  
  Widget _transporterReputationStatusWidget({
    @required BuildContext context,
    @required bool isCheck,
    @required String label,
  }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: GlobalVariable.ratioWidth(context) * 10,
      ),
      child: Row(
        children: [
          if (isCheck)
            SvgPicture.asset('assets/ic_check_filled_round.svg',
              width: GlobalVariable.ratioWidth(context) * 16,
              height: GlobalVariable.ratioWidth(context) * 16,
            )
          else
            SvgPicture.asset('assets/ic_check_outlined_round.svg',
              width: GlobalVariable.ratioWidth(context) * 16,
              height: GlobalVariable.ratioWidth(context) * 16,
            ),
          SizedBox(
            width: GlobalVariable.ratioWidth(context) * 8,
          ),
          CustomText(label,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(ListColor.colorBlack1),
          ),
        ],
      ),
    );
  }

  Widget _contentDataPerusahaan({
    @required BuildContext context,
    String title,
    String value1,
    String value2,
    Widget child,
    bool withoutHorizontalPadding = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(context) * 16,
        horizontal: withoutHorizontalPadding ? 0 : GlobalVariable.ratioWidth(context) * 10,
      ),
      constraints: BoxConstraints(
        minHeight: GlobalVariable.ratioWidth(context) * 74,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: GlobalVariable.ratioWidth(context) * 1,
            color: Color(ListColor.colorLightGrey2),
          ),
        ),
      ),
      child: child ?? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(title,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 6, // -2, cz custom text have 2px extra margin
          ),
          CustomText(value1,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          if (value2 != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 6, // -2, cz custom text have 2px extra margin
                ),
                CustomText(value2,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _contentDataShipperMenu({
    @required BuildContext context,
    String title,
    VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(context) * 16,
            GlobalVariable.ratioWidth(context) * 16,
            GlobalVariable.ratioWidth(context) * 14, // -2 border
            GlobalVariable.ratioWidth(context) * 16,
          ),
          constraints: BoxConstraints(
            minHeight: GlobalVariable.ratioWidth(context) * 48,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: GlobalVariable.ratioWidth(context) * 1,
                color: Color(ListColor.colorLightGrey2),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: GlobalVariable.ratioWidth(context) * 264,
                child: CustomText(title,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SvgPicture.asset('assets/ic_arrow_right_profile.svg',
                width: GlobalVariable.ratioWidth(context) * 16,
                height: GlobalVariable.ratioWidth(context) * 16,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button({
    @required BuildContext context,
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
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(context) * marginLeft,
          GlobalVariable.ratioWidth(context) * marginTop,
          GlobalVariable.ratioWidth(context) * marginRight,
          GlobalVariable.ratioWidth(context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(context).size.width
              : null
          : GlobalVariable.ratioWidth(context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(context) * paddingLeft,
                  GlobalVariable.ratioWidth(context) * paddingTop,
                  GlobalVariable.ratioWidth(context) * paddingRight,
                  GlobalVariable.ratioWidth(context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * borderRadius)),
              child: Center(
                child: customWidget == null
                    ? CustomText(
                        text ?? "",
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: color,
                      )
                    : customWidget,
              ),
            )),
      ),
    );
  }

}