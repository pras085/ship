import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_pribadi/ubah_data_pribadi_controller.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_usaha/ubah_data_usaha_controller.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas_individu/ubah_kelengkapan_legalitas_individu_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/tooltip_overlay.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/global_variable.dart';

import 'profile_individu_controller.dart';

class ProfileIndividuView extends GetView<ProfileIndividuController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(
        isBlueMode: true,
        title: "Profil Individu",
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
          return _content(context);
        } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
          return ErrorDisplayComponent(
            "${controller.dataModelResponse.value.exception}",
            onRefresh: () => controller.fetchDataIndividu(),
          );
        }
        return LoadingComponent();
      }),
    );
  }

  Widget _content(BuildContext context) {
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
                        imageUrl: controller.dataUsaha.data.fullFilename,
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
                        color: Color(ListColor.colorBlue),
                        width: GlobalVariable.ratioWidth(context) * 1,
                      ),
                    ),
                    color: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
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
                            color: Color(ListColor.colorBlue),
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
              left: GlobalVariable.ratioWidth(context) * 16,
              right: GlobalVariable.ratioWidth(context) * 16,
              bottom: GlobalVariable.ratioWidth(context) * 45,
            ),
            margin: EdgeInsets.only(
              bottom: GlobalVariable.ratioWidth(context) * 16,
            ),
            child: Column(
              children: [
                // header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          "Data Usaha",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(context) * 8,
                        ),
                        TooltipOverlay(
                          message: "Data Usaha akan ditampilkan pada profil Anda untuk pengguna lainnya",
                          child: SvgPicture.asset(
                            'assets/ic_info_blue.svg',
                            width: GlobalVariable.ratioWidth(context) * 14,
                            height: GlobalVariable.ratioWidth(context) * 14,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        GetToPage.toNamed<UbahDataUsahaController>(Routes.UBAH_DATA_USAHA);
                      },
                      child: Row(
                        children: [
                          CustomText(
                            "Ubah",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.end,
                            color: Color(ListColor.colorBlue),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(context) * 4,
                          ),
                          SvgPicture.asset(
                            'assets/template_buyer/edit_icon_2.svg',
                            width: GlobalVariable.ratioWidth(context) * 14,
                            height: GlobalVariable.ratioWidth(context) * 14,
                            color: Color(ListColor.colorBlue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // content
                _contentDataPerusahaan(
                  context: context,
                  title: "Nama Usaha",
                  value1: "${controller.dataUsaha.data.companyName}",
                ),
                _contentDataPerusahaan(
                  context: context,
                  title: "Nama PIC Sales Marketing",
                  value1: "${controller.dataUsaha.data.pic1Name}",
                ),
                _contentDataPerusahaan(
                  context: context,
                  title: "Nomor PIC Sales Marketing",
                  value1: "${controller.dataUsaha.data.pic1Phone}",
                ),
                _contentDataPerusahaan(
                  context: context,
                  title: "Alamat",
                  value1: "${controller.dataUsaha.data.companyAddress}",
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
                          "Data Pribadi",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(context) * 8,
                        ),
                        TooltipOverlay(
                          message: "Data Pribadi akan ditampilkan pada profil Anda untuk pengguna lainnya",
                          child: SvgPicture.asset(
                            'assets/ic_info_blue.svg',
                            width: GlobalVariable.ratioWidth(context) * 14,
                            height: GlobalVariable.ratioWidth(context) * 14,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => GetToPage.toNamed<UbahDataPribadiController>(Routes.UBAH_DATA_PRIBADI),
                      child: Row(
                        children: [
                          CustomText(
                            "Ubah",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.end,
                            color: Color(ListColor.colorBlue),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(context) * 4,
                          ),
                          SvgPicture.asset(
                            'assets/template_buyer/edit_icon_2.svg',
                            width: GlobalVariable.ratioWidth(context) * 14,
                            height: GlobalVariable.ratioWidth(context) * 14,
                            color: Color(ListColor.colorBlue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // content
                _contentDataPerusahaan(
                  context: context,
                  title: "Alamat",
                  value1: "${controller.dataPribadi.data.personalAddress}",
                ),
              ],
            ),
          ),
          _contentDataShipperMenu(
            context: context,
            title: "Kelengkapan Legalitas",
            onTap: () {
              GetToPage.toNamed<UbahKelengkapanLegalitasIndividuController>(
                Routes.UBAH_KELENGKAPAN_LEGALITAS_INDIVIDU,
              );
            },
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 45,
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
    );
  }
}
