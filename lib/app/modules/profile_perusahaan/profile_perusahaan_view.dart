import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/data_kapasitas_pengiriman/data_kapasitas_pengiriman_controller.dart';
import 'package:muatmuat/app/modules/testimoni_profile/testimoni_profile_controller.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas/ubah_kelengkapan_legalitas_controller.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/ubah_data_perusahaan_controller.dart';
import 'package:muatmuat/app/modules/ubah_kontak_pic/ubah_kontak_pic_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/tooltip_overlay.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/global_variable.dart';

import 'components/profile_perusahaan_map_component.dart';
import 'profile_perusahaan_controller.dart';
import 'profile_perusahaan_model.dart';

class ProfilePerusahaanView extends GetView<ProfilePerusahaanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(
        isBlueMode: true,
        title: "Profil Perusahaan",
        isWithShadow: false,
        prefixIcon: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/ic_notif_on.svg',
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
          return ErrorDisplayComponent(
            "${controller.dataModelResponse.value.exception}",
            onRefresh: () => controller.fetchDataCompany(),
          );
        }
        return LoadingComponent();
      }),
    );
  }

  Widget _content(BuildContext context, ProfilePerusahaanModel snapData) {
    return SingleChildScrollView(
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
                  child: Image.asset(
                    'assets/fallin_star_3_icon.png',
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
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: GlobalVariable.ratioWidth(context) * 118,
                  bottom: GlobalVariable.ratioWidth(context) * 8,
                  child: Material(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: controller.edited.value? Color(ListColor.colorBlue) : Color(ListColor.colorGrey2),
                        width: GlobalVariable.ratioWidth(context) * 1,
                      ),
                    ),
                    color: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () async {
                          var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "524", showDialog: true);
                          if (!hasAccess) {
                            return;
                          }
                          controller.showUpload();
                      },
                      child: SizedBox(
                        width: GlobalVariable.ratioWidth(context) * 35,
                        height: GlobalVariable.ratioWidth(context) * 35,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/template_buyer/edit_icon_2.svg',
                            width: GlobalVariable.ratioWidth(context) * 12,
                            height: GlobalVariable.ratioWidth(context) * 12,
                            color: controller.edited.value? Color(ListColor.colorBlue) : Color(ListColor.colorGrey2)
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                CustomText(
                  "${snapData.data.companyName}",
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
                CustomText(
                  "${snapData.data.companyBusinessEntity}",
                  textAlign: TextAlign.center,
                  fontSize: 14,
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 10,
                ),
                CustomText(
                  "${snapData.data.companyBusinessField}",
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
              children: [
                // header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          "Data Perusahaan",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(context) * 8,
                        ),
                        TooltipOverlay(
                          message: "Data Perusahaan akan ditampilkan pada profil Anda untuk pengguna lainnya",
                          child: SvgPicture.asset(
                            'assets/ic_info_blue.svg',
                            width: GlobalVariable.ratioWidth(context) * 14,
                            height: GlobalVariable.ratioWidth(context) * 14,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "525", showDialog: false);
                        if (!hasAccess) {
                          return;
                        }
                        GetToPage.toNamed<UbahDataPerusahaanController>(Routes.UBAH_DATA_PERUSAHAAN);
                      },
                      child: Row(
                        children: [
                          CustomText(
                            "Ubah",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.end,
                            color: controller.accaddress.value?  Color(ListColor.colorBlue) : Color(ListColor.colorGrey2),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(context) * 4,
                          ),
                          SvgPicture.asset(
                            'assets/template_buyer/edit_icon_2.svg',
                            width: GlobalVariable.ratioWidth(context) * 14,
                            height: GlobalVariable.ratioWidth(context) * 14,
                            color: controller.accaddress.value?  Color(ListColor.colorBlue) : Color(ListColor.colorGrey2),
                          ),
                        ],
                      ),
                    ),
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
                  child: ProfilePerusahaanMapComponent(
                    model: snapData,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              bottom: GlobalVariable.ratioWidth(context) * 16,
            ),
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  GetToPage.toNamed<UbahKelengkapanLegalitasController>(
                    Routes.UBAH_KELENGKAPAN_LEGALITAS,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(context) * 16,
                    GlobalVariable.ratioWidth(context) * 20,
                    GlobalVariable.ratioWidth(context) * 29,
                    GlobalVariable.ratioWidth(context) * 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: GlobalVariable.ratioWidth(context) * 264,
                        child: CustomText(
                          "Kelengkapan Legalitas",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/ic_arrow_right_profile.svg',
                        width: GlobalVariable.ratioWidth(context) * 16,
                        height: GlobalVariable.ratioWidth(context) * 16,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
                CustomText(
                  "Data Shipper",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 4,
                ),
                _contentDataShipperMenu(
                  context: context,
                  title: "Data Kapasitas Pengiriman",
                  onTap: () => GetToPage.toNamed<DataKapasitasPengirimanController>(Routes.DATA_KAPASITAS_PENGIRIMAN),
                  disable: false,
                ),
                _contentDataShipperMenu(
                  context: context,
                  title: "Kontak PIC",
                  onTap: () async {
                    var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "527", showDialog: false);
                    if (!hasAccess) {
                      return;
                    }
                    GetToPage.toNamed<UbahKontakPicController>(Routes.UBAH_KONTAK_PIC);
                  },
                  disable: controller.accpic.value? false : true,
                ),
                _contentDataShipperMenu(
                  context: context,
                  title: "Testimoni Anda",
                  onTap: () {
                    GetToPage.toNamed<TestimoniProfileController>(Routes.TESTIMONI_PROFILE);
                  },
                  disable: false,
                ),
              ],
            ),
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
      child: child ??
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(ListColor.colorLightGrey4),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 6, // -2, cz custom text have 2px extra margin
              ),
              CustomText(
                value1,
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
                    CustomText(
                      value2,
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
    bool disable
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
                child: CustomText(
                  title,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: disable? Color(ListColor.colorGrey2) : Colors.black,
                ),
              ),
              SvgPicture.asset(
                'assets/ic_arrow_right_profile.svg',
                width: GlobalVariable.ratioWidth(context) * 16,
                height: GlobalVariable.ratioWidth(context) * 16,
                color: disable? Color(ListColor.colorGrey2) : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
