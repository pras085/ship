import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/data_kapasitas_pengiriman/component/item_data_kapasitas_pengiriman.dart';
import 'package:muatmuat/app/modules/data_kapasitas_pengiriman/data_kapasitas_pengiriman_controller.dart';
import 'package:muatmuat/app/modules/data_kapasitas_pengiriman/data_kapasitas_pengiriman_model.dart';
import 'package:muatmuat/app/utils/download_utils.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';

class DataKapasitasPengirimanView extends GetView<DataKapasitasPengirimanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(
        title: "Data Kapasitas Pengiriman",
        isCenter: false,
        isBlueMode: true,
      ),
      body: Obx(() {
        if (controller.dataKapasitas.value.state == ResponseStates.COMPLETE) {
          return _content(context, controller.dataKapasitas.value.data);
        } else if (controller.dataKapasitas.value.state == ResponseStates.ERROR) {
          return ErrorDisplayComponent(
            "${controller.dataKapasitas.value.exception}",
            onRefresh: () => controller.fetchDataPicFromAPi(),
          );
        }
        return LoadingComponent();
      }),
    );
  }

  Widget _content(BuildContext context, DataKapasitasModel data) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(context) * 24,
        horizontal: GlobalVariable.ratioWidth(context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.data is List && (data.data).isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(context) * 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    'Kapasitas rata-rata pengiriman per hari',
                    withoutExtraPadding: true,
                    color: Color(ListColor.colorLightGrey4),
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                  CustomText(
                    data.data[0].capacity.toString() + ' unit per hari',
                    withoutExtraPadding: true,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          if (data.data is List && (data.data).isNotEmpty) SizedBox(height: GlobalVariable.ratioWidth(context) * 14),
          if (data.data.first.file is List && (data.data.first.file).isNotEmpty)
            ItemDataKapasitasComponent(
              title: 'Surat Jalan',
              files: data.data.map((e) => e.file).toList().single,
            )
        ],
      ),
    );
  }

  Widget iconDownload(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: GlobalVariable.ratioWidth(context) * 12,
      ),
      child: InkWell(
        onTap: () {
          GlobalAlertDialog.showDialogWarningWithoutTitle(
            context: context,
            customMessage: Container(
              margin: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(context) * 20,
              ),
              width: GlobalVariable.ratioWidth(Get.context) * 296,
              child: CustomText(
                // "Password Dokumen Anda merupakan gabungan dari \"6 digit terakhir No. KTP ${ctrl.subject} dan Kode Referral",
                "Password Dokumen Anda merupakan gabungan dari \"6 digit terakhir No. KTP dan Kode Referral",
                textAlign: TextAlign.center,
                fontSize: 14,
                height: 22 / 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                withoutExtraPadding: true,
              ),
            ),
            labelButtonPriority1: "Unduh Dokumen",
            buttonWidth: 193,
            onTapPriority1: () async {
              try {
                final response = await ApiProfile(
                  context: Get.context,
                  isShowDialogLoading: true,
                  isShowDialogError: true,
                ).zipFileOnDownload(
                  {
                    // 'file': controller.dataKapasitas.value.data.data[idx].file[idx].fileFilename,
                    'file': controller.dataKapasitas.value.data.data.map(
                      (e) => e.file.map(
                        (e) => e.fileFilename,
                      ),
                    )
                  },
                );
                DownloadUtils.doDownload(
                  context: context,
                  url: response['Data']['Link'],
                );
              } catch (error) {
                print("Error : $error");
              }
            },
          );
        },
        child: SvgPicture.asset(
          "assets/ic_download.svg",
          width: GlobalVariable.ratioWidth(context) * 18,
          height: GlobalVariable.ratioWidth(context) * 18,
          color: Color(ListColor.colorBlue),
        ),
      ),
    );
  }
}
