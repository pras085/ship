import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/Zero One/extra_widget/shared_preferences_helper_zo.dart' as spzo;
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_home/subscription_home_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/subscription_home/tm_subscription_home_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/manajemen_notifikasi_controller.dart';
import 'package:muatmuat/app/modules/notification/notif_controller.dart';
import 'package:muatmuat/app/modules/profile_individu/profile_individu_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/manajemen_role/manajemen_role_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/manajemen_user/manajemen_user_controller.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/pengaturan_akun/pengaturan_akun_controller.dart';
import 'package:muatmuat/app/modules/home/profile/profil_controller.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/list_management_lokasi/list_management_lokasi_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/thousand_separator.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ProfilView extends GetView<ProfilController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
        onWillPop: () {
          controller.onWillPop();
          return Future.value(false);
        },
        child: Container(
          color: Color(ListColor.colorBlue),
          child: SafeArea(
            child: Scaffold(
                appBar: AppBarDetailProfil(
                  type: 1,
                  onClickBack: () {
                    Get.back();
                  },
                  isWithShadow: false,
                  prefixIcon: [
                    GestureDetector(
                      onTap: (){
                         GetToPage.toNamed<NotifControllerNew>(
                                    Routes.NOTIF);
                      },
                      child: SvgPicture.asset(
                        "assets/ic_notif_off.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                      ),
                    )
                  ],
                  titleWidget: GestureDetector(
                    onDoubleTap: () {
                      Get.toNamed(Routes.FAKE_HOME);
                    },
                    child: SvgPicture.asset(
                      "assets/ic_logo_muatmuat_putih.svg",
                      height: GlobalVariable.ratioWidth(Get.context) * 18,
                    ),
                  ),
                ),
                body: Obx(
                  () => controller.isLoading.value
                      ? Container(
                          color: Color(ListColor.colorWhite),
                          padding: EdgeInsets.symmetric(vertical: 40),
                          width: Get.context.mediaQuery.size.width,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator()),
                              ),
                              CustomText("ListTransporterLabelLoading".tr),
                            ],
                          ))
                      : Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //card profile
                                      _cardProfilUser(),
                                      //card daftar bf tm
                                      (controller.userProfil.userType == 1 
                                      || (controller.userProfil.userType == -1 && 
                                      (controller.userStatus.shipperIsVerifBF == -1 || controller.userStatus.shipperIsVerifTM == -1
                                      || controller.userStatus.transporterIsVerifBF == -1 || controller.userStatus.transporterIsVerifTM == -1
                                      || controller.userStatus.sellerIsVerif == -1)))
                                        ? Container(
                                            decoration: BoxDecoration(color: Color(ListColor.colorLightBlue10)),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                                              vertical: GlobalVariable.ratioWidth(Get.context) * 16),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 8),
                                                color: Color(ListColor.colorWhite),
                                              ),
                                              child: Container(
                                                height: GlobalVariable.ratioWidth(Get.context) * 87,
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    _tipeUserDaftarBf(),
                                                    Container(
                                                      color: Color(ListColor.colorLightGrey4),
                                                      margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 8),
                                                      height: GlobalVariable.ratioWidth(Get.context) * 71,
                                                      width: GlobalVariable.ratioWidth(Get.context) * 0.5,
                                                    ),
                                                    _tipeUserDaftarTm()
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                      //card pengaturan akun
                                      Container(
                                        color: Color(
                                          (controller.userProfil.userType == 1 
                                          || (controller.userProfil.userType == -1 && 
                                          (controller.userStatus.shipperIsVerifBF == -1 || controller.userStatus.shipperIsVerifTM == -1
                                          || controller.userStatus.transporterIsVerifBF == -1 || controller.userStatus.transporterIsVerifTM == -1
                                          || controller.userStatus.sellerIsVerif == -1)))
                                            ? ListColor.colorLightBlue10
                                            : ListColor.colorBlue),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                              topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                          clipBehavior: Clip.antiAlias,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                              topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
                                            child: Column(
                                              mainAxisAlignment:MainAxisAlignment.start,
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  color: Colors.white,
                                                  width: double.infinity,
                                                  height: GlobalVariable.ratioWidth(Get.context) * 20,
                                                ),
                                                _tipeUserPengaturanAkun(),
                                                // _cardPengaturanAkun(() {
                                                //     GetToPage.toNamed<ProfilePerusahaanController>(Routes.PROFILE_PERUSAHAAN,);
                                                //   }, "assets/ic_profil_profil_perusahaan.svg",
                                                //       "Profil Perusahaan"),
                                                  
                                                // _cardPengaturanAkun(() {
                                                //   // _kapasitasPengiriman((){});
                                                //   GetToPage.toNamed<PengaturanAkunController>(Routes.PENGATURAN_AKUN);
                                                // }, "assets/ic_profil_pengaturan_akun.svg",
                                                //     "Pengaturan Akun"),
                                                // _cardPengaturanAkun(() {
                                                //   GetToPage.toNamed<ListManagementLokasiController>(Routes.LIST_MANAGEMENT_LOKASI);
                                                // }, "assets/ic_profil_manajemen_lokasi.svg",
                                                //     "Manajemen Lokasi"),
                                                // _cardPengaturanAkun(() {
                                                //   GlobalVariable.isDebugMode = !GlobalVariable.isDebugMode;
                                                //   CustomToast.show(
                                                //       context: Get.context,
                                                //       message: GlobalVariable.isDebugMode.toString());
                                                // }, "assets/ic_profil_manajemen_notifikasi.svg",
                                                //     "Manajemen Notifikasi"),
                                                // _cardPengaturanAkun(() {
                                                  
                                                // }, "assets/ic_profil_manajemen_user.svg",
                                                //     "Manajemen User"),
                                                // _cardPengaturanAkun(
                                                //     () {
                                                //       controller.popUpMemenuhiStandarBf("","qweqweqweqw");
                                                //     },
                                                //     "assets/ic_profil_manajemen_role.svg",
                                                //     "Manajemen Role"),
                                                // _cardPengaturanAkun(
                                                //     () {
                                                //       LoginFunction().signOut2();
                                                //     },
                                                //     "assets/ic_profil_audit_trail.svg",
                                                //     "Audit Trail"),
                                                // Container(
                                                //   color: Colors.white,
                                                //   width: double.infinity,
                                                //   height:
                                                //       GlobalVariable.ratioWidth(Get.context) * 16,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                child: _button(
                                  marginTop: 20,
                                  marginBottom: 16,
                                  marginLeft: 14,
                                  marginRight: 14,
                                  maxWidth: true,
                                  height: 36,
                                  text: "Keluar",
                                  backgroundColor: Color(ListColor.colorBlue),
                                  onTap: (){
                                    LoginFunction().signOut2();
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),
                )),
          ),
        ));
  }

  Widget _cardProfilUser() {
    return Container(
      color: Color(ListColor.colorBlue),
      height: GlobalVariable.ratioWidth(Get.context) * 131,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Image(
              image: AssetImage("assets/fallin_star_3_icon.png"),
              fit: BoxFit.cover,
              width: GlobalVariable.ratioWidth(Get.context) * 138,
              height: GlobalVariable.ratioWidth(Get.context) * 58),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 30,
                    right: GlobalVariable.ratioWidth(Get.context) * 20,
                    top: GlobalVariable.ratioWidth(Get.context) * 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 6),
                      child: ClipRRect(borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 100),
                        child: Container(
                          color: Colors.white,
                          width: GlobalVariable.ratioWidth(Get.context) * 80,
                          height: GlobalVariable.ratioWidth(Get.context) * 80,
                          alignment: Alignment.centerLeft,
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: GlobalVariable.ratioWidth(Get.context) * 80,
                              height: GlobalVariable.ratioWidth(Get.context) * 80,
                              imageUrl: controller.userProfil == null 
                              ? ""
                              : controller.userProfil.filePath == null 
                                ? "" 
                                :controller.userProfil.filePath,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //ubah foto
                        controller.showUpload();
                      },
                      child: CustomText(
                        "Ubah Foto",
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorWhite),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 16),
                        child: CustomText(
                          controller.userProfil.name,
                          // 'Emely Clark Kent Spiderman Batman Superman Supardi',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(ListColor.colorWhite),
                          height: 1.2,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 8),
                        child: CustomText(
                          _tipeUser(),
                          // 'Perusahaan',
                          maxLines: 1,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorWhite),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 8),
                          child: controller.userProfil.isSubUser == 0
                              ? Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      controller.userProfil.code,
                                      maxLines: 1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor.colorWhite),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.copyButton();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                8),
                                        child: SvgPicture.asset(
                                          "assets/ic_profil_copy.svg",
                                          color: Colors.white,
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              18,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox.shrink()),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String _tipeUser() {
    String status = "";
    if (controller.userProfil.isSubUser == 0) {
      if (controller.userProfil.userType == -1) {
        //akun yg belum mendaftar parusahaan atau individu atau akun yg sedang menunggu verifikasi(pasti perusahaan)
        if (controller.userStatus.shipperIsVerifBF == -1 || controller.userStatus.shipperIsVerifTM == -1
            || controller.userStatus.transporterIsVerifBF == -1 || controller.userStatus.transporterIsVerifTM == -1
            || controller.userStatus.sellerIsVerif == -1) {
          //akun yg sedang menunggu verifikasi(pasti perusahaan)
          status = "Perusahaan";
        } else {
          //akun yg belum mendaftar parusahaan atau individu
          status = "";
        }
      } else if (controller.userProfil.userType == 0) {
        //akun individu
        status = "Individu";
      } else if (controller.userProfil.userType == 1) {
        // if (controller.userProfil.businessEntityStatus == 1) {
          //akun perusahaan
          status = "Perusahaan";
        // } else if (controller.userProfil.businessEntityStatus == 2) {
        //   status = "Yayasan";
        // }
      }
    } else if (controller.userProfil.isSubUser == 1) {
      status = "Subuser";
    }
    return status;
  }

  Widget _tipeUserPengaturanAkun() {
    String status = _tipeUser();
    if(status == "") {
      return Column(
        children: [
          _cardPengaturanAkun(() async {
            var response = await GetToPage.toNamed<PengaturanAkunController>(Routes.PENGATURAN_AKUN);
            if(response != null) {
              if(response) {
                controller.isChange.value = response;
                controller.getInit();
              }
            }
          }, "assets/ic_profil_pengaturan_akun.svg",
              "Pengaturan Akun"),
          _cardPengaturanAkun(() {
            GetToPage.toNamed<ListManagementLokasiController>(Routes.LIST_MANAGEMENT_LOKASI);
          }, "assets/ic_profil_manajemen_lokasi.svg",
              "Manajemen Lokasi"),
          _cardPengaturanAkun(() {
            GetToPage.toNamed<ManajemenNotifikasiController>(Routes.MANAJEMEN_NOTIFIKASI, isRegistered: true);
          }, "assets/ic_profil_manajemen_notifikasi.svg",
              "Manajemen Notifikasi"),
        ],
      );
    } else if (status == "Individu") {
      return Column(
        children: [
          _cardPengaturanAkun(() {
              GetToPage.toNamed<ProfileIndividuController>(Routes.PROFILE_INDIVIDU,);
            }, "assets/ic_profil_profil_perusahaan.svg",
                "Profil Individu"),
          _cardPengaturanAkun(() async {
            var response = await GetToPage.toNamed<PengaturanAkunController>(Routes.PENGATURAN_AKUN);
            if(response != null) {
              if(response) {
                controller.isChange.value = response;
                controller.getInit();
              }
            }
          }, "assets/ic_profil_pengaturan_akun.svg",
              "Pengaturan Akun"),
          _cardPengaturanAkun(() {
            GetToPage.toNamed<ListManagementLokasiController>(Routes.LIST_MANAGEMENT_LOKASI);
          }, "assets/ic_profil_manajemen_lokasi.svg",
              "Manajemen Lokasi"),
          _cardPengaturanAkun(() {
            GetToPage.toNamed<ManajemenNotifikasiController>(Routes.MANAJEMEN_NOTIFIKASI, isRegistered: true);
          }, "assets/ic_profil_manajemen_notifikasi.svg",
              "Manajemen Notifikasi"),
        ],
      );
    } else if (status == "Perusahaan") {
      return Column(
        children: [
          _cardPengaturanAkun(() {
              GetToPage.toNamed<ProfilePerusahaanController>(Routes.PROFILE_PERUSAHAAN,);
            }, "assets/ic_profil_profil_perusahaan.svg",
                "Profil Perusahaan"),
          _cardPengaturanAkun(() async {
            var response = await GetToPage.toNamed<PengaturanAkunController>(Routes.PENGATURAN_AKUN);
            if(response != null) {
              if(response) {
                controller.isChange.value = response;
                controller.getInit();
              }
            }
          }, "assets/ic_profil_pengaturan_akun.svg",
              "Pengaturan Akun"),
          _cardPengaturanAkun(() {
            GetToPage.toNamed<ListManagementLokasiController>(Routes.LIST_MANAGEMENT_LOKASI);
          }, "assets/ic_profil_manajemen_lokasi.svg",
              "Manajemen Lokasi"),
          _cardPengaturanAkun(() {
            GetToPage.toNamed<ManajemenNotifikasiController>(Routes.MANAJEMEN_NOTIFIKASI, isRegistered: true);
          }, "assets/ic_profil_manajemen_notifikasi.svg",
              "Manajemen Notifikasi"),
          
          if ((controller.userStatus.shipperIsVerifBF == 1 || controller.userStatus.shipperIsVerifTM == 1) &&
              controller.cekUser)
            _cardPengaturanAkun(() async {
              print('USER');
              controller.cekTambahUser = await SharedPreferencesHelper.getHakAkses("Tambah Sub User", denganLoading: true);
              controller.cekHapusUser = await SharedPreferencesHelper.getHakAkses("Hapus Sub User", denganLoading: true);
              controller.cekAktifNonUser = await SharedPreferencesHelper.getHakAkses("Aktif/Nonaktifkan Sub User", denganLoading: true);
              controller.cekAssignUser = await SharedPreferencesHelper.getHakAkses("Assign Sub User", denganLoading: true);

              if (controller.cekTambahUser ||
                  controller.cekHapusUser ||
                  controller.cekAktifNonUser ||
                  controller.cekAssignUser) {
                controller.cekUser = true;
              }

              if (SharedPreferencesHelper.cekAkses(controller.cekUser)) {
                GetToPage.toNamed<ManajemenUserController>(
                    Routes.MANAJEMEN_USER);
              }
            }, "assets/ic_profil_manajemen_user.svg",
                "Manajemen User"),
          
          if ((controller.userStatus.shipperIsVerifBF == 1 || controller.userStatus.shipperIsVerifTM == 1) &&
              controller.cekRole)
            _cardPengaturanAkun(
                () async {
                  print('ROLE');
              controller.cekTambahRole = await SharedPreferencesHelper.getHakAkses("Tambah Role", denganLoading: true);
              controller.cekHapusRole = await SharedPreferencesHelper.getHakAkses("Hapus Role", denganLoading: true);
              controller.cekAktifNonRole = await SharedPreferencesHelper.getHakAkses("Aktif/Nonaktifkan Role", denganLoading: true);
              controller.cekDetailRole = await SharedPreferencesHelper.getHakAkses("Lihat Detail Role", denganLoading: true);
              controller.cekRole = await SharedPreferencesHelper.getHakAkses("Manajemen Role",denganLoading: true);

              if (controller.cekTambahRole ||
                  controller.cekHapusRole ||
                  controller.cekAktifNonRole ||
                  controller.cekDetailRole) {
                controller.cekRole = true;
              }

              if (SharedPreferencesHelper.cekAkses(controller.cekRole)) {
                GetToPage.toNamed<ManajemenRoleController>(
                    Routes.MANAJEMEN_ROLE);
              }
                },
                "assets/ic_profil_manajemen_role.svg",
                "Manajemen Role"),
          
          if (controller.userStatus.shipperIsVerifBF == 1 || controller.userStatus.shipperIsVerifTM == 1) 
            _cardPengaturanAkun(
                () {
                  // LoginFunction().signOut2();
                },
                "assets/ic_profil_audit_trail.svg",
                "Audit Trail"),
        ],
      );
    } else if (status == "Subuser") {
      return Column(
        children: [
          _cardPengaturanAkun(() {
              GetToPage.toNamed<ProfilePerusahaanController>(Routes.PROFILE_PERUSAHAAN,);
            }, "assets/ic_profil_profil_perusahaan.svg",
                "Profil Perusahaan"),
          _cardPengaturanAkun(() async {
            var response = await GetToPage.toNamed<PengaturanAkunController>(Routes.PENGATURAN_AKUN);
            if(response != null) {
              if(response) {
                controller.isChange.value = response;
                controller.getInit();
              }
            }
          }, "assets/ic_profil_pengaturan_akun.svg",
              "Pengaturan Akun"),
          _cardPengaturanAkun(() {
            GetToPage.toNamed<ListManagementLokasiController>(Routes.LIST_MANAGEMENT_LOKASI);
          }, "assets/ic_profil_manajemen_lokasi.svg",
              "Manajemen Lokasi"),
          _cardPengaturanAkun(() {
            GetToPage.toNamed<ManajemenNotifikasiController>(Routes.MANAJEMEN_NOTIFIKASI, isRegistered: true);
          }, "assets/ic_profil_manajemen_notifikasi.svg",
              "Manajemen Notifikasi"),

          if (controller.cekUser)
            _cardPengaturanAkun(() async {
              print('USER');
                controller.cekTambahUser = await SharedPreferencesHelper.getHakAkses("Tambah Sub User", denganLoading: true);
                controller.cekHapusUser = await SharedPreferencesHelper.getHakAkses("Hapus Sub User", denganLoading: true);
                controller.cekAktifNonUser = await SharedPreferencesHelper.getHakAkses("Aktif/Nonaktifkan Sub User", denganLoading: true);
                controller.cekAssignUser = await SharedPreferencesHelper.getHakAkses("Assign Sub User", denganLoading: true);

                if (controller.cekTambahUser ||
                    controller.cekHapusUser ||
                    controller.cekAktifNonUser ||
                    controller.cekAssignUser) {
                  controller.cekUser = true;
                }

                if (SharedPreferencesHelper.cekAkses(controller.cekUser)) {
                  GetToPage.toNamed<ManajemenUserController>(
                      Routes.MANAJEMEN_USER);
                }
            }, "assets/ic_profil_manajemen_user.svg",
                "Manajemen User"),
          
          if (controller.cekRole)
            _cardPengaturanAkun(
                () async {
                  print('ROLE');
              controller.cekTambahRole = await SharedPreferencesHelper.getHakAkses("Tambah Role", denganLoading: true);
              controller.cekHapusRole = await SharedPreferencesHelper.getHakAkses("Hapus Role", denganLoading: true);
              controller.cekAktifNonRole = await SharedPreferencesHelper.getHakAkses("Aktif/Nonaktifkan Role", denganLoading: true);
              controller.cekDetailRole = await SharedPreferencesHelper.getHakAkses("Lihat Detail Role", denganLoading: true);
              controller.cekRole = await SharedPreferencesHelper.getHakAkses("Manajemen Role", denganLoading: true);

              if (controller.cekTambahRole ||
                  controller.cekHapusRole ||
                  controller.cekAktifNonRole ||
                  controller.cekDetailRole) {
                controller.cekRole = true;
              }

              if (SharedPreferencesHelper.cekAkses(controller.cekRole)) {
                GetToPage.toNamed<ManajemenRoleController>(
                    Routes.MANAJEMEN_ROLE);
              }
                },
                "assets/ic_profil_manajemen_role.svg",
                "Manajemen Role"),
          _cardPengaturanAkun(
              () {

                // LoginFunction().signOut2();
              },
              "assets/ic_profil_audit_trail.svg",
              "Audit Trail"),
        ],
      );
    }
    return SizedBox.shrink();
  }

  Widget _tipeUserDaftarBf() {
    if (controller.userStatus.shipperIsVerifBF == -1 || controller.userStatus.shipperIsVerifTM == -1) {
      //proses menunggu verif
      return _cardDaftar(() {
        GlobalAlertDialog2.showAlertDialogCustom(
          title: "Pengajuan Verifikasi Shipper Sedang  Diproses", context: Get.context, borderRadius: 12, 
          message: "Mohon menunggu sampai proses verifikasi oleh Admin muatmuat selesai. Periksa pemberitahuan secara berkala untuk mengetahui perkembangan pengajuan Anda.",
          labelButtonPriority1: "Lihat Pemberitahuan",
          onTapPriority1: (){
            //pergi ke notif
          }
        );
      }, true, "Belum Terdaftar", "Daftar Sekarang", true, false);
    } else if (controller.userStatus.shipperIsVerifBF == 0) {
      //belum verif
      return _cardDaftar(() {
        if (controller.userStatus.shipperIsIntermediat == 0) {
          //jika akun belum terdaftar transporter (bukan intermediat)
          _kapasitasPengiriman(() async {
            await controller.getBfQty(controller.tecKapasitasPengiriman.text.isEmpty ? "0" : controller.tecKapasitasPengiriman.text, showLoading: true,);
            controller.clearTextKapasitas();
          });
        } else if (controller.userStatus.shipperIsIntermediat == 1) {
          //jika akun sudah terdaftar transporter (intermediat)
          GlobalAlertDialog2.showAlertDialogCustom(
            title: "Bergabung Menjadi Shipper Big Fleets", context: Get.context, borderRadius: 12, 
            message: "Anda merupakan intermediat yang harus memiliki kapasitas pengiriman per hari di atas batas minimum ketentuan. Apakah Anda yakin untuk mendaftar Shipper Big Fleets?",
            labelButtonPriority1: "Yakin, Gabung Sekarang",
            onTapPriority1: (){
              _kapasitasPengiriman(() async {
                await controller.getBfQty(controller.tecKapasitasPengiriman.text.isEmpty ? "0" : controller.tecKapasitasPengiriman.text, showLoading: true,);
                controller.clearTextKapasitas();
              });
            }
          );
        }
      }, true, "Belum Terdaftar", "Daftar Sekarang", true, false);
    } else if (controller.userStatus.shipperIsVerifBF == 1) {
      //terverifikasi
      if (controller.userStatusSubscribe.isSubscribeBF == 0) {
        //tidak subscribe
        return _cardDaftar(() {
          //pergi ke subscription
          GetToPage.toNamed<SubscriptionHomeController>(Routes.SUBSCRIPTION_HOME);
        }, true, "Terdaftar", "Berlangganan Sekarang", true, false);
      } else if (controller.userStatusSubscribe.isSubscribeBF == 1) {
        //subscribe
        if (controller.userStatusSubscribe.isNextBF == 0) {
          //waktu subscribe lebih dr 7 hari
          return _cardDaftar(() {
            //do nothing
          }, true, "Berlangganan", "", false, true);
        } else if (controller.userStatusSubscribe.isNextBF == 1) {
          //waktu subscribe kurang dr 7 hari
          return _cardDaftar(() {
            //pergi ke subscription
            GetToPage.toNamed<SubscriptionHomeController>(Routes.SUBSCRIPTION_HOME);
          }, true, "Berlangganan", "Perpanjang Langganan", false, false);
        }
      }
    } else if (controller.userStatus.shipperIsVerifBF == 2) {
      //ditolak
      return _cardDaftar(() {
        _kapasitasPengiriman(() async {
          await controller.getBfQty(controller.tecKapasitasPengiriman.text.isEmpty ? "0" : controller.tecKapasitasPengiriman.text, showLoading: true,);
          controller.clearTextKapasitas();
        });
      }, true, "Belum Terdaftar", "Daftar Sekarang", true, false);
    }
    return Container();
  }

  Widget _tipeUserDaftarTm() {
    if (controller.userStatus.shipperIsVerifTM == -1 || controller.userStatus.shipperIsVerifBF == -1) {
      //proses menunggu verif
      return _cardDaftar(() {
        GlobalAlertDialog2.showAlertDialogCustom(
          title: "Pengajuan Verifikasi Shipper Sedang  Diproses", context: Get.context, borderRadius: 12, 
          message: "Mohon menunggu sampai proses verifikasi oleh Admin muatmuat selesai. Periksa pemberitahuan secara berkala untuk mengetahui perkembangan pengajuan Anda.",
          labelButtonPriority1: "Lihat Pemberitahuan",
          onTapPriority1: (){
            //pergi ke notif
          }
        );
      }, false, "Belum Terdaftar", "Daftar Sekarang", true, false);
    } else if (controller.userStatus.shipperIsVerifTM == 0) {
      //belum verif
      return _cardDaftar(() {
        if (controller.userStatus.shipperIsIntermediat == 0) {
          //jika akun belum terdaftar transporter
          _kapasitasPengiriman(() async {
            await controller.getTmQty(controller.tecKapasitasPengiriman.text.isEmpty ? "0" : controller.tecKapasitasPengiriman.text, showLoading: true,);
            controller.clearTextKapasitas();
          });
        } else if (controller.userStatus.shipperIsIntermediat == 1) {
          //jika akun sudah terdaftar transporter
          GlobalAlertDialog2.showAlertDialogCustom(
            title: "Bergabung Menjadi Shipper bf", context: Get.context, borderRadius: 12, 
            message: "Mohon menunggu sampai proses verifikasi oleh Admin muatmuat selesai. Periksa pemberitahuan secara berkala untuk mengetahui perkembangan pengajuan Anda.",
            labelButtonPriority1: "Lihat Pemberitahuan",
            onTapPriority1: (){
              _kapasitasPengiriman(() async {
                await controller.getTmQty(controller.tecKapasitasPengiriman.text.isEmpty ? "0" : controller.tecKapasitasPengiriman.text, showLoading: true,);
                controller.clearTextKapasitas();
              });
            }
          );
        }
      }, false, "Belum Terdaftar", "Daftar Sekarang", true, false);
    } else if (controller.userStatus.shipperIsVerifTM == 1) {
      //terverifikasi
      if (controller.userStatusSubscribe.isSubscribeTM == 0) {
        //tidak subscribe
        return _cardDaftar(() {
          //pergi ke subscription
          GetToPage.toNamed<TMSubscriptionHomeController>(Routes.TM_SUBSCRIPTION_HOME);
        }, false, "Terdaftar", "Berlangganan Sekarang", true, false);
      } else if (controller.userStatusSubscribe.isSubscribeTM == 1) {
        //subscribe
        if (controller.userStatusSubscribe.isNextTM == 0) {
          //waktu subscribe lebih dr 7 hari
          return _cardDaftar(() {
            //do nothing
          }, false, "Berlangganan", "", false, true);
        } else if (controller.userStatusSubscribe.isNextTM == 1) {
          //waktu subscribe kurang dr 7 hari
          return _cardDaftar(() {
            //pergi ke subscription
            GetToPage.toNamed<TMSubscriptionHomeController>(Routes.TM_SUBSCRIPTION_HOME);
          }, false, "Berlangganan", "Perpanjang Langganan", false, false);
        }
      }
    } else if (controller.userStatus.shipperIsVerifTM == 2) {
      //ditolak
      return _cardDaftar(() {
        _kapasitasPengiriman(() async {
          await controller.getTmQty(controller.tecKapasitasPengiriman.text.isEmpty ? "0" : controller.tecKapasitasPengiriman.text, showLoading: true,);
          controller.clearTextKapasitas();
        });
      }, false, "Belum Terdaftar", "Daftar Sekarang", true, false);
    }
    return Container();
  }

  Widget _cardDaftar(Function onTap, bool bf, String tengah, String bawah,
      bool hideIcon, bool hideBawah) {
    return Expanded(
        child: GestureDetector(
      onTap: (){onTap();},
      child: Container(
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * (bf ? 14 : 8),
            0,
            GlobalVariable.ratioWidth(Get.context) * (bf ? 8 : 14),
            0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 15),
              child: CustomText(
                bf ? 'Big Fleets Shipper' : 'Transport Market Shipper',
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorLightGrey4),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: CustomText(
                      tengah,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(ListColor.colorLightBlue11),
                    ),
                  ),
                  hideIcon
                      ? SizedBox.shrink()
                      : Container(
                          padding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 4,
                          ),
                          child: SvgPicture.asset(
                            "assets/ic_profil_subscribe.svg",
                            height: GlobalVariable.ratioWidth(Get.context) * 14,
                          ),
                        ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 6),
              child: CustomText(
                hideBawah ? "" : bawah,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorBlue),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _cardPengaturanAkun(Function onTap, String icon, String text) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: GlobalVariable.ratioWidth(Get.context) * 52,
        color: Colors.white,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 25,
                  right: GlobalVariable.ratioWidth(Get.context) * 10),
              child: SvgPicture.asset(
                icon,
                width: GlobalVariable.ratioWidth(Get.context) * 24,
              ),
            ),
            Expanded(
                child: Container(
              child: CustomText(
                text,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            )),
            Container(
              margin: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 10,
                  right: GlobalVariable.ratioWidth(Get.context) * 25),
              child: SvgPicture.asset(
                "assets/ic_profil_arrow_right.svg",
                width: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _kapasitasPengiriman(Function onTap) async {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
                topRight: Radius.circular( GlobalVariable.ratioWidth(Get.context) * 20))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              controller.clearTextKapasitas();
              Get.back();
              return Future.value(false);
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 4,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 17),
                      child: Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 38,
                        height: GlobalVariable.ratioWidth(Get.context) * 3,
                        decoration: BoxDecoration(
                            color: Color(ListColor.colorLightGrey16),
                            borderRadius: BorderRadius.all(Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 4))),
                      )),
                  Container(
                      padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 12,
                          right: GlobalVariable.ratioWidth(Get.context) * 12,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: CustomText("Kapasitas Pengiriman".tr,
                                  fontWeight: FontWeight.w700,
                                  color: Color(ListColor.color4),
                                  fontSize: 14)),
                          Padding(
                            padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 8),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  controller.clearTextKapasitas();
                                  Get.back();
                                },
                                child: Container(
                                  child: SvgPicture.asset(
                                    "assets/ic_close1,5.svg",
                                    color: Color(ListColor.colorBlack),
                                    width: GlobalVariable.ratioWidth(Get.context) * 15,
                                    height: GlobalVariable.ratioWidth(Get.context) * 15,
                                  )
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(Get.context) * 16,
                            GlobalVariable.ratioWidth(Get.context) * 10,
                            GlobalVariable.ratioWidth(Get.context) * 16,
                            GlobalVariable.ratioWidth(Get.context) * 20),
                        child: CustomText(
                          "Sebelum melanjutkan Proses Resgistrasi sebagai Shipper mohon mengisi jumlah kapasitas pengiriman rata-rata Anda per hari",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                          height: 1.5,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(Get.context) * 66,
                            0,
                            GlobalVariable.ratioWidth(Get.context) * 66,
                            GlobalVariable.ratioWidth(Get.context) * 20),
                        height: GlobalVariable.ratioWidth(Get.context) * 40,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: GlobalVariable.ratioWidth(Get.context) * 1,
                                color: Color(ListColor.colorStroke)),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 8)),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CustomTextField(
                                    context: Get.context,
                                    autofocus: true,
                                    onChanged: (value) {
                                      // controller.searchOnChange(value);
                                    },
                                    controller: controller.tecKapasitasPengiriman,
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (value) {
                                      // controller.onSubmitSearch();
                                    },
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    textSize: 14,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(6),
                                      FilteringTextInputFormatter.digitsOnly,
                                      ThousandSeparatorFormatter()
                                    ],
                                    newInputDecoration: InputDecoration(
                                        hintText: "",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Color(ListColor.colorLightGrey2)),
                                        fillColor: Colors.transparent,
                                        filled: true,
                                        isDense: true,
                                        isCollapsed: true,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        border: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            GlobalVariable.ratioWidth(Get.context) * 11,
                                            GlobalVariable.ratioWidth(Get.context) * 12,
                                            GlobalVariable.ratioWidth(Get.context) * 103,
                                            GlobalVariable.ratioWidth(Get.context) * 0))),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                    right:GlobalVariable.ratioWidth(Get.context) * 11),
                                child: CustomText(
                                  "unit truk/hari",
                                  fontWeight: FontWeight.w400,
                                  color: Color(ListColor.colorLightGrey4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _button(
                          marginBottom: 20,
                          width: 83,
                          height: 32,
                          text: "Kirim",
                          color: Color(ListColor.colorWhite),
                          backgroundColor: Color(ListColor.colorBlue),
                          onTap: () {
                            Get.back();
                            onTap();
                          })
                    ],
                  )
                ],
              ),
            ),
          );
        });
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
