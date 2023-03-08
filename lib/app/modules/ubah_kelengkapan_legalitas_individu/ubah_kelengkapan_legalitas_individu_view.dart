import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/tooltip_overlay.dart';
import 'package:muatmuat/global_variable.dart';

import 'ubah_kelengkapan_legalitas_individu_controller.dart';
import 'components/item_ubah_kelengkapan_legalitas_individu_component.dart';

class UbahKelengkapanLegalitasIndividuView extends GetView<UbahKelengkapanLegalitasIndividuController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(
        title: "Ubah Kelengkapan Legalitas",
        isCenter: false,
      ),
      body: Obx(() {
        if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
          return _content(context, controller.dataModelResponse.value.data['Data']);
        } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
          return ErrorDisplayComponent("${controller.dataModelResponse.value.exception}",
            onRefresh: () => controller.fetchDataLegalitas(),
          );
        }
        return LoadingComponent();
      }),
    );
  }

  Widget _content(BuildContext context, Map data) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(context) * 24,
        horizontal: GlobalVariable.ratioWidth(context) * 16,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomText("Kelengkapan Legalitas",
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              SizedBox(
                width: GlobalVariable.ratioWidth(context) * 8,
              ),
              TooltipOverlay(
                message: "Kelengkapan Legalitas tidak akan ditampilkan untuk pengguna lainnya",
                child: SvgPicture.asset('assets/ic_info_blue.svg',
                  width: GlobalVariable.ratioWidth(context) * 14,
                  height: GlobalVariable.ratioWidth(context) * 14,
                ),
              ),
            ],
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 16,
          ),
          if (data["Nib"] is List && (data["Nib"] as List).isNotEmpty)
            ItemUbahKelengkapanLegalitasIndividuComponent(
              title: "File NIB",
              child: FileKelengkapanLegalitasComponent(
                fileId: "${(data["Nib"] as List)[0]['file_id']}",
                fileName: (data["Nib"] as List)[0]['NibName'],
                filePath: (data["Nib"] as List)[0]['NibFilePath'],
              ),
            ),
          if (data["Npwp"] is List && (data["Npwp"] as List).isNotEmpty)
            ItemUbahKelengkapanLegalitasIndividuComponent(
              title: "No. NPWP Pribadi",
              valueString: (data["Npwp"] as List)[0]['npwp_no'] ?? "-",
            ),
          if (data["Npwp"] is List && (data["Npwp"] as List).isNotEmpty)
            ItemUbahKelengkapanLegalitasIndividuComponent(
              title: "File NPWP Pribadi",
              child: FileKelengkapanLegalitasComponent(
                fileId: "${(data["Npwp"] as List)[0]['file_id']}",
                fileName: (data["Npwp"] as List)[0]['NpwpName'],
                filePath: (data["Npwp"] as List)[0]['NpwpFilePath'],
              ),
            ),
          if (data["Ktp"] is List && (data["Ktp"] as List).isNotEmpty)
            ItemUbahKelengkapanLegalitasIndividuComponent(
              title: "No. KTP Pendaftar/Pemegang Akun",
              valueString: (data["Ktp"] as List)[0]['ktp_no'] ?? "-",
            ),
          if (data["Ktp"] is List && (data["Ktp"] as List).isNotEmpty)
            ItemUbahKelengkapanLegalitasIndividuComponent(
              title: "File KTP Pendaftar/Pemegang Akun",
              child: FileKelengkapanLegalitasComponent(
                fileId: "${(data["Ktp"] as List)[0]['file_id']}",
                fileName: (data["Ktp"] as List)[0]['KtpName'],
                filePath: (data["Ktp"] as List)[0]['KtpFilePath'],
              ),
            ),
        ],
      ),
    );
  }

}