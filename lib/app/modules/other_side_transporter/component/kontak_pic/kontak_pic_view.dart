import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/kontak_pic/kontak_pic_controller.dart';
import 'package:muatmuat/app/modules/ubah_kontak_pic/ubah_kontak_pic_model.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/global_variable.dart';

class KontakPICView extends GetView<KontakPICController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(
        title: 'Kontak PIC',
        isCenter: false,
        onClickBack: () => Get.back(),
        isBlueMode: true,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
          return _body(context, controller.dataModelResponse.value.data);
        } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
          return ErrorDisplayComponent(
            "${controller.dataModelResponse.value.exception}",
            onRefresh: () => controller.fetchDataPicFromAPi(),
          );
        }
        return LoadingComponent();
      }),
    );
  }

  Widget _body(BuildContext context, KontakPicShipperModel model) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(context) * 25,
        vertical: GlobalVariable.ratioWidth(context) * 20,
      ),
      color: Color(ListColor.colorWhite),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _content(context: context, title: 'PIC 1', namaPic: model.data.pic1Name, noPic: model.data.pic1Phone),
          _content(context: context, title: 'PIC 2', namaPic: model.data.pic2Name, noPic: model.data.pic2Phone),
          _content(context: context, title: 'PIC 3', namaPic: model.data.pic3Name, noPic: model.data.pic3Phone),
        ],
      ),
    );
  }

  Widget _content({
    context,
    String title,
    String namaPic,
    String noPic,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(ListColor.colorStroke),
            width: GlobalVariable.ratioWidth(context) * 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(context) * 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            title,
            withoutExtraPadding: true,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(width: GlobalVariable.ratioWidth(context) * 30),
          noPic != ""
              ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        namaPic,
                        fontWeight: FontWeight.w600,
                        withoutExtraPadding: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 14),
                      CustomText(
                        noPic,
                        withoutExtraPadding: true,
                      ),
                    ],
                  ),
                )
              : CustomText(
                  '-',
                  fontWeight: FontWeight.w600,
                  withoutExtraPadding: true,
                ),
          noPic != "" ? SizedBox(width: GlobalVariable.ratioWidth(context) * 8) : SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(context) * 16),
            child: noPic != ""
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () => controller.copyNumber(noPic),
                        child: SvgPicture.asset(
                          "assets/ic_profil_copy.svg",
                          height: GlobalVariable.ratioWidth(context) * 20,
                          width: GlobalVariable.ratioWidth(context) * 20,
                          color: Color(ListColor.colorBlue),
                        ),
                      ),
                      SizedBox(width: GlobalVariable.ratioWidth(context) * 26),
                      InkWell(
                        onTap: () => controller.launchWhatsApp(noPic),
                        child: SvgPicture.asset(
                          'assets/ic_whatapp_blue.svg',
                          height: GlobalVariable.ratioWidth(context) * 20,
                          width: GlobalVariable.ratioWidth(context) * 20,
                          // color: Color(ListColor.colorBlue),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
