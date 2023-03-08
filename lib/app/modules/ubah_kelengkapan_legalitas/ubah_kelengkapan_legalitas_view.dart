import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas/components/item_ubah_kelengkapan_legalitas_component.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas/ubah_kelengkapan_legalitas_controller.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas/ubah_kelengkapan_legalitas_model.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/tooltip_overlay.dart';
import 'package:muatmuat/global_variable.dart';

class UbahKelengkapanLegalitasView extends GetView<UbahKelengkapanLegalitasController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(
        title: "Ubah Kelengkapan Legalitas",
        isCenter: false,
      ),
      body: Obx(() {
        if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
          return _content(context, controller.dataModelResponse.value.data);
        } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
          return ErrorDisplayComponent("${controller.dataModelResponse.value.exception}",
            onRefresh: () => controller.fetchDataLegalitas(),
          );
        }
        return LoadingComponent();
      }),
    );
  }

  Widget _content(BuildContext context, UbahKelengkapanLegalitasModel data) {
    return SingleChildScrollView(
      controller: controller.scrollController,
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
          if (controller.bCategory == 1)
            ItemUbahKelengkapanLegalitasComponent(
              title: "File Akta Pendirian Perusahaan dan SK KEMENKUMHAM", 
              files: data.file.where((el) => el.fieldName == "akta_pendirian").toList(),
            ),
          if (controller.bCategory == 1)
            ItemUbahKelengkapanLegalitasComponent(
              title: "Akta Anggaran Dasar Terakhir dan SK", 
              files: data.file.where((el) => el.fieldName == "akta_adt").toList(),
            ),
          if (controller.bCategory == 1)
            ItemUbahKelengkapanLegalitasComponent(
              title: "Akta Direksi dan Dewan Komisaris terakhir dan SK", 
              files: data.file.where((el) => el.fieldName == "akta_direksi").toList(),
            ),
          ItemUbahKelengkapanLegalitasComponent(
            title: "File KTP ${controller.subject}", 
            files: data.file.where((el) => el.fieldName == "ktp_direktur").toList(),
          ),
          ItemUbahKelengkapanLegalitasComponent(
            title: "No. KTP ${controller.subject}",
            valueString: data.data.ktpDirektur,
          ),
          if (controller.bCategory == 1)
            Obx(() => ItemUbahKelengkapanLegalitasComponent(
              title: "Akta Perubahan terakhir dan SK",
              isOpsional: true, 
              files: data.file.where((el) => el.fieldName == "akta_perubahan").toList(),
              onTapUpload: () => controller.uploadFile("akta_perubahan", 0),
              onTapDelete: (id) => controller.deleteFile(id, "akta_perubahan"),
              isUpload: controller.aktaUpload.value.isUpload,
              progress: controller.aktaUpload.value.sent == null || controller.aktaUpload.value.total == null ? null : controller.aktaUpload.value.sent/controller.aktaUpload.value.total,
              errorMessage: controller.aktaUpload.value.errorMessage,
            )),
          ItemUbahKelengkapanLegalitasComponent(
            title: "File NIB",
            files: data.file.where((el) => el.fieldName == "nib").toList(),
          ),
          if (controller.bCategory == 1)
            Obx(() => ItemUbahKelengkapanLegalitasComponent(
              title: "File Sertifikat Standar",
              isOpsional: true,
              files: data.file.where((el) => el.fieldName == "standard_certificate").toList(),
              onTapUpload: () => controller.uploadFile("standard_certificate", 1),
              onTapDelete: (id) => controller.deleteFile(id, "standard_certificate"),
              isUpload: controller.sertifikatUpload.value.isUpload,
              progress: controller.sertifikatUpload.value.sent == null || controller.sertifikatUpload.value.total == null ? null : controller.sertifikatUpload.value.sent/controller.sertifikatUpload.value.total,
              errorMessage: controller.sertifikatUpload.value.errorMessage,
            )),
          ItemUbahKelengkapanLegalitasComponent(
            title: "No. NPWP Perusahaan",
            valueString: data.data.npwp,
          ),
          ItemUbahKelengkapanLegalitasComponent(
            title: "File NPWP Perusahaan",
            files: data.file.where((el) => el.fieldName == "npwp").toList(),
          ),
          ItemUbahKelengkapanLegalitasComponent(
            title: "No. KTP Pendaftar/Pemegang Akun",
            valueString: data.data.ktpPic,
          ),
          ItemUbahKelengkapanLegalitasComponent(
            title: "File KTP Pendaftar/Pemegang Akun",
            files: data.file.where((el) => el.fieldName == "ktp_pic").toList(),
          ),
        ],
      ),
    );
  }

}