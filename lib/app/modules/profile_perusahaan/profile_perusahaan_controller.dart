import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'components/ubah_logo_perusahaan/ubah_foto_perusahaan_controller.dart';
import 'profile_perusahaan_model.dart';

class ProfilePerusahaanController extends GetxController {
  var dataModelResponse = ResponseState<ProfilePerusahaanModel>().obs;
  var dataPerusahaan =
      ProfilePerusahaanModel(); // wes kadung digae, males hapus.
  var edited = true.obs;
  var accaddress = true.obs;
  var accpic = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await cekEdit();
    await cekAlamat();
    await cekPIC();
    fetchDataCompany();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> fetchDataCompany() async {
    try {
      dataModelResponse.value = ResponseState.loading();
      final response = await ApiProfile(context: Get.context)
          .getDataProfileSubGeneralCompany({});
      if (response != null) {
        // convert json to object
        dataPerusahaan = ProfilePerusahaanModel.fromJson(response);
        if (dataPerusahaan.message.code == 200) {
          // sukses
          dataModelResponse.value =
              ResponseState.complete(ProfilePerusahaanModel.fromJson(response));
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
      // error
      print("ERROR :: $error");
      dataModelResponse.value = ResponseState.error("$error");
    }
  }

  Future<void> cekEdit() async {
          var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "524", showDialog: false);
          if (!hasAccess) {
            edited.value = false;
          }
    }
  
  Future<void> cekAlamat() async {
          var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "525", showDialog: false);
          if (!hasAccess) {
            accaddress.value = false;
          }
    }

  Future<void> cekPIC() async {
          var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "527", showDialog: false);
          if (!hasAccess) {
            accpic.value = false;
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
                          GlobalVariable.urlImageTemplateBuyer + "ic_close_shipper.svg",
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
