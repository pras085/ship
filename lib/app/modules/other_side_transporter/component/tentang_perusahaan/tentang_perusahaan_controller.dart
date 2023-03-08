import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/other_side_transporter/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'tentang_perusahaan_model.dart';

class TentangPerusahaanController extends GetxController {
  var dataModelResponse = ResponseState<TentangPerusahaanModel>().obs;
  var dataPerusahaan = TentangPerusahaanModel(); // wes kadung digae, males hapus.
  var dataTransporterC = Get.find<OtherSideTransController>();

  String areaLayananC;
  String customerC;
  String portofolioC;
  String tahunMulaiC;
  String tahunPendirianC;
  String keunggulanC;
  String layananC;

  @override
  void onInit() async {
    await fetchTransporterData();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> fetchTransporterData() async {
    try {
      dataModelResponse.value = ResponseState.loading();
      final response = await ApiProfile(
        context: Get.context,
        isDebugGetResponse: true,
      ).getDataTransporterProfilePerusahaan('${dataTransporterC.idtrans.value}');
      if (response != null) {
        // convert json to object
        dataPerusahaan = TentangPerusahaanModel.fromJson(response);
        if (dataPerusahaan.message.code == 200) {
          dataModelResponse.value = ResponseState.complete(TentangPerusahaanModel.fromJson(response));
        } else {
          // error
          if (response['Message']['Code'] != null && response['Message']['Code'] != 500) {
            throw (response['Data']['Message']);
          }
          throw (response['Data']['Message']);
        }
        customerC =
            dataPerusahaan.data.customerList.isNotEmpty ? dataPerusahaan.data.customerList.map((e) => e.shipperName).toList().join(', ') : '-';
        portofolioC =
            dataPerusahaan.data.portfolioList.isNotEmpty ? dataPerusahaan.data.portfolioList.map((e) => e.shipperName).toList().join(', ') : '-';
        tahunMulaiC = dataPerusahaan.data.tahunMulaiUsaha ?? '-';
        tahunPendirianC = dataPerusahaan.data.tahunPendirianBadanUsaha ?? '-';
        keunggulanC = dataPerusahaan.data.advantage ?? '-';
        layananC = dataPerusahaan.data.layananTambahan.isNotEmpty
            ? dataPerusahaan.data.layananTambahan.map((e) => e.layananTambahan).toList().join(', ')
            : '-';
        areaLayananC =
            dataPerusahaan.data.areaLayananList.isNotEmpty ? dataPerusahaan.data.areaLayananList.map((e) => e.areaLayanan).toList().join(', ') : '-';
        // sukses
      } else {
        // error
        throw (response['Data']['Message']);
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      dataModelResponse.value = ResponseState.error("$error");
    }
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(Get.context) * 12,
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Container(
        width: double.infinity,
        height: GlobalVariable.ratioWidth(Get.context) * 1,
        color: Color(ListColor.colorLightGrey10),
      ),
    );
  }

  Widget listContent(
    void Function() onTap,
    String icon,
    String text,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                right: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              child: SvgPicture.asset(
                icon,
                height: GlobalVariable.ratioWidth(Get.context) * 24,
              ),
            ),
            Expanded(
              child: CustomText(
                text,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
