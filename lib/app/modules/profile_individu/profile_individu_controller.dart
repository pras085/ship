import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_logo_individu/ubah_foto_individu_controller.dart';
import 'package:muatmuat/app/modules/profile_individu/profile_individu_data_pribadi_model.dart';
import 'package:muatmuat/app/modules/profile_individu/profile_individu_data_usaha_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ProfileIndividuController extends GetxController {
  var dataModelResponse = ResponseState().obs;
  var dataPribadi = ProfileIndividuDataPribadiModel();
  var dataUsaha = ProfileIndividuDataUsahaModel();

  @override
  void onInit() async {
    super.onInit();
    fetchDataIndividu();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> fetchDataIndividu() async {
    try {
      dataModelResponse.value = ResponseState.loading();
      final response = await Future.wait([
        ApiProfile(context: Get.context).getDataPribadiUsers({}),
        ApiProfile(context: Get.context).getDataUsahaUsers({}),
      ]);
      if (response != null) {
        // convert json to object
        if (response[0] != null) {
          dataPribadi = ProfileIndividuDataPribadiModel.fromJson(response[0]);
        }
        if (response[1] != null) {
          dataUsaha = ProfileIndividuDataUsahaModel.fromJson(response[1]);
        }

        if (dataPribadi.message.code == 200 && dataUsaha.message.code == 200) {
          // sukses
          dataModelResponse.value =
              ResponseState.complete(response);
        } else {
          // error
          if (dataPribadi.message.code != null) {
            throw (dataPribadi.message.text);
          }
          if (dataUsaha.message.code != null) {
            throw (dataUsaha.message.text);
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
      dataModelResponse.value = ResponseState.error("$error");
    }
  }

  // MEMUNCULKAN BOTTOM SHEET
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
                  GetToPage.toNamed<UbahLogoIndividuController>(Routes.UBAH_LOGO_INDIVIDU, arguments: "1");
                },
                'assets/ic_gallery.svg',
                'Pilih dari galeri',
              ),
              listContent(context, () async {
                //TUTUP BOTTOMSHEET
                Get.back();
                GetToPage.toNamed<UbahLogoIndividuController>(Routes.UBAH_LOGO_INDIVIDU, arguments: "2");
              }, 'assets/ic_camera.svg', 'Ambil foto'),
              listContent(
                context,
                () async {
                  Get.back();
                  await deletePhoto();
                  fetchDataIndividu();
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
