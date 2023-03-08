import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_status_subscribe.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_user_profile.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_user_status.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'component/ubah_foto_profil/ubah_foto_profil_controller.dart';

class ProfilController extends GetxController {
  var isInit = true;
  var isLoading = true.obs;
  var isError = false.obs;
  var isChange = false.obs;
  UserProfil userProfil = UserProfil();
  UserStatus userStatus = UserStatus();
  StatusSubscribe userStatusSubscribe = StatusSubscribe();
  var tecKapasitasPengiriman = TextEditingController();
  var cekTambahRole = false;
  var cekHapusRole = false;
  var cekAktifNonRole = false;
  var cekDetailRole = false;

  var cekTambahUser = false;
  var cekHapusUser = false;
  var cekAktifNonUser = false;
  var cekAssignUser = false;

  var cekUser = false;
  var cekRole = false;

  @override
  void onInit() async {
    super.onInit();
    cekTambahRole = await SharedPreferencesHelper.getHakAkses("Tambah Role");
    cekHapusRole = await SharedPreferencesHelper.getHakAkses("Hapus Role");
    cekAktifNonRole =
        await SharedPreferencesHelper.getHakAkses("Aktif/Nonaktifkan Role");
    cekDetailRole =
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Role");

    cekTambahUser =
        await SharedPreferencesHelper.getHakAkses("Tambah Sub User");
    cekHapusUser = await SharedPreferencesHelper.getHakAkses("Hapus Sub User");
    cekAktifNonUser =
        await SharedPreferencesHelper.getHakAkses("Aktif/Nonaktifkan Sub User");
    cekAssignUser =
        await SharedPreferencesHelper.getHakAkses("Assign Sub User");

    if (cekTambahRole || cekHapusRole || cekAktifNonRole || cekDetailRole) {
      cekRole = true;
    }

    if (cekTambahUser || cekHapusUser || cekAktifNonUser || cekAssignUser) {
      cekUser = true;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => onCompleteBuildWidget());
  }

  @override 
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onCompleteBuildWidget() async {
    if (isInit) {
      getInit();
      isInit = false;
    }
  }

  Future<void> getInit() async {
    isLoading.value = true;
    try {
      await getDataProfile();
      await getUserStatus();
      await getUserStatusSubscribe();
    } catch (error) {
      print("ERROR :: $error");
    }
    isLoading.value = false;
  }

  Future<void> getDataProfile({bool showLoading = false}) async {
    try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: showLoading).getDataUsers({});
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // sukses
          // convert json to object
          userProfil = UserProfil.fromJson(response["Data"]);
        } else {
          // error
        }
      } else {
        // error
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
    }
  }

  Future<void> getUserStatus({bool showLoading = false}) async {
    try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: showLoading).getUserStatus({});
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // sukses
          userStatus = UserStatus.fromJson(response["Data"]);
        } else {
          // error
        }
      } else {
        // error
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
    }
  }

  Future<void> getUserStatusSubscribe({bool showLoading = false}) async {
    try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: showLoading).getShipperReputasiAdminAndStatus({});
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // sukses
          userStatusSubscribe = StatusSubscribe.fromJson(response["Data"]);
        } else {
          // error
        }
      } else {
        // error
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
    }
  }

  //untuk cek jumlah kapasitas pengiriman bf
  Future<void> getBfQty(String qty, {bool showLoading = false} ) async {
    var body = {
      "Qty": qty,
    };
    try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: showLoading).setShipperCapacityQty(body);
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // sukses
          //pergi ke halaman form daftar bf
          GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.BF);
        } else {
          // error -1 = kapasitas kurang 
          if (response["Data"]["ValidateResult"] != null && response["Data"]["ValidateResult"] == -1) {
            GlobalAlertDialog2.showAlertDialogCustom(
              title: (response["Data"]["Title"]).toString().isEmpty ? null : response["Data"]["Title"], context: Get.context, borderRadius: 12, 
              message: response["Data"]["SubTitle"],
              labelButtonPriority1: "Lihat Transport Market",
              onTapPriority1: (){
                //pergi ke demo transporter
              }
            );
          } else if (response["Data"]["ValidateResult"] != null && response["Data"]["ValidateResult"] == 1) {
            // error 1 = kapasitas lebih dr ketentuan 
            popUpMemenuhiStandarBf(response["Data"]["Title"], response["Data"]["SubTitle"]);
          }
        }
      } else {
        // error
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
    }
  }

  //untuk cek jumlah kapasitas pengiriman Tm
  Future<void> getTmQty(String qty, {bool showLoading = false}) async {
    var body = {
      "Qty": qty,
    };
    try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: showLoading).setTmShipperCapacityQty(body);
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // sukses
          //pergi ke halaman form daftar tm
          GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.TM);
        } else {
          // error -1 = kapasitas kurang 
          if (response["Data"]["ValidateResult"] != null && response["Data"]["ValidateResult"] == -1) {
            GlobalAlertDialog2.showAlertDialogCustom(
              title: (response["Data"]["Title"]).toString().isEmpty ? null : response["Data"]["Title"], context: Get.context, borderRadius: 12, 
              message: response["Data"]["SubTitle"],
              labelButtonPriority1: "Lihat Transport Market",
              onTapPriority1: (){
                //pergi ke demo transporter
              }
            );
          } else if (response["Data"]["ValidateResult"] != null && response["Data"]["ValidateResult"] == 1) {
            // error 1 = kapasitas lebih dr ketentuan 
            popUpMemenuhiStandarBf(response["Data"]["Title"], response["Data"]["SubTitle"]);
          }
        }
      } else {
        // error
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
    }
  }

  Future<int> cekDaftarBf() async {
    await getUserStatus(showLoading: true);
    if (userStatus.shipperIsVerifBF == -1) {
      //proses menunggu verif
      GlobalAlertDialog2.showAlertDialogCustom(
        title: "Pengajuan Verifikasi Shipper Sedang  Diproses", context: Get.context, borderRadius: 12, 
        message: "Mohon menunggu sampai proses verifikasi oleh Admin muatmuat selesai. Periksa pemberitahuan secara berkala untuk mengetahui perkembangan pengajuan Anda.",
        labelButtonPriority1: "kirim",
        onTapPriority1: (){
          Get.back();
        }
      );
      return -1;
    } else if (userStatus.shipperIsVerifBF == 0) {
      //belum verif
      return 0;
      // await getBfQty(showLoading: true);
    } else if (userStatus.shipperIsVerifBF == 1) {
      //terverifikasi
      return 1;
    } else if (userStatus.shipperIsVerifBF == 2) {
      //ditolak
      return 2;
    }
  }

  Future<void> cekDaftarTm() async {
    await getUserStatus(showLoading: true);
    if (userStatus.shipperIsVerifTM == -1) {
      //proses menunggu verif
      GlobalAlertDialog2.showAlertDialogCustom(title: "title", context: Get.context, borderRadius: 12, 
      message: "Peng");
      return -1;
    } else if (userStatus.shipperIsVerifTM == 0) {
      //belum verif
      return 0;
      // await getBfQty(showLoading: true);
    } else if (userStatus.shipperIsVerifTM == 1) {
      //terverifikasi
      return 1;
    } else if (userStatus.shipperIsVerifTM == 2) {
      //ditolak
      return 2;
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
                  GetToPage.toNamed<UbahFotoProfilController>(Routes.UBAH_FOTO_PROFIL, arguments: 1);
                },
                'assets/ic_gallery.svg',
                'Pilih dari galeri',
              ),
              listContent(
                context,
                () async {
                  //TUTUP BOTTOMSHEET
                  Get.back();
                  GetToPage.toNamed<UbahFotoProfilController>(Routes.UBAH_FOTO_PROFIL, arguments: 2);
                },
                'assets/ic_camera.svg',
                'Ambil foto',
              ),
              listContent(
                context,
                () async {
                  Get.back();
                  await deletePhoto();
                  await getInit();
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
    log('DELETEE PHOTOO');
    try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: true, isDebugGetResponse: true).deletePhotoProfile({});
      if (response != null) {
        //TESTT
        // Get.back();
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
    log('UPDATE PHOTOO');

    try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: true, isDebugGetResponse: true).updatePhotoProfile(image);
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          Get.back();
          CustomToastTop.show(context: Get.context, message: response["Data"]['Message'], isSuccess: 1);
        } else {
          String errorMessage = response["Data"]["Message"];
          Get.back();
          CustomToastTop.show(message: errorMessage, context: Get.context, isSuccess: 0);
        }
      }
    } catch (err) {
      print("Can't update photo : " + err.toString());
    }
  }

  Widget listContent(
    BuildContext context,
    void Function() onTap,
    String icon,
    String text,
  ) {
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

  Future copyButton() async {
    await Clipboard.setData(ClipboardData(text: userProfil.code)).then(
      (value) => CustomToast.show(
        buttonText: "Tutup",
        context: Get.context,
        message: 'Kode Referral berhasil disalin' ,
      ),
    );
  }

  
  void clearTextKapasitas() {
    tecKapasitasPengiriman.text = "";
  }

  void onWillPop() {
    Get.back(result: isChange.value /* isChange */);
  }

  void popUpMemenuhiStandarBf(String title, String message) {
    GlobalAlertDialog2.showAlertDialogCustom(
      title: title.isEmpty ? null : title, context: Get.context, borderRadius: 12, 
      paddingButton: EdgeInsets.all(0),
      paddingContent:  EdgeInsets.only(
        top: GlobalVariable.ratioWidth(Get.context) * (title != null ? title.isNotEmpty ? 0 : 24 : 24),
        left: GlobalVariable.ratioWidth(Get.context) * 16,
        right: GlobalVariable.ratioWidth(Get.context) * 16,
        bottom: GlobalVariable.ratioWidth(Get.context) * 24),
      customMessage: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: CustomText(message ?? "",
                textAlign: TextAlign.center,
                fontSize: 14,
                height: 16.8 / 14,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          _button(
            marginTop: 20,
            marginBottom: 12,
            text: "Daftar Shipper Big Fleets",
            width: 187,
            height: 32,
            backgroundColor: Color(ListColor.colorBlue),
            onTap: (){
              //ke halaman form daftar bf
              GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.BF);
          }),
          _button(
            text: "Lanjutkan",
            width: 187,
            height: 32,
            color: Color(ListColor.colorBlue),
            useBorder: true,
            onTap: (){
              //ke halaman form daftar tm
              GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.TM);
          })
        ],
      ),
    );
  }

  Widget _button({
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text ?? "",
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }
}
