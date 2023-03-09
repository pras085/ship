import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/components/ubah_logo_perusahaan/ubah_foto_perusahaan_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'profile_perusahaan_model.dart';
import 'transporter_reputation_status_model.dart';
import 'gold_status_model.dart';

class OtherSideTransController extends GetxController {
  var dataModelResponse = ResponseState<ProfilePerusahaanModel>().obs;
  var transporterStatusResponse = ResponseState<TransporterReputationStatusModel>().obs;

  var goldStatus = GoldStatusModel();
  var dataPerusahaan = ProfilePerusahaanModel(); // wes kadung digae, males hapus.

  var statusexpand = false.obs;
  var idtrans = "".obs;
  var gold = "".obs;
  var joinedbf = "".obs;
  var totaltestimoni = "".obs;
  var averagetestimoni = "".obs;
  var totalunittruck = "".obs;
  var canshare = true.obs;
  var candownload = true.obs;
  var loading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await cekShare();
    await cekDownload();
    loading.value = false;
    log(Get.arguments[0].toString() + 'yuta');
    log(Get.arguments[1].toString());
    idtrans.value = Get.arguments[0].toString();
    gold.value = Get.arguments[1].toString();
    getJoinedDate();
    getAllRating();
    getTotalUnit();
    fetchDataCompany();
    fetchTransporterStatus(); 
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> fetchDataCompany() async {
    try {
      // dataModelResponse.value = ResponseState.loading();
      // final response = await ApiHelper(context: Get.context, isShowDialogLoading: false).getTransporterDataDetail('23');
      final response = await ApiHelper(context: Get.context, isShowDialogLoading: false).getTransporterDataDetail(idtrans.value);
      if (response != null) {
        // convert json to object
        dataPerusahaan = ProfilePerusahaanModel.fromJson(response);
        if (dataPerusahaan.message.code == 200) {
          // sukses
          dataModelResponse.value = ResponseState.complete(ProfilePerusahaanModel.fromJson(response));
        } else {
          // error
          if (dataPerusahaan.message.code != null) {
            throw (dataPerusahaan.message.text);
          }
          throw ("failed to fetch data!");
        }
      } else {
        // error
        throw ("failed to fetch data!");
      }
    } catch (error) {
      // // error
      // print("ERROR :: $error");
      // dataModelResponse.value = ResponseState.error("$error");
    }
  }

  Future<void> getJoinedDate() async {
    try {
      final response = await ApiHelper(context: Get.context, isShowDialogLoading: false).getTransporterJoinedDate(idtrans.value);
      if (response != null) {
        log(response.toString() + 'yuta');
        log(response['Data']['verif_date_bf_shipper'].toString() + 'yuta');
        joinedbf.value = response['Data']['verif_date_bf_shipper'] == "" ? response['Data']['verif_date_tm_shipper'] == "" ? 'Belum terverif admin' : response['Data']['verif_date_tm_shipper'] : response['Data']['verif_date_bf_shipper'] ;
      }
    } catch (error) {

    }
  }

  Future<void> getAllRating() async {
    try {
      final response = await ApiHelper(context: Get.context, isShowDialogLoading: false).getAllTransporterRating(idtrans.value);
      if (response != null) {
        log(response.toString() + 'yuta');
        log(response['SupportingData']['TotalCountDataRating'].toString() + 'yuta');
        log(response['SupportingData']['AverageAllRating'].toString() + 'yuta');
        totaltestimoni.value = response['SupportingData']['TotalCountDataRating'].toString();
        averagetestimoni.value = response['SupportingData']['AverageAllRating'].toString();
        }
    } catch (error) {
      
    }
  }

  Future<void> getTotalUnit() async {
    try {
      final response = await ApiHelper(context: Get.context, isShowDialogLoading: false).getAllTransporterUnit(idtrans.value);
      if (response != null) {
        log(response['Data']['TruckListCount'].toString() + 'yuta');
        totalunittruck.value = response['Data']['TruckListCount'].toString();
        }
    } catch (error) {
      
    }
  }

   Future<void> cekShare() async {
      var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "408", showDialog: false);
      if (!hasAccess) {
        canshare.value = false;
      }
    }

   Future<void> cekDownload() async {
      var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "408", showDialog: false);
      if (!hasAccess) {
        candownload.value = false;
      }
    }

  double getPercentage() {
    double result = 0;
    if (goldStatus.data.statCopySTNKCountTruck == 1) {
      result += 1;
    }
    if (goldStatus.data.statKelengkapanLegalitas == 1) {
      result += 1;
    }
    if (goldStatus.data.statProfilPerusahaan == 1) {
      result += 1;
    }
    if (goldStatus.data.statTestimoni == 1) {
      result += 1;
    }
    if (goldStatus.data.statFotoVideo == 1) {
      result += 1;
    }
    return result / 5;
  }

  void fetchTransporterStatus() async {
    try {
      // transporterStatusResponse.value = ResponseState.loading();
      final response = await Future.wait([
        ApiProfile(context: Get.context, isShowDialogLoading: false).getTransporterReputasiAdminAndStatus({}),
        ApiProfile(context: Get.context, isShowDialogLoading: false).getGoldTransporterStatus({}),
      ]);
      if (response[0] != null && response[1] != null) {
        // convert json to object
        transporterStatusResponse.value = ResponseState.complete(TransporterReputationStatusModel.fromJson(response[0]));
        goldStatus = GoldStatusModel.fromJson(response[1]);
        if (transporterStatusResponse.value.data.message.code == 200 && goldStatus.message.code == 200) {
          // sukses
        } else {
          // error
          if (transporterStatusResponse.value.data.message.code != null) {
            throw (transporterStatusResponse.value.data.message.text);
          } else if (goldStatus.message.code != null) {
            throw (goldStatus.message.text);
          }
          throw ("failed to fetch data!");
        }
      } else {
        // error
        throw ("failed to fetch data!");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      transporterStatusResponse.value = ResponseState.error("$error");
    }
  }

  Future showUpload() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20), topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20))),
      backgroundColor: Colors.white,
      context: Get.context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(Get.context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // GARIS ABU
              Container(
                  margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 4),
                  child: Container(
                    width: GlobalVariable.ratioWidth(Get.context) * 38,
                    height: GlobalVariable.ratioWidth(Get.context) * 3,
                    decoration: BoxDecoration(color: Color(ListColor.colorLightGrey16), borderRadius: BorderRadius.all(Radius.circular(20))),
                  )),

              Container(
                padding: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 12,
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 8), // - 12
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        'Ubah Foto',
                        fontWeight: FontWeight.w700,
                        color: Color(ListColor.color4),
                        withoutExtraPadding: true,
                        fontSize: 14,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // onPop();
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          "assets/ic_close_shipper.svg",
                          color: Color(ListColor.colorBlack),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              listContent(
                context,
                () async {
                  Get.back();
                  GetToPage.toNamed<UbahLogoPerusahaanController>(Routes.UBAH_LOGO_PERUSAHAAN, arguments: "1");
                },
                'assets/ic_gallery.svg',
                'Pilih dari galeri',
              ),
              listContent(context, () async {
                //TUTUP BOTTOMSHEET
                Get.back();
                GetToPage.toNamed<UbahLogoPerusahaanController>(Routes.UBAH_LOGO_PERUSAHAAN, arguments: "2");
              }, 'assets/ic_camera.svg', 'Ambil foto'),
              listContent(
                context,
                () async {
                  Get.back();
                  await deletePhoto();
                  fetchDataCompany();
                },
                'assets/ic_trash.svg',
                'Hapus foto profil',
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12)
            ],
          ),
        );
      },
    );
  }

  Future deletePhoto() async {
    try {
      var response = await ApiProfile(
        context: Get.context,
        isShowDialogLoading: true,
        isDebugGetResponse: true,
      ).deleteLogoCompany({});
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          CustomToastTop.show(context: Get.context, message: response["Data"]['Message'], isSuccess: 1);
        } else {
          String errorMessage = response["Data"]["Message"];

          CustomToastTop.show(message: errorMessage, context: Get.context, isSuccess: 0);
        }
      }
    } catch (err) {
      print("Can't delete photo : " + err.toString());
    }
  }

  Future updatePhoto(String image) async {
    try {
      var response = await ApiProfile(
        context: Get.context,
        isShowDialogLoading: true,
        isDebugGetResponse: true,
      ).updatePhotoProfile(image);
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // GetToPage.offNamed<ProfilePerusahaanController>(
          //     Routes.PROFILE_PERUSAHAAN);
          CustomToastTop.show(context: Get.context, message: response["Data"]['Message'], isSuccess: 1);
        } else {
          String errorMessage = response["Data"]["Message"];

          CustomToastTop.show(message: errorMessage, context: Get.context, isSuccess: 0);
        }
      }
    } catch (err) {
      print("Can't delete photo : " + err.toString());
    }
  }

  Widget listContent(BuildContext context, void Function() onTap, String icon, String text) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(context) * 16),
          padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(context) * 12),
          constraints: BoxConstraints(
            minHeight: GlobalVariable.ratioWidth(context) * 36,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: GlobalVariable.ratioWidth(context) * 1,
                color: Color(ListColor.colorLightGrey10),
              ),
            ),
          ),
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
      ),
    );
  }
}
