import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/search_address_google_function.dart';
import 'package:muatmuat/app/core/models/address_google_info_permintaan_muat_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_autocomplete_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/core/models/info_from_address_response_model.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/modules/lokasi_bf_tm/lokasi_bf_tm_controller.dart';
import 'package:muatmuat/app/modules/peta_bf_tm/search_location_map_bf_tm_controller.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_bftm/terms_and_conditions_bftm_controller.dart';
import 'package:muatmuat/app/modules/upload_legalitas/upload_legalitas_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:mime/src/mime_type.dart';
import 'package:latlong/latlong.dart';
import 'package:string_validator/string_validator.dart' as sv;
import 'package:muatmuat/app/core/function/api/get_info_from_address_place_id.dart';

class RegisterShipperBfTmController extends GetxController {
  // ##############
  // ##  GLOBAL  ##
  // ##############
  final formKey = GlobalKey<FormState>().obs;

  final double width = MediaQuery.of(Get.context).size.width - (GlobalVariable.ratioWidth(Get.context) * 32);
  var pageIndex = 1.obs;
  var subTitle = 'BFTMRegisterAllValidasiKapasitasPengiriman'.tr.obs;

  var tipeModul = TipeModul.BF.obs;
  var tipeBadanUsaha = TipeBadanUsaha.PT_CV.obs;

  var dispatchNoteUrl = "${ApiHelper.urlInternal}_resources/themes/muat/image/png/contoh_surat_jalan.png";

  var scrollControllerFirstPage = ScrollController();
  var scrollControllerSecondPage = ScrollController();
  var scrollControllerThirdPage = ScrollController();


  // USE THIS IF USING PARAMETER
  // PARAM
  var param = {};

  // TEXT CONTROLLER
  // CONTROLLER FIRST PAGE
  TextEditingController transporterCompany = TextEditingController();
  TextEditingController transporterPICName = TextEditingController();
  TextEditingController transporterPICPhone = TextEditingController();

  // CONTROLLER THIRD PAGE
  TextEditingController ktpDirekturController = TextEditingController();
  TextEditingController npwpPerusahaanController = TextEditingController();
  TextEditingController ktpController = TextEditingController();

  // FILE UPLOAD
  var file = File("").obs;
  var filelogo = File("").obs;

  // FILE UPLOAD FIRST PAGE
  var dispatchNote = [].obs;

  // FILE UPLOAD THIRD PAGE
  var fileAkta1 = [].obs;
  var fileAkta2 = [].obs;
  var fileAkta3 = [].obs;
  var fileKtpDirektur = [].obs;
  var fileAkta4 = [].obs;
  var fileNib = [].obs;
  var fileSertifikat = [].obs;
  var fileNpwpPerusahaan = [].obs;
  var fileKtp = [].obs;
  RxString placeidd = "".obs;
  var currmarker = LatLngBounds().obs;
  var currsession = false.obs;

  // FILE UPLOAD RESULT FIRST PAGE
  var dispatchNoteResult = [].obs;

  // FILE UPLOAD RESULT THIRD PAGE
  var fileAkta1Result = [].obs;
  var fileAkta2Result = [].obs;
  var fileAkta3Result = [].obs;
  var fileKtpDirekturResult = [].obs;
  var fileAkta4Result = [].obs;
  var fileNibResult = [].obs;
  var fileSertifikatResult = [].obs;
  var fileNpwpPerusahaanResult = [].obs;
  var fileKtpResult = [].obs;

  var errorMessage = "".obs;
  int changeIndex = -1.obs;

  // VIEW CHECKING VALIDATION
  // CHECK VALIDATION FIRST PAGE
  var isTransporterCompanyValid = true.obs;
  var isTransporterPICNameValid = true.obs;
  var isTransporterPICPhoneValid = true.obs;
  var company = "".obs;
  var picName = "".obs;
  var picPhone = "".obs;
  var isAllValid = false.obs;

  // SECOND PAGE VARIABLE
  var kategoriData = [].obs;
  var isSpecialLegal = false.obs;
  var loading = false.obs;
  String numberOfMarker = "";
  var mapController = MapController();
  var totalMarker = 5.obs;
  var lokasiakhir = " ".obs;
  var namalokasiakhir = " ".obs;
  var alamatlokasiakhir = " ".obs;
  LatLng _latLngFromArgms;

  var isOptionalFilled = false.obs;
  var isFilled = false.obs;
  var isValid = false.obs;
  var mapLokasiController = MapController();
  var latlngLokasi = {}.obs;
  var totalLokasi = "1".obs;
  var loadMapLokasi = false.obs;
  var namaLokasi = {}.obs;
  var totalDestinasi = "1".obs;
  var cityLokasi = {}.obs;
  var districtLokasi = {}.obs;
  var deskripsiLokasi = {}.obs;
  var namaPICPickup = {}.obs;
  var nomorPICPickup = {}.obs;
  var mapDestinasiController = MapController();

  // final formKey = GlobalKey<FormState>().obs;

  var businessFieldController = TextEditingController().obs;
  var districtController = TextEditingController().obs;
  Rx<TextEditingController> emailCtrl = Rx<TextEditingController>(TextEditingController());
  var isEditable = true.obs;
  TextEditingController namaPerusahaanC = TextEditingController();
  TextEditingController alamatPerusahaanC = TextEditingController();
  TextEditingController namaPIC1 = TextEditingController();
  TextEditingController noHpPIC1 = TextEditingController();
  TextEditingController noTelp = TextEditingController();
  TextEditingController namaPIC2 = TextEditingController();
  TextEditingController noHpPIC2 = TextEditingController();
  TextEditingController namaPIC3 = TextEditingController();
  TextEditingController noHpPIC3 = TextEditingController();

  // FOTO
  // var file = File("").obs;
  var fileDisplay = File('').obs;
  var isSuccessUpload = false.obs;
  // var errorMessage = "".obs;
  var picturefill = false.obs;
  var picturefilllogo = false.obs;

  //VALUE
  var distid = "".obs;
  var latmap = 0.obs;
  var lngmap = 0.obs;
  var isverif = "".obs;
  var namaPerusahaan = "".obs;
  var pilihBadanUsaha = Rxn<String>();
  var pilihBidangUsaha = Rxn<String>();
  var pilihKodePos = Rxn<String>();
  var kodepos = "".obs;
  var badan = "".obs;
  var cityStoreArg = "".obs;
  var provinceStoreArg = "".obs;
  var text = "".obs;
  var postalCodeList = [].obs;
  var badanUsahaList = [].obs;
  var bidangUsahaList = [].obs;
  var namaDestinasi = {}.obs;
  var latlngDestinasi = {}.obs;
  var cityDestinasi = {}.obs;
  var districtDestinasi = {}.obs;
  var deskripsiDestinasi = {}.obs;
  var idKecamatanResult = Rxn<int>();
  var kecamatanPerusahaanText = "".obs;
  var bidangterpilih = "".obs;
  var companydistrictid = "".obs;

  //CONTACT PICKER
  final ContactPicker contactPicker = ContactPicker();
  final ContactPicker contactPicker2 = ContactPicker();
  final ContactPicker contactPicker3 = ContactPicker();
  Contact contact1;
  Contact contact2;
  Contact contact3;

  //FOTO
  File imageFileValue;
  // File cropFile = ImageCropper.cropImage(sourcePath: imageFileValue!=null ?Image.file(image))

  //VALIDASI UNDONE
  var isNamaPerusahaanValid = true.obs;
  var isbadanUsahaValid = true.obs;
  var isBidangUsahaValid = true.obs;
  var isAlamaPerusahaanValid = true.obs;
  var isEmailValid = true.obs;
  var isKecamatanValid = true.obs;
  var isKodePosValid = true.obs;
  var isNamaPic1Valid = true.obs;
  var isNoPic1Valid = true.obs;
  var isNoTelpValid = true.obs;
  var isNamaPic2Valid = true.obs;
  var isNoPic2Valid = true.obs;
  var isNamaPic3Valid = true.obs;
  var isNoPic3Valid = true.obs;
  var isLogoPerusahaanValid = true.obs;
  var emailChanged = false.obs; 

  // FIELD VALUEE UNDONE
  var namaPerusahaanValue = "".obs;
  var badanUsahaValue = "".obs;
  var bidangUsahaValue = "".obs;
  var alamatPerusahaanValue = "".obs;
  var email= "".obs;
  var kecamatanValue = "".obs;
  var kodePosValue = "".obs;
  var namaPic1Value = "".obs;
  var noTelpPerusahaan = "".obs;
  var naoPic1Value = "".obs;
  var namaPic2Value = "".obs;
  var naoPic2Value = "".obs;
  var namaPic3Value = "".obs;
  var naoPic3Value = "".obs;
  RxString emailuser = "".obs;

  final _listSearchAddressTemp = [];

  // CHECK VALIDATION THIRD PAGE
  var isValidKtpDirektur = true.obs;
  var isValidNpwpPerusahaan = true.obs;
  var isValidKtp = true.obs;
  var isFilledThirdPage = false.obs;

  var isValidFileKtpDirektur = false.obs;
  var isValidFileNpwpPerusahaan = false.obs;
  var isValidFileKtp = false.obs;

  var isFilledFromCrossAkta1 = false.obs;
  var isFilledFromCrossAkta2= false.obs;
  var isFilledFromCrossAkta3= false.obs;
  var isFilledFromCrossKtpDirektur = false.obs;
  var isFilledFromCrossAkta4 = false.obs;
  var isFilledFromCrossNib = false.obs;
  var isFilledFromCrossSertifikat = false.obs;
  var isFilledFromCrossNpwpPerusahaan = false.obs;
  var isFilledFromCrossKtp = false.obs;

  // FILE DOWNLOAD
  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var processing = false.obs;
  var tapDownload = false;
  String filePath = "";
  String downloadId;
  var url = "".obs;
  var urlphoto = "".obs;
  var cross = false.obs;

  // PROGRESS BAR
  Timer timer;
  var totalTime = 10;
  var timePerForm = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0].obs;
  var ratioPerForm = [-1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0].obs;

  // SCROLL CONTROLLER
  var dispatchNoteScrollController = ScrollController();
  var formAkta1ScrollController = ScrollController();
  var formAkta2ScrollController = ScrollController();
  var formAkta3ScrollController = ScrollController();
  var formAkta4ScrollController = ScrollController();
  var formNibScrollController = ScrollController();
  var formSertifikatScrollController = ScrollController();

  var _isShowingDialogLoading = false;


  @override
  void onInit() async {
    super.onInit();
    tipeModul.value = Get.arguments;

    // CODE FROM FILE EXAMPLE
    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    getShipperRegistration();
    FlutterDownloader.registerCallback(downloadCallBack);

    loading.value = true;

    // Pengecekan sudah pernah daftar/belum
    // final cekStatus = await ApiHelper(context: Get.context, isShowDialogLoading: false).checkRegisterStatus();
    // final status = tipeModul.value == TipeModul.BF ? cekStatus['Data']['BFShipper'] : cekStatus['Data']['TMShipper'];
    // if (status != 0) {
    //   loading.value = false;
    //   Get.back(result: "Akun telah terdaftar!");
    //   return;
    // }

    // SEMENTARA SET QTY DISINI KARENA DIALOG UNTUK ISI CAPACITY QTY ADA DI VENDOR
    await ApiHelper(context: Get.context, isShowDialogLoading: false).setShipperCapacityQty(
      "50",
      tipeModul: tipeModul.value
    );

    email.value = GlobalVariable.userModelGlobal.email;
    emailCtrl.value.text = email.value;
    await getBadanUsaha();
    await getBidangUsaha();
    final response = await ApiHelper(context: Get.context, isShowDialogLoading: false).getEmailStatus();
    GlobalVariable.userModelGlobal.email = response['Data']['Email'];
    checkEmail();
    getShipperRegistration();
    loading.value = false;
  }

  void checkEmail() async {
    var result = await ApiHelper(context: Get.context, isShowDialogLoading: false).isEmailVerified(
      email.value
    );

    if (result!=null){
      isverif.value = result['Data']['Status'].toString();
    }
  }

  void getShipperRegistration() async {
    var result = await ApiHelper(context: Get.context, isShowDialogLoading: false).getShipperRegistration(
      tipeModul: tipeModul.value
    );
    
    if (result["Data"]["IsOnVerify"] == 1 || result["Data"]["IsVerified"] == 1){
      // sedang proses verif dan atau sudah verif
      log("DATA SEDANG DI VERIF DAN ATAU SUDAH VERIF");
      
      cross.value = true;
      urlphoto.value = result["Data"]["CompanyData"]["CompanyLogo"]["FullPath"].toString();
      namaPerusahaanC.text = result["Data"]["CompanyData"]["CompanyName"];
      namaPerusahaanValue.value = result["Data"]["CompanyData"]["CompanyName"];
      badan.value = result["Data"]["CompanyData"]["BusinessEntityName"];
      pilihBidangUsaha.value = result["Data"]["CompanyData"]["BusinessEntityId"].toString();
      businessFieldController.value.text = result["Data"]["CompanyData"]["BusinessFieldName"];
      bidangterpilih.value = result["Data"]["CompanyData"]["BusinessFieldName"];
      pilihBadanUsaha.value = result["Data"]["CompanyData"]["BusinessFieldId"].toString();
      alamatPerusahaanC.text  = result["Data"]["CompanyData"]["AddressDetail"] != null ? result["Data"]["CompanyData"]["AddressDetail"] : "";
      alamatPerusahaanValue.value = result["Data"]["CompanyData"]["AddressDetail"] != null ? result["Data"]["CompanyData"]["AddressDetail"] : "";
      districtController.value.text = result["Data"]["CompanyData"]["CompanyDistrictName"];
      kecamatanPerusahaanText.value = result["Data"]["CompanyData"]["CompanyDistrictName"];
      companydistrictid.value = result["Data"]["CompanyData"]["CompanyDistrictId"].toString();
      kodepos.value = result["Data"]["CompanyData"]["CompanyPostalCode"].toString();
      pilihKodePos.value = result["Data"]["CompanyData"]["CompanyPostalCode"].toString();
      noTelp.text = result["Data"]["CompanyData"]["CompanyPhone"];
      noTelpPerusahaan.value = result["Data"]["CompanyData"]["CompanyPhone"];
      namaPIC1.text = result["Data"]["CompanyData"]["Pic1Name"] != null ?result["Data"]["CompanyData"]["Pic1Name"] : "";
      namaPic1Value.value = result["Data"]["CompanyData"]["Pic1Name"] != null ?result["Data"]["CompanyData"]["Pic1Name"] : "";
      namaPIC2.text = result["Data"]["CompanyData"]["Pic2Name"] != null ?result["Data"]["CompanyData"]["Pic2Name"] : "";
      namaPic2Value.value = result["Data"]["CompanyData"]["Pic2Name"] != null ?result["Data"]["CompanyData"]["Pic2Name"] : "";
      namaPIC3.text = result["Data"]["CompanyData"]["Pic3Name"] != null ?result["Data"]["CompanyData"]["Pic3Name"] : "";
      namaPic2Value.value = result["Data"]["CompanyData"]["Pic3Name"] != null ?result["Data"]["CompanyData"]["Pic3Name"] : "";
      noHpPIC1.text = result["Data"]["CompanyData"]["Pic1Phone"] != null ?result["Data"]["CompanyData"]["Pic1Phone"].toString() : "";
      naoPic1Value.value = result["Data"]["CompanyData"]["Pic1Phone"] != null ?result["Data"]["CompanyData"]["Pic1Phone"].toString() : "";
      noHpPIC2.text = result["Data"]["CompanyData"]["Pic2Phone"] != null ?result["Data"]["CompanyData"]["Pic2Phone"].toString() : "";
      naoPic2Value.value = result["Data"]["CompanyData"]["Pic2Phone"] != null ?result["Data"]["CompanyData"]["Pic2Phone"].toString() : "";
      noHpPIC3.text = result["Data"]["CompanyData"]["Pic3Phone"] != null ?result["Data"]["CompanyData"]["Pic3Phone"].toString() : "";
      naoPic3Value.value = result["Data"]["CompanyData"]["Pic3Phone"] != null ?result["Data"]["CompanyData"]["Pic3Phone"].toString() : "";
      alamatlokasiakhir.value = result["Data"]["CompanyData"]["CompanyAddress"];
      lokasiakhir.value = result["Data"]["CompanyData"]["CompanyAddress"];

      fillThirdPage(result["Data"]["Legality"]);
    }
    else{
      // belum 
      log("DATA BELUM DI VERIF DAN BELUM VERIF");
    }
  }

  // ##############
  // ##  GLOBAL  ##
  // ##############
  changePageIndex(int pageIdx) {
    if(pageIdx == 1){
      subTitle.value = 'BFTMRegisterAllValidasiKapasitasPengiriman'.tr;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollControllerFirstPage.animateTo(scrollControllerFirstPage.position.minScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      });
      if(currsession.value == true){
        // print('gf');
        // updateMapp('lokasi', currmarker.value);
      }
    }
    else if(pageIdx == 2){
      subTitle.value = 'Data Perusahaan';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollControllerSecondPage.animateTo(scrollControllerSecondPage.position.minScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      });
      checkEmail();
      if(currsession.value == true){
      }
    }
    else if(pageIdx == 3){
      subTitle.value = 'Kelengkapan Legalitas';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollControllerThirdPage.animateTo(scrollControllerThirdPage.position.minScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      });

      log("File Ktp Direktur Filled: " + fileKtpDirektur.isEmpty.toString());
      log("File Ktp Direktur Valid: " + isValidFileKtpDirektur.value.toString());
      log("File Npwp Perusahaan Filled: " + fileNpwpPerusahaan.isEmpty.toString());
      log("File Npwp Perusahaan Valid: " + isValidFileNpwpPerusahaan.value.toString());
      log("File Ktp Filled: " + fileKtp.isEmpty.toString());
      log("File Ktp Valid: " + isValidFileKtp.value.toString());
    }
  }

  getIdUsaha(int idKecamatan) async {
    print('masuk xsr');
    postalCodeList.clear();
    pilihKodePos.value = null;
    var result = await ApiHelper(
            context: Get.context,
            isDebugGetResponse: true,
            isShowDialogLoading: false)
        .getPostalCode(idKecamatan.toString());
    postalCodeList.value = result == null ? [] : result['Data'];
    // print(postalCodeList);
  }

  showHintFile(int type) {
    // type 0 = surat jalan
    // type 1 = akta pendirian
    // type 2 = akta anggaran
    // type 3 = akta direksi
    // type 4 = ktp Direktur
    // type 5 = akta perubahan
    // type 6 = nib
    // type 7 = sertifikat standard
    // type 8 = npwp perusahaan
    // type 9 = ktp pendaftar
    String title = "";
    if(type == 1){
      title = "Contoh File Akta Pendirian Perusahaan dan SK KEMENKUMHAM";
    }
    else if(type == 2){
      title = "Contoh File Akta Anggaran Dasar Terakhir dan SK";
    }
    else if(type == 3){
      title = "Contoh File Akta Direksi dan Dewan Komisaris terakhir dan SK Menkumham";
    }
    else if(type == 5){
      title = "Contoh File Akta Perubahan terakhir dan SK";
    }
    else if(type == 6){
      title = "Contoh File NIB";
    }
    else if(type == 7){
      title = "Contoh File Sertifikat Standar";
    }
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 25), 
          topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 25)
        )
      ),
      backgroundColor: Colors.white,
      context: Get.context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 8,
                bottom: GlobalVariable.ratioWidth(Get.context) * 24
              ),
              child: Container(
                width: GlobalVariable.ratioWidth(Get.context) * 94,
                height: GlobalVariable.ratioWidth(Get.context) * 5,
                decoration: BoxDecoration(
                  color: Color(ListColor.colorLightGrey10),
                  borderRadius: BorderRadius.all(
                    Radius.circular(GlobalVariable.ratioWidth(Get.context) * 90)
                  )
                ),
              )),
            Container(
              margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16, 
                GlobalVariable.ratioWidth(Get.context) * 0, 
                GlobalVariable.ratioWidth(Get.context) * 16, 
                GlobalVariable.ratioWidth(Get.context) * 16
              ),
              child: CustomText(
                title,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.2,
                textAlign: TextAlign.center,
              )
            ),
            Container(
              width: GlobalVariable.ratioWidth(Get.context) * 328,
              height: GlobalVariable.ratioWidth(Get.context) * 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                border: Border.all(
                  color: Color(ListColor.colorGrey6)
                )
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                child: Image.network(
                  "https://blog-static.mamikos.com/wp-content/uploads/2021/04/Surat-jalan-1.png",
                  fit: BoxFit.fitWidth
                ),
              ),
            ),
            _button(
              width: 139,
              height: 30,
              marginLeft: 16,
              marginTop: 24,
              marginRight: 16,
              marginBottom: 24,
              useBorder: false,
              borderRadius: 18,
              backgroundColor: Color(ListColor.colorBlue),
              customWidget: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/ic_download.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 14,
                    height: GlobalVariable.ratioWidth(Get.context) * 14,
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 6),
                  CustomText(
                    "Download",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ],
              ),
              onTap: (){
                Get.back();
                downloadFile("https://blog-static.mamikos.com/wp-content/uploads/2021/04/Surat-jalan-1.png");
              }
            )
          ],
        );
    });
  }

  showUpload(int type) {
    // type 0 = surat jalan
    // type 1 = akta pendirian
    // type 2 = akta anggaran
    // type 3 = akta direksi
    // type 4 = ktp Direktur
    // type 5 = akta perubahan
    // type 6 = nib
    // type 7 = sertifikat standard
    // type 8 = npwp perusahaan
    // type 9 = ktp pendaftar
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 25), 
          topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 25)
        )
      ),
      backgroundColor: Colors.white,
      context: Get.context,
      builder: (context) {
        FocusManager.instance.primaryFocus.unfocus();
        FocusScope.of(context).unfocus();
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 8,
                bottom: GlobalVariable.ratioWidth(Get.context) * 18
              ),
              child: Container(
                width: GlobalVariable.ratioWidth(Get.context) * 94,
                height: GlobalVariable.ratioWidth(Get.context) * 5,
                decoration: BoxDecoration(
                  color: Color(ListColor.colorLightGrey10),
                  borderRadius: BorderRadius.all(
                    Radius.circular(GlobalVariable.ratioWidth(Get.context) * 90)
                  )
                ),
              )
            ),
            Container(
              margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: GlobalVariable.ratioWidth(context) * 64,
                        width: GlobalVariable.ratioWidth(context) * 64,
                        decoration: BoxDecoration(
                          color: Color(ListColor.colorBlue),
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                            ),
                            onTap: () {
                              Get.back();
                              getFromCamera(type);
                            },
                            child: Container(
                              padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 20),
                              child: SvgPicture.asset(
                                "assets/ic_camera_seller.svg",
                                color: Colors.white,
                                // width: GlobalVariable.ratioWidth(Get.context) * 24,
                                // height: GlobalVariable.ratioWidth(Get.context) * 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
                      CustomText(
                        "Ambil Foto",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 84),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: GlobalVariable.ratioWidth(context) * 64,
                        width: GlobalVariable.ratioWidth(context) * 64,
                        decoration: BoxDecoration(
                          color: Color(ListColor.colorBlue),
                          borderRadius:
                            BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50
                          ),
                        ),
                        child: Material(
                          borderRadius:
                              BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                            ),
                            onTap: () {
                              Get.back();
                              chooseFile(type);
                            },
                            child: Container(
                              padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 20),
                              child: SvgPicture.asset(
                                "assets/ic_upload_seller.svg",
                                color: Colors.white,
                                // width: GlobalVariable.ratioWidth(Get.context) * 24,
                                // height: GlobalVariable.ratioWidth(Get.context) * 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
                      CustomText(
                        "Upload File",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      }
    );
  }
  
  void chooseFile(int type) async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      // log("Choosen File: " + pickedFile.names.toString());
      log("Choosen File: " + pickedFile.files.first.name.toString());
      log("Choosen File: " + pickedFile.files.first.size.toString());
      log("Choosen File: " + pickedFile.files.first.extension.toString());
      log("Choosen File: " + pickedFile.files.first.path.toString());
      // file.value = File(pickedFile.files.single.path);
      file.value = File(pickedFile.files.first.path);
      startProgressBar(file.value, type);
      // viewResult(file.value, type);
    }
  }

  void getFromGallery(int type) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    _cropImage(pickedFile.path, type);
  }

  void getFromCamera(int type) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      file.value = File(pickedFile.path);
      startProgressBar(file.value, type);
      // viewResult(file.value, type);
    }
  }

  void _cropImage(filePath, int type) async {
    File croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage != null) {
      file.value = croppedImage;
      viewResult(file.value, type);
    }
  }

  double getFileSize(File file){
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    return sizeInMb;
  }

  bool isAllowedFormat(String path) {
    final mimeType = lookupMimeType(path);

    log("File mimetype: " + mimeType);
    if(mimeType.endsWith('jpg') || mimeType.endsWith('jpeg') || mimeType.endsWith('png') || mimeType.endsWith('pdf') || mimeType.endsWith('zip')){
      return true;
    }

    return false;
  }

  void viewResult(File file, int type){
    String fileName = basename(file.path).toString();
    log("File: " + fileName);
    if(getFileSize(file) > 5 && !isAllowedFormat(file.path)){
      // errorMessage.value = "Format file tidak sesuai ketentuan dan file maksimal 5MB!";
      errorMessage.value = "GlobalValidationLabelFileFormatAndSize".tr;
      log("File Error: " + errorMessage.toString());
      addToList(type, null, errorMessage.value);
    }
    else{
      if(getFileSize(file) <= 5){
        if(isAllowedFormat(file.path)){
          // log("File: " + basename(file.path));
          errorMessage.value = "";
          log("File: SAFE");
          addToList(type, file, fileName);
        }
        else{
          // errorMessage.value = "Format file Anda tidak sesuai !";
          errorMessage.value = "GlobalValidationLabelFileFormatIncorrect".tr;
          log("File Error: " + errorMessage.toString());
          addToList(type, null, errorMessage.value);
        }
      }
      else{
        // errorMessage.value = "Ukuran File melebihi batas 5MB !";
        errorMessage.value = "GlobalValidationLabelFileSize5Mb".tr;
        log("File Error: " + errorMessage.toString());
        addToList(type, null, errorMessage.value);
      }
    }
    
    log("List Surat Jalan: " + fileAkta1Result.length.toString());
    log("List Akta1: " + fileAkta1Result.length.toString());
    log("List Akta2: " + fileAkta2Result.length.toString());
    log("List Akta3: " + fileAkta3Result.length.toString());
    log("List Ktp Direktur: " + fileKtpDirekturResult.length.toString());
    log("List Akta4: " + fileAkta4Result.length.toString());
    log("List Nib: " + fileNibResult.length.toString());
    log("List Sertifikat: " + fileSertifikatResult.length.toString());
    log("List Npwp Perusahaan: " + fileNpwpPerusahaanResult.length.toString());
    log("List Ktp: " + fileKtpResult.length.toString());
    // Navigator.pop(Get.context);

    checkFormFilled(pageIndex.value);
  }

  void addToList(int type, File file, String message){
    if(type == 0){
      addToSuratJalanList(file, message);
    }
    else if(type == 1){
      addToAkta1List(file, message);
    }
    else if(type == 2){
      addToAkta2List(file, message);
    }
    else if(type == 3){
      addToAkta3List(file, message);
    } 
    else if(type == 4){
      addToKtpDirekturList(file, message);
    } 
    else if(type == 5){
      addToAkta4List(file, message);
    }
    else if(type == 6){
      addToNibList(file, message);
    } 
    else if(type == 7){
      addToSertifikatList(file, message);
    } 
    else if(type == 8){
      addToNpwpPerusahaanList(file, message);
    } 
    else if(type == 9){
      addToKtpList(file, message);
    } 

    errorMessage.value = "";
    changeIndex = -1;
  }

  void addToSuratJalanList(File file, String message) {
    if (changeIndex == -1) {
      // insert new
      if (dispatchNoteResult.length > 0) {
        // check previous
        if (dispatchNote[dispatchNote.length - 1] == null) {
          // if previous null then update previous
          changeIndex = dispatchNote.length - 1;
          dispatchNote[changeIndex] = file;
          dispatchNoteResult[changeIndex] = message;
        } else {
          // if not null then insert new
          dispatchNote.add(file);
          dispatchNoteResult.add(message);
        }
      } else {
        dispatchNote.add(file);
        dispatchNoteResult.add(message);
      }
    } else {
      // update existing
      dispatchNote[changeIndex] = file;
      dispatchNoteResult[changeIndex] = message;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dispatchNoteScrollController.animateTo(dispatchNoteScrollController.position.maxScrollExtent, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  void addToAkta1List(File file, String message){
    if(changeIndex == -1){
      // insert new
      if(fileAkta1Result.length > 0){
        // check previous
        if(fileAkta1[fileAkta1.length - 1] == null){
          // if previous null then update previous
          changeIndex = fileAkta1.length - 1;
          fileAkta1[changeIndex] = file;
          fileAkta1Result[changeIndex] = message;
        }
        else{
          // if not null then insert new
          fileAkta1.add(file);
          fileAkta1Result.add(message);
        }
      }
      else{
        fileAkta1.add(file);
        fileAkta1Result.add(message);
      }
    }
    else{
      // update existing
      fileAkta1[changeIndex] = file;
      fileAkta1Result[changeIndex] = message;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      formAkta1ScrollController.animateTo(formAkta1ScrollController.position.maxScrollExtent, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  void addToAkta2List(File file, String message){
    if(changeIndex == -1){
      // insert new
      if(fileAkta2Result.length > 0){
        // check previous
        if(fileAkta2[fileAkta2.length - 1] == null){
          // if previous null then update previous
          changeIndex = fileAkta2.length - 1;
          fileAkta2[changeIndex] = file;
          fileAkta2Result[changeIndex] = message;
        }
        else{
          // if not null then insert new
          fileAkta2.add(file);
          fileAkta2Result.add(message);
        }
      }
      else{
        fileAkta2.add(file);
        fileAkta2Result.add(message);
      }
    }
    else{
      // update existing
      fileAkta2[changeIndex] = file;
      fileAkta2Result[changeIndex] = message;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      formAkta2ScrollController.animateTo(formAkta2ScrollController.position.minScrollExtent, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  void addToAkta3List(File file, String message){
    if(changeIndex == -1){
      // insert new
      if(fileAkta3Result.length > 0){
        // check previous
        if(fileAkta3[fileAkta3.length - 1] == null){
          // if previous null then update previous
          changeIndex = fileAkta3.length - 1;
          fileAkta3[changeIndex] = file;
          fileAkta3Result[changeIndex] = message;
        }
        else{
          // if not null then insert new
          fileAkta3.add(file);
          fileAkta3Result.add(message);
        }
      }
      else{
        fileAkta3.add(file);
        fileAkta3Result.add(message);
      }
    }
    else{
      // update existing
      fileAkta3[changeIndex] = file;
      fileAkta3Result[changeIndex] = message;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      formAkta3ScrollController.animateTo(formAkta3ScrollController.position.minScrollExtent, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  void addToKtpDirekturList(File file, String message){
    // single
    if(fileKtpDirekturResult.length > 0){
      changeIndex = 0;
      fileKtpDirektur[changeIndex] = file;
      fileKtpDirekturResult[changeIndex] = message;
    }
    else{
      fileKtpDirektur.add(file);
      fileKtpDirekturResult.add(message);
    }

    isValidFileKtpDirektur.value = true;
    if(file == null){
      isValidFileKtpDirektur.value = false;
    }
  }

  void addToAkta4List(File file, String message){
    if(changeIndex == -1){
      // insert new
      if(fileAkta4Result.length > 0){
        // check previous
        if(fileAkta4[fileAkta4.length - 1] == null){
          // if previous null then update previous
          changeIndex = fileAkta4.length - 1;
          fileAkta4[changeIndex] = file;
          fileAkta4Result[changeIndex] = message;
        }
        else{
          // if not null then insert new
          fileAkta4.add(file);
          fileAkta4Result.add(message);
        }
      }
      else{
        fileAkta4.add(file);
        fileAkta4Result.add(message);
      }
    }
    else{
      // update existing
      fileAkta4[changeIndex] = file;
      fileAkta4Result[changeIndex] = message;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      formAkta4ScrollController.animateTo(formAkta4ScrollController.position.minScrollExtent, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  void addToNibList(File file, String message){
    if(changeIndex == -1){
      // insert new
      if(fileNibResult.length > 0){
        // check previous
        if(fileNib[fileNib.length - 1] == null){
          // if previous null then update previous
          changeIndex = fileNib.length - 1;
          fileNib[changeIndex] = file;
          fileNibResult[changeIndex] = message;
        }
        else{
          // if not null then insert new
          fileNib.add(file);
          fileNibResult.add(message);
        }
      }
      else{
        fileNib.add(file);
        fileNibResult.add(message);
      }
    }
    else{
      // update existing
      fileNib[changeIndex] = file;
      fileNibResult[changeIndex] = message;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      formNibScrollController.animateTo(formNibScrollController.position.minScrollExtent, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  void addToSertifikatList(File file, String message){
    if(changeIndex == -1){
      // insert new
      if(fileSertifikatResult.length > 0){
        // check previous
        if(fileSertifikat[fileSertifikat.length - 1] == null){
          // if previous null then update previous
          changeIndex = fileSertifikat.length - 1;
          fileSertifikat[changeIndex] = file;
          fileSertifikatResult[changeIndex] = message;
        }
        else{
          // if not null then insert new
          fileSertifikat.add(file);
          fileSertifikatResult.add(message);
        }
      }
      else{
        fileSertifikat.add(file);
        fileSertifikatResult.add(message);
      }
    }
    else{
      // update existing
      fileSertifikat[changeIndex] = file;
      fileSertifikatResult[changeIndex] = message;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      formSertifikatScrollController.animateTo(formSertifikatScrollController.position.minScrollExtent, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  void addToNpwpPerusahaanList(File file, String message){
    // single
    if(fileNpwpPerusahaanResult.length > 0){
      changeIndex = 0;
      fileNpwpPerusahaan[changeIndex] = file;
      fileNpwpPerusahaanResult[changeIndex] = message;
    }
    else{
      fileNpwpPerusahaan.add(file);
      fileNpwpPerusahaanResult.add(message);
    }

    isValidFileNpwpPerusahaan.value = true;
    if(file == null){
      isValidFileNpwpPerusahaan.value = false;
    }
  }

  void addToKtpList(File file, String message){
    // single
    if(fileKtpResult.length > 0){
      changeIndex = 0;
      fileKtp[changeIndex] = file;
      fileKtpResult[changeIndex] = message;
    }
    else{
      fileKtp.add(file);
      fileKtpResult.add(message);
    }

    isValidFileKtp.value = true;
    if(file == null){
      isValidFileKtp.value = false;
    }
  }

  void viewListFileItem(int type){
    if(type == 0){
      for(int i = 0; i < dispatchNote.length; i++){
        log((i+1).toString() + ". " + dispatchNote[i].toString());
      }
    }
    else if(type == 1){
      for(int i = 0; i < fileAkta1.length; i++){
        log((i+1).toString() + ". " + fileAkta1[i].toString());
      }
    }
    else if(type == 2){
      for(int i = 0; i < fileAkta2.length; i++){
        log((i+1).toString() + ". " + fileAkta2[i].toString());
      }
    }
    else if(type == 3){
      for(int i = 0; i < fileAkta3.length; i++){
        log((i+1).toString() + ". " + fileAkta3[i].toString());
      }
    } 
    else if(type == 4){
      for(int i = 0; i < fileKtpDirektur.length; i++){
        log((i+1).toString() + ". " + fileKtpDirektur[i].toString());
      }
    } 
    else if(type == 5){
      for(int i = 0; i < fileAkta4.length; i++){
        log((i+1).toString() + ". " + fileAkta4[i].toString());
      }
    }
    else if(type == 6){
      for(int i = 0; i < fileNib.length; i++){
        log((i+1).toString() + ". " + fileNib[i].toString());
      }
    } 
    else if(type == 7){
      for(int i = 0; i < fileSertifikat.length; i++){
        log((i+1).toString() + ". " + fileSertifikat[i].toString());
      }
    } 
    else if(type == 8){
      for(int i = 0; i < fileNpwpPerusahaan.length; i++){
        log((i+1).toString() + ". " + fileNpwpPerusahaan[i].toString());
      }
    } 
    else if(type == 9){
      for(int i = 0; i < fileKtp.length; i++){
        log((i+1).toString() + ". " + fileKtp[i].toString());
      }
    } 
  }

  // CHECKING IF FORM PER PAGE IS FILLED OR NOT
  void checkFormFilled(int pageIdx) {
    if(pageIdx == 1){

    }
    else if(pageIdx == 2){

    }
    else if(pageIdx == 3){
      log("File Ktp Direktur Filled: " + fileKtpDirektur.isEmpty.toString());
      log("File Ktp Direktur Valid: " + isValidFileKtpDirektur.value.toString());
      log("File Npwp Perusahaan Filled: " + fileNpwpPerusahaan.isEmpty.toString());
      log("File Npwp Perusahaan Valid: " + isValidFileNpwpPerusahaan.value.toString());
      log("File Ktp Filled: " + fileKtp.isEmpty.toString());
      log("File Ktp Valid: " + isValidFileKtp.value.toString());
      
      if(ktpDirekturController.text.isNotEmpty && npwpPerusahaanController.text.isNotEmpty && ktpController.text.isNotEmpty) {
        if(tipeBadanUsaha.value == TipeBadanUsaha.PT_CV){
          if(fileAkta1.isNotEmpty && fileAkta2.isNotEmpty && fileAkta3.isNotEmpty && fileKtpDirektur.isNotEmpty && fileNib.isNotEmpty && fileNpwpPerusahaan.isNotEmpty && fileKtp.isNotEmpty){
            if(fileAkta1[0] != null && fileAkta2[0] != null && fileAkta3[0] != null && fileKtpDirektur[0] != null && fileNib[0] != null && fileNpwpPerusahaan[0] != null && fileKtp[0] != null){
              isFilledThirdPage.value = true;
            }
            else{
              isFilledThirdPage.value = false;
            }
          }
          else{
            isFilledThirdPage.value = false;
          }
        }
        else{
          if(fileKtpDirektur.isNotEmpty && fileNib.isNotEmpty && fileNpwpPerusahaan.isNotEmpty && fileKtp.isNotEmpty){
            if(fileKtpDirektur[0] != null && fileNib[0] != null && fileNpwpPerusahaan[0] != null && fileKtp[0] != null){
              isFilledThirdPage.value = true;
            }
            else{
              isFilledThirdPage.value = false;
            }
          }
          else{
            isFilledThirdPage.value = false;
          }
        }
      }
      else {
        isFilledThirdPage.value = false;
      }
      log("Filled Third Page: " + isFilledThirdPage.value.toString());
      log("Valid Ktp Direktur: " + isValidKtpDirektur.value.toString());
      log("Valid Npwp Perusahaan: " + isValidNpwpPerusahaan.value.toString());
      log("Valid Ktp: " + isValidKtp.value.toString());
    }
  }

  // FUNCTION STARTING PROGRESS BAR
  void startProgressBar(File file, int type) {
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) async {
      Utils.checkConnection();
      if (timePerForm[type] == totalTime) {
        viewResult(file, type);
        timer.cancel();
        await Future.delayed(Duration(milliseconds: 500));
        timePerForm[type] = 0;
        ratioPerForm[type] = -1;
      } else {
        timePerForm[type]++;
        ratioPerForm[type] = (timePerForm[type]/totalTime);
      }
    });
  }

  // FUNCTION BACK FORM
  void back() {
    if(pageIndex.value == 1){
      GlobalAlertDialog.showAlertDialogCustom(
        title: "BFTMRegisterAllBatalkanPendaftaran".tr, 
        context: Get.context,
        insetPadding: 17,
        customMessage: Container(
          margin: EdgeInsets.only(
            bottom: GlobalVariable.ratioWidth(Get.context) * 16,
          ),
          child: CustomText(
            "BFTMRegisterAllConfirmation".tr,
            textAlign: TextAlign.center,
            fontSize: 14,
            height: 21 / 14,
            color: Colors.black,
            fontWeight: FontWeight.w600
          ),
        ),
        borderRadius: 12,
        labelButtonPriority1: "BFTMRegisterAllSure".tr,
        labelButtonPriority2: "BFTMRegisterAllCancel".tr,
        positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
        onTapPriority1: () {
          Get.back();
          currsession.value = true;
        }
      );
    }
    else{
      pageIndex.value == 2 ? resetCompanyData() : resetLegality();
      pageIndex.value--;
      changePageIndex(pageIndex.value);
      currsession.value = true;
    }
  }

  // FUNCTION CANCEL FORM
  void cancel() {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "BFTMRegisterAllBatalkanPendaftaran".tr, 
      context: Get.context,
      insetPadding: 17,
      customMessage: Container(
        margin: EdgeInsets.only(
          bottom: GlobalVariable.ratioWidth(Get.context) * 16,
        ),
        child: CustomText(
          "BFTMRegisterAllConfirmation".tr,
          textAlign: TextAlign.center,
          fontSize: 14,
          height: 21 / 14,
          color: Colors.black,
          fontWeight: FontWeight.w600
        ),
      ),
      borderRadius: 12,
      labelButtonPriority1: "BFTMRegisterAllSure".tr,
      labelButtonPriority2: "BFTMRegisterAllCancel".tr,
      positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
      onTapPriority1: () {
        Get.back();
        currsession.value = true;
      }
    );
  }

  // FUNCTION SUBMIT FORM
  void submit() {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "Daftar", 
      context: Get.context,
      insetPadding: 17,
      customMessage: Container(
        margin: EdgeInsets.only(
          bottom: GlobalVariable.ratioWidth(Get.context) * 16,
        ),
        child: CustomText(
          "Apakah Anda yakin data yang Anda inputkan sudah benar dan tidak ada data yang ingin diubah?",
          textAlign: TextAlign.center,
          fontSize: 14,
          height: 21 / 14,
          color: Colors.black,
          fontWeight: FontWeight.w600
        ),
      ),
      borderRadius: 12,
      labelButtonPriority1: "Batal",
      labelButtonPriority2: "Simpan",
      positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
      onTapPriority1: () {
        // Get.back();
      },
      onTapPriority2: () async {
        // CustomToastTop.show(
        //   context: Get.context, 
        //   message: "SUCCESS",
        //   isSuccess: 1
        // );
        final result = await GetToPage.toNamed<TermsAndConditionsBFTMController>(
          Routes.TERMS_AND_CONDITIONS_BFTM,
          arguments: tipeModul.value
        );
        if (result != null) {
          CustomToastTop.show(
            context: Get.context, 
            message: result,
            isSuccess: 0
          );
        }
      }
    );
  }

  // START OF DOWNLOAD FUNCTION
  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  void bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, "downloader_send_port");
    if (!isSuccess) {
      unbindBackgroundIsolate();
      bindBackgroundIsolate();
      return;
    }
    _port.listen((message) {
      onProgress.value = message[2] / 100;
      print(message[2].toString());
      if (message[2] == 100.0 && onDownloading.value) {
        onDownloading.value = false;
        if (tapDownload) {
          CustomToast.show(
            context: Get.context,
            message: "DetailTransporterLabelDownloadComplete".tr
          );
        } else {
          Share.shareFiles([filePath]);
        }
      }
    });
  }

  static void downloadCallBack(id, status, progress) {
    SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  Future<String> _findLocalPath() async {
    if (!Platform.isAndroid) {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
    return "/storage/emulated/0/";
  }

  Future downloadFile(String url) async {
    print(url);
    print(url.split(".")[url.split(".").length - 1]);
    var status = await Permission.storage.request();
    if (status.isGranted) {
      onDownloading.value = true;
      onProgress.value = 0.0;
      processing.value = true;
      var savedLocation = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
      processing.value = false;
      downloadId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: savedLocation,
        showNotification: true,
        fileName: "${DateFormat('ddMMyyyyhhmmss').format(DateTime.now())}.${url.split(".")[url.split(".").length - 1]}",
        openFileFromNotification: true
      );
    } else {
      print('Permission Denied!');
    }
  }
  // END OF DOWNLOAD FUNCTION



  // #################################
  // ##  START FUNCTION FIRST PAGE  ##
  // #################################
  Future setCapacityValidation() async {
    List<String> fileFields = [];
    List<MediaType> fileContents = [];
    for (var i = 0; i < dispatchNote.value.length; i++) {
      fileFields.add("FileSuratJalan[$i]");
      fileContents.add(MediaType.parse(lookupMimeType((dispatchNote.value[i] as File).path)));
    }
    await ApiHelper(context: Get.context, isShowDialogLoading: false, isShowDialogError: false).setShipperRegistrationInfo(
      tipeModul: tipeModul.value,
      body: tipeModul.value == TipeModul.BF ? null : {
        'LastTransporterName': transporterCompany.value.text,
        'LastTransporterPICName': transporterPICName.value.text,
        'LastTransporterPhone': transporterPICPhone.value.text
      },
      fileFields: fileFields, 
      files: dispatchNote.value.map((e) => File((e as File).path)).toList(), 
      fileContents: fileContents,
    );
  }

  void checkCompanyName(String value, {bool useToast = true}) {
    company.value = value;
    if (validateFormatCompanyName(value).isNotEmpty) {
      isTransporterCompanyValid.value = false;
      if (useToast) CustomToastTop.show(context: Get.context, message: validateFormatCompanyName(value), isSuccess: 0);
    } else {
      isTransporterCompanyValid.value = true;
    }
  }

  void checkContactName(String value, {bool useToast = true}) {
    picName.value = value;
    if (Utils.validateFormatName(value, customMin3CharsMsg: "BFTMRegisterTMNamaMinimal3".tr, customFormatMsg: "BFTMRegisterTMKontakTidakValid".tr).isNotEmpty) {
      isTransporterPICNameValid.value = false;
      if (useToast) CustomToastTop.show(context: Get.context, message: Utils.validateFormatName(value), isSuccess: 0);
    } else {
      isTransporterPICNameValid.value = true;
    }
  }

  void checkPhone(String value, {bool useToast = true}) {
    picPhone.value = value;
    if (value.length < 8) {
      isTransporterPICPhoneValid.value = false;
      if (useToast) CustomToastTop.show(context: Get.context, message: 'BFTMRegisterTMNoHpMinimal8'.tr, isSuccess: 0);
    } else {
      isTransporterPICPhoneValid.value = true;
    }
  }

  bool isCapacityValid () {
    if (tipeModul.value == TipeModul.BF) {
      return dispatchNote.where((e) => e != null).isNotEmpty;
    } else {
      return dispatchNote.where((e) => e != null).isNotEmpty && (isTransporterCompanyValid.value && company.value.isNotEmpty) && (isTransporterPICNameValid.value && picName.value.isNotEmpty) && (isTransporterPICPhoneValid.value && picPhone.value.isNotEmpty);
    }
  }

  // Future checkEmailVerif() async {
  //   log('giorno');
  //   MessageFromUrlModel message;
  //   final response = await ApiHelper(context: Get.context, isShowDialogLoading: false).isEmailVerified(email.value);
  //   message = response['Message'] != null ? MessageFromUrlModel.fromJson(response['Message']) : null;
  //   if (message != null && message.code == 200) {
  //     log('giorno21');
  //     log(message.text.toString());
  //     log(message.code.toString());
  //     log(response['Data'].toString());
  //     log('giorno12');
  //     if (response != null && response['Data'] != null) {
  //       String status = response['Data']['Status'].toString();
  //       log(status);
  //       // response['Data']['Email'] != GlobalVariable.userModelGlobal.email && 
  //       if (status != '0') {
  //         // emailCtrl.value.text = response['Data']['Email'];
  //         // GlobalVariable.userModelGlobal.email = response['Data']['Email'];
  //         // isEditable.value = response['Data']['IsVerifEmail'] == 0;   
  //         CustomToastTop.show(context: Get.context, isSuccess: 0, message: "Email telah terdaftar!");
  //         isEmailValid.value = false;
  //       }
  //       else{
  //         isEmailValid.value = true;
  //       }
  //     } else {
  //       CustomToastTop.show(message: message != null ? message.text : "Terjadi Kesalahan Server", context: Get.context, isSuccess: 0);
  //     }
  //   }
  // }

  Future validateCompanyData() async {
    MessageFromUrlModel message;
    _showDialogLoading();
    emailChanged.value = false;
    final response = await ApiHelper(context: Get.context, isShowDialogLoading: false).getEmailStatus();
    message = response['Message'] != null ? MessageFromUrlModel.fromJson(response['Message']) : null;
    if (message != null && message.code == 200) {
      if (response != null && response['Data'] != null) {
        if (response['Data']['Email'] != GlobalVariable.userModelGlobal.email || response['Data']['IsVerifEmail'].toString() != isverif.value) {
          _closeDialogLoading();
          emailChanged.value = true;
          GlobalAlertDialog.showAlertDialogCustom(
            title: 'BFTMRegisterAllPerubahanData'.tr, 
            message: 'BFTMRegisterAllPerubahanDataPendaftaran'.tr,
            context: Get.context,
            labelButtonPriority1: 'BFTMRegisterAllKembaliKePendaftaran'.tr,
            heightButton1: 31,
            widthButton1: 203,
            positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
            onTapPriority1: () {
              emailCtrl.value.text = response['Data']['Email'];
              isEditable.value = response['Data']['IsVerifEmail'] == 0;   
              GlobalVariable.userModelGlobal.email = response['Data']['Email'];
              isverif.value = response['Data']['IsVerifEmail'].toString();            
            }
          );
        } else {
          final result = await setCompanyData();
          _closeDialogLoading();
          if (result['Message']['Code'] != 200) {
            isEmailValid.value = true;
            isNamaPerusahaanValid.value = true;
            isNoTelpValid.value = true;
            if (result['Data']['Fields'] == "email") {
              isEmailValid.value = false;
              return;
            }
            if (result['Data']['Fields'] == "company_name") {
              isNamaPerusahaanValid.value = false;
              return;
            }
            if (result['Data']['Fields'] == "company_phone") {
              isNoTelpValid.value = false;
              return;
            }
            CustomToastTop.show(context: Get.context, isSuccess: 0, message: response['Data']['Message']);
            Get.back();
            emailCtrl.value.text = response['Data']['Email'];
            isEditable.value = response['Data']['IsVerifEmail'] == 0;   
            GlobalVariable.userModelGlobal.email = response['Data']['Email'];
            isverif.value = response['Data']['IsVerifEmail'].toString();
          }
        }
      } else {
        CustomToastTop.show(message: message != null ? message.text : "Terjadi Kesalahan Server", context: Get.context, isSuccess: 0);
      }
    }
  }
  
  void _closeDialogLoading() {
    try {
      if (_isShowingDialogLoading) {
        _isShowingDialogLoading = false;
        Get.back();
      }
    } catch (err) {}
  }

  Future _showDialogLoading() async {
    _isShowingDialogLoading = true;
    return showDialog(
      context: Get.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            backgroundColor: Colors.black54,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    CustomText('GlobalLabelDialogLoading'.tr, color: Colors.blueAccent)
                  ]
                ),
              )
            ]
          )
        );
      }
    );
  }

  String validateFormatCompanyName(String value) {
    if (value.length < 3) return "Nama perusahaan minimal 3 karakter!".tr;
    if (!RegExp(r"^[A-Za-z0-9_]").hasMatch(value)) return "BFTMRegisterTMNamaTidakValid".tr;
    return "";
  }
  // ###############################
  // ##  END FUNCTION FIRST PAGE  ##
  // ###############################



  // #################################
  // ##  START FUNCTION SECOND PAGE ##
  // #################################
  Future setCompanyData() async {
    return await ApiHelper(context: Get.context, isShowDialogLoading: false, isShowDialogError: false).setShipperRegistrationCompanyData(
      // PENYESUAIAN REFO
      tipeModul: tipeModul.value,
      body: {
        'Email': email.value,
        'CompanyLogo': Utils.base64Image(file.value),
        'CompanyName': namaPerusahaanValue.value,
        'BusinessEntityId': pilihBidangUsaha.value,
        'BusinessFieldId': pilihBadanUsaha.value,
        'CompanyAddress': lokasiakhir.value,
        'AddressDetail': alamatPerusahaanValue.value,
        'CompanyDistrictId': companydistrictid.value,
        'CompanyProvinceId': "1",
        'CompanyCityId': "1",
        'CompanyPostalCode': kodepos.value,
        'Lat': "-7.389789",
        'Long': "112.789789",
        'CompanyPhone': noTelpPerusahaan.value,
        'Pic1Name': namaPIC1.text,
        'Pic1Phone': noHpPIC1.text,
        'Pic2Name': namaPIC2.text,
        'Pic2Phone': noHpPIC2.text,
        'Pic3Name': namaPIC3.text,
        'Pic3Phone': noHpPIC3.text,
      }
    );
  }

  void resetCompanyData() {
    // Hilangkan semua data di form data perusahaan
    // picturefilllogo.value = false;
    // filelogo.value = File("");
    // namaPerusahaanC.text = "";
    // namaPerusahaanValue.value = "";
    // badan.value = "";
    // pilihBadanUsaha.value = "";
    // businessFieldController.value.text = "";
    // pilihBidangUsaha.value = "";
    // lokasiakhir.value = "";
    // kecamatanPerusahaanText.value = "";
    // alamatPerusahaanC.text = "";
    // alamatPerusahaanValue.value = "";
    // districtController.value.text = "";
    // kecamatanPerusahaanText.value = "";
    // pilihKodePos.value = "";
    // kodepos.value = "";
    // noTelp.text = "";
    // noTelpPerusahaan.value = "";
    // namaPIC1.text = "";
    // namaPic1Value.value = "";
    // noHpPIC1.text = "";
    // namaPIC2.text = "";
    // namaPic2Value.value = "";
    // noHpPIC2.text = "";
    // namaPIC3.text = "";
    // namaPic3Value.value = "";
    // noHpPIC3.text = "";
    // emailCtrl.value.text = email.value;
  }

    void onClickAddresss(String type) async {
    var map = {};
    var total = 1;
    if (type == "lokasi") {
      total = int.parse(totalLokasi.value);
      namaLokasi.keys.forEach((key) {
        map[key] = {
          "Nama": namaLokasi[key],
          "Lokasi": latlngLokasi[key],
          "City": cityLokasi[key],
          "District": districtLokasi[key]
        };
      });
    } else {
      total = int.parse(totalDestinasi.value);
      namaDestinasi.keys.forEach((key) {
        map[key] = {
          "Nama": namaDestinasi[key],
          "Lokasi": latlngDestinasi[key],
          "City": cityDestinasi[key],
          "District": districtDestinasi[key]
        };
      });
    }
    var result = await GetToPage.toNamed<LokasiBFTMController>(
        Routes.LOKASI_BF_TM,
        arguments: [type, map, total, '', false, 'search']);
    // var result = await GetToPage.toNamed<SelectListLokasiController>(
    //     Routes.SELECT_LIST_LOKASI,
    //     arguments: [type, map, total]);
    // print(result + 'diavolo');
    // print('diavolo 00');
    if (result != null) {
      // print('diavolo 11');
      // print(result[1].toString() + 'refooikura');
      distid.value = "";
      placeidd.value = result[1];
      // print('diavolo 22');
      if (type == "lokasi") {
        // print('refoo masuk');
        namaLokasi.clear();
        latlngLokasi.clear();
        cityLokasi.clear();
        districtLokasi.clear();
      } else {
        namaDestinasi.clear();
        latlngDestinasi.clear();
        cityDestinasi.clear();
        districtDestinasi.clear();
      }
      var markerBounds = LatLngBounds();
      (result[0] as Map).keys.forEach((key) {
        // print(latlngLokasi[key] + ' refo');
        if (type == "lokasi") {
          namaLokasi[key] = result[0][key]["Nama"];
          latlngLokasi[key] = result[0][key]["Lokasi"];
          cityLokasi[key] = result[0][key]["City"];
          districtLokasi[key] = result[0][key]["District"];
        } else {
          namaDestinasi[key] = result[0][key]["Nama"];
          latlngDestinasi[key] = result[0][key]["Lokasi"];
          cityDestinasi[key] = result[0][key]["City"];
          districtDestinasi[key] = result[0][key]["District"];
        }
        markerBounds.extend(result[0][key]["Lokasi"]);
      });
      if (markerBounds.isValid) {
        currmarker.value = markerBounds;
        // print(type + 'gf');
        updateMapp(type, markerBounds);
      }
      namaLokasi.refresh();
      // print(namaLokasi.values.toString() +'ikura');
      // print(namaLokasi.values.toString().replaceAll("(", " ")+'ikura');
      // print(namaLokasi.values.toString().substring(1,namaLokasi.values.toString().length -1)+'ikura');
      lokasiakhir.value = (namaLokasi.values.toString().substring(1,namaLokasi.values.toString().length -1));
      print(lokasiakhir+' ikura');
      print(latlngDestinasi.toString());
      // print(latlngLokasi.toString().substring(20)+' ikura');
      int index = lokasiakhir.indexOf(',');
      namalokasiakhir.value = lokasiakhir.substring(0,index).trim();
      alamatlokasiakhir.value = lokasiakhir.substring(index+1).trim();
      checkAllFieldIsFilled();
      print(namalokasiakhir+' ikura');
      print(alamatlokasiakhir+' ikura');
  // var namalokasiakhir = " ".obs;
  // var alamatlokasiakhir
    }
  }

  void onClickAddressMap(String type) async {
    var map = {};
    var total = 1;
    if (type == "lokasi") {
      total = int.parse(totalLokasi.value);
      namaLokasi.keys.forEach((key) {
        map[key] = {
          "Nama": namaLokasi[key],
          "Lokasi": latlngLokasi[key],
          "City": cityLokasi[key],
          "District": districtLokasi[key]
        };
      });
    } else {
      total = int.parse(totalDestinasi.value);
      namaDestinasi.keys.forEach((key) {
        map[key] = {
          "Nama": namaDestinasi[key],
          "Lokasi": latlngDestinasi[key],
          "City": cityDestinasi[key],
          "District": districtDestinasi[key]
        };
      });
    }
    var result = await GetToPage.toNamed<LokasiBFTMController>(
      Routes.LOKASI_BF_TM,
      arguments: [type, map, total, '', false, 'map']
    );
    if (result != null) {
      print('diavolo 11');
      print(result[1].toString() + 'refooikura');
      placeidd.value = result[1];
      print('diavolo 22');
      if (type == "lokasi") {
        print('refoo masuk');
        namaLokasi.clear();
        latlngLokasi.clear();
        cityLokasi.clear();
        districtLokasi.clear();
      } else {
        namaDestinasi.clear();
        latlngDestinasi.clear();
        cityDestinasi.clear();
        districtDestinasi.clear();
      }
      var markerBounds = LatLngBounds();
      (result[0] as Map).keys.forEach((key) {
        if (type == "lokasi") {
          namaLokasi[key] = result[0][key]["Nama"];
          latlngLokasi[key] = result[0][key]["Lokasi"];
          cityLokasi[key] = result[0][key]["City"];
          districtLokasi[key] = result[0][key]["District"];
        } else {
          namaDestinasi[key] = result[0][key]["Nama"];
          latlngDestinasi[key] = result[0][key]["Lokasi"];
          cityDestinasi[key] = result[0][key]["City"];
          districtDestinasi[key] = result[0][key]["District"];
        }
        markerBounds.extend(result[0][key]["Lokasi"]);
      });
      if (markerBounds.isValid) {
        currmarker.value = markerBounds;
        updateMapp(type, markerBounds);
      }
      namaLokasi.refresh();
      // print(namaLokasi.values.toString() +'ikura');
      // print(namaLokasi.values.toString().replaceAll("(", " ")+'ikura');
      // print(namaLokasi.values.toString().substring(1,namaLokasi.values.toString().length -1)+'ikura');
      lokasiakhir.value = (namaLokasi.values.toString().substring(1,namaLokasi.values.toString().length -1));
      print(lokasiakhir+' ikura');
      // print(latlngLokasi.toString().substring(20)+' ikura');
      int index = lokasiakhir.indexOf(',');
      namalokasiakhir.value = lokasiakhir.substring(0,index).trim();
      alamatlokasiakhir.value = lokasiakhir.substring(index+1).trim();
      checkAllFieldIsFilled();
      print(namalokasiakhir+' ikura');
      print(alamatlokasiakhir+' ikura');
  // var namalokasiakhir = " ".obs;
  // var alamatlokasiakhir
    }
    // if (result != null) {
    //   if (type == "lokasi") {
    //     namaLokasi.clear();
    //     latlngLokasi.clear();
    //     cityLokasi.clear();
    //     districtLokasi.clear();
    //   } else {
    //     namaDestinasi.clear();
    //     latlngDestinasi.clear();
    //     cityDestinasi.clear();
    //     districtDestinasi.clear();
    //   }
    //   var markerBounds = LatLngBounds();
    //   (result as Map).keys.forEach((key) {
    //     if (type == "lokasi") {
    //       namaLokasi[key] = result[key]["Nama"];
    //       latlngLokasi[key] = result[key]["Lokasi"];
    //       cityLokasi[key] = result[key]["City"];
    //       districtLokasi[key] = result[key]["District"];
    //     } else {
    //       namaDestinasi[key] = result[key]["Nama"];
    //       latlngDestinasi[key] = result[key]["Lokasi"];
    //       cityDestinasi[key] = result[key]["City"];
    //       districtDestinasi[key] = result[key]["District"];
    //     }
    //     markerBounds.extend(result[key]["Lokasi"]);
    //   });
    //   if (markerBounds.isValid) {
    //     updateMapp(type, markerBounds);
    //   }
    //   namaLokasi.refresh();
    //   lokasiakhir.value = (namaLokasi.values.toString().substring(1,namaLokasi.values.toString().length -1));
    //   int index = lokasiakhir.indexOf(',');
    //   namalokasiakhir.value = lokasiakhir.substring(0,index).trim();
    //   alamatlokasiakhir.value = lokasiakhir.substring(index+1).trim();
    // }
  }

  void updateMapp(String type, LatLngBounds markerBounds) async {
    if (type == "lokasi") {
      // print(markerBounds.toString() + 'gf 2');
      // print('gf 2');
      await mapLokasiController.onReady;
      mapLokasiController.fitBounds(markerBounds,
          options: FitBoundsOptions(padding: EdgeInsets.all(20)));
    } else {
      await mapDestinasiController.onReady;
      mapDestinasiController.fitBounds(markerBounds,
          options: FitBoundsOptions(padding: EdgeInsets.all(20)));
    }
  }

  void onClickSetPositionMarker() async {
    var result = await GetToPage.toNamed<PetaBFTMController>(
        Routes.PETA_BF_TM               ,
        arguments: {
          PetaBFTMController.latLngKey: _latLngFromArgms,
          PetaBFTMController.imageMarkerKey:
              Stack(alignment: Alignment.topCenter, children: [
            //  totalMarker.value == 1 && numberOfMarker == "1" ?
            Image.asset(
              'assets/pin_new.png',
              width: GlobalVariable.ratioWidth(Get.context) * 29.56,
              height: GlobalVariable.ratioWidth(Get.context) * 36.76,
            ),
            // SvgPicture.asset(
            //   totalMarker.value == 1
            //       ? "assets/pin_truck_icon.svg"
            //       : numberOfMarker == "1"
            //           ? "assets/pin_yellow_icon.svg"
            //           : "assets/pin_blue_icon.svg",
            //   width: GlobalVariable.ratioWidth(Get.context) * 22,
            //   height: GlobalVariable.ratioWidth(Get.context) * 29,
            // ),
            Container(
              margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 7),
              child: CustomText(totalMarker.value == 1 ? "" : numberOfMarker,
                  color: numberOfMarker != "1"
                      ? Colors.white
                      : Color(ListColor.color4),
                  fontWeight: FontWeight.w700,
                  fontSize: 10),
            )
          ]),
        });
    if (result != null) {
      _getDataInfoFromAddressPlaceID(address: result[1]);
      // _getBackWithResult(
      //   result[1],
      //   result[0],
      // );
    }
  }

  Future _getDataInfoFromAddressPlaceID(
      {@required String address, String placeID}) async {
    InfoFromAddressResponseModel response =
        await GetInfoFromAddressPlaceID.getInfo(
            address: placeID != null ? null : address, placeID: placeID);
    _addToSharedPref(AddressGoogleInfoPermintaanMuatModel(
        addressAutoComplete: AddressGooglePlaceAutoCompleteModel(
            description: address, placeId: placeID),
        addressDetails: AddressGooglePlaceDetailsModel(
            formattedAddress: address,
            latLng: LatLng(response.latitude, response.longitude),
            cityName: response.city,
            districtName: response.district)));
    if (response != null) {
      _getBackWithResult(
          address,
          LatLng(
            response.latitude,
            response.longitude,
          ),
          response.district,
          response.city);
    }
  }

  void _getBackWithResult(
      String address, LatLng latLng, String district, String city) {
    onClearSearch();
    Get.back(result: [address, latLng, district, city]);
  }

  final searchTextEditingController = TextEditingController().obs;
  final listSearchAddress = [].obs;
  final isSearchMode = false.obs;
  final isSearchingData = false.obs;
  SearchAddressGoogleFunction _searchAddressGoogleFunction;


  void onClearSearch() {
    searchTextEditingController.value.text = "";
    addTextSearch("");
  }

  void addTextSearch(String value) {
    listSearchAddress.clear();
    if (value == "") {
      listSearchAddress.addAll(_listSearchAddressTemp);
    }
    isSearchMode.value = value != "";
    isSearchingData.value = value != "";
    _searchAddressGoogleFunction.addTextCity(value);
  }

   void _addToSharedPref(AddressGoogleInfoPermintaanMuatModel data) {
    if (_listSearchAddressTemp.length > 0) {
      for (int i = 0; i < _listSearchAddressTemp.length; i++) {
        if (_listSearchAddressTemp[i]
                .addressAutoComplete
                .description
                .toLowerCase() ==
            data.addressAutoComplete.description.toLowerCase()) {
          _listSearchAddressTemp.removeAt(i);
          break;
        }
      }
    }
    _listSearchAddressTemp.insert(
        0, AddressGoogleInfoPermintaanMuatModel.copyData(data));
    if (_listSearchAddressTemp.length > 3)
      _listSearchAddressTemp.removeAt(_listSearchAddressTemp.length - 1);
    SharedPreferencesHelper.setHistorySearchLocationInfoPermintaanMuat(
        jsonEncode(_listSearchAddressTemp));
  }

var selectLokasi = Map().obs;
final String namaKey = "Nama";
  final String lokasiKey = "Lokasi";
  final String cityKey = "City";
  final String districtKey = "District";

  

void onClickAddress(int index) async {
    String addressName = selectLokasi[index.toString()] != null
        ? selectLokasi[index.toString()][namaKey] ?? ""
        : "";
    LatLng latLng = selectLokasi[index.toString()] != null
        ? selectLokasi[index.toString()][lokasiKey]
        : null;
    var result = await Get.toNamed(Routes.SEARCH_LOCATION_BF_TM,
        arguments: [
          (index + 1).toString(),
          totalLokasi,
          addressName,
          latLng,
        ]);
    if (result != null) {
      if (selectLokasi[index.toString()] != null)
        selectLokasi.remove(index.toString());
      selectLokasi[index.toString()] = _setMapLokasi(result[0] as String,
          result[1] as LatLng, result[2] as String, result[3] as String);
      updateMap();
      // totalLokasi.refresh();
    }
  }

  dynamic _setMapLokasi(
      String nama, LatLng lokasi, String city, String district) {
    return {
      namaKey: nama,
      lokasiKey: lokasi,
      cityKey: city,
      districtKey: district
    };
  }

  void updateMap() async {
    await mapController.onReady;
    var markerBounds = LatLngBounds();
    selectLokasi.values.forEach((element) {
      markerBounds.extend(element["Lokasi"]);
    });
    if (markerBounds.isValid) {
      mapController.fitBounds(markerBounds,
          options: FitBoundsOptions(padding: EdgeInsets.all(40)));
    }
  }

  checkCategory() {
    var bool = kategoriData.where((e) => e['IsSpecialLegal'] == 1).isNotEmpty;
    log('$bool');
    if (bool == true) {
      log('WITH LEGAL');
      isSpecialLegal.value = true;
    } else {
      log('WITHOUT LEGAL');
      isSpecialLegal.value = false;
      // GetToPage.offAllNamed<LegalitasNormalController>(
      //     Routes.SUCCESS_REGISTER_SELLER_WITHOUT_LEGALITY);
    }
  }

  //  void updateMap(String type, LatLngBounds markerBounds) async {
  //   if (type == "lokasi") {
  //     await mapLokasiController.onReady;
  //     mapLokasiController.fitBounds(markerBounds,
  //         options: FitBoundsOptions(padding: EdgeInsets.all(20)));
  //   } else {
  //     await mapDestinasiController.onReady;
  //     mapDestinasiController.fitBounds(markerBounds,
  //         options: FitBoundsOptions(padding: EdgeInsets.all(20)));
  //   }
  // }

  // PENYESUAIAN REFO
  // Future showUpload() {
  //   // type 1 = npwp
  //   // type 2 = ktp
  //   // type 3 = nib
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       enableDrag: true,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(25), topRight: Radius.circular(25))),
  //       backgroundColor: Colors.white,
  //       context: Get.context,
  //       builder: (context) {
  //         return Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Container(
  //                 margin: EdgeInsets.only(
  //                     top: GlobalVariable.ratioHeight(Get.context) * 8,
  //                     bottom: GlobalVariable.ratioHeight(Get.context) * 18),
  //                 child: Container(
  //                   width: GlobalVariable.ratioHeight(Get.context) * 94,
  //                   height: GlobalVariable.ratioHeight(Get.context) * 5,
  //                   decoration: BoxDecoration(
  //                       color: Color(ListColor.colorLightGrey10),
  //                       borderRadius: BorderRadius.all(Radius.circular(90))),
  //                 )),
  //             Container(
  //               margin: EdgeInsets.only(
  //                   bottom: GlobalVariable.ratioWidth(Get.context) * 24),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                         height: GlobalVariable.ratioWidth(context) * 64,
  //                         width: GlobalVariable.ratioWidth(context) * 64,
  //                         decoration: BoxDecoration(
  //                           color: Color(ListColor.colorBlue),
  //                           borderRadius: BorderRadius.circular(
  //                               GlobalVariable.ratioWidth(context) * 50),
  //                         ),
  //                         child: Material(
  //                           borderRadius: BorderRadius.circular(
  //                               GlobalVariable.ratioWidth(context) * 50),
  //                           color: Colors.transparent,
  //                           child: InkWell(
  //                             customBorder: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(
  //                                   GlobalVariable.ratioWidth(context) * 50),
  //                             ),
  //                             onTap: () async {
  //                               await getFromCamera();
  //                               // Get.back();
  //                               checkAllFieldIsFilled();
  //                             },
  //                             child: Container(
  //                               padding: EdgeInsets.all(
  //                                   GlobalVariable.ratioWidth(Get.context) *
  //                                       20),
  //                               child: SvgPicture.asset(
  //                                 "assets/ic_camera_seller.svg",
  //                                 color: Colors.white,
  //                                 // width: GlobalVariable.ratioWidth(Get.context) * 24,
  //                                 // height: GlobalVariable.ratioWidth(Get.context) * 24,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: GlobalVariable.ratioWidth(Get.context) * 16,
  //                       ),
  //                       CustomText(
  //                         "Ambil Foto",
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w600,
  //                         color: Colors.black,
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     width: GlobalVariable.ratioWidth(Get.context) * 84,
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                         height: GlobalVariable.ratioWidth(context) * 64,
  //                         width: GlobalVariable.ratioWidth(context) * 64,
  //                         decoration: BoxDecoration(
  //                           color: Color(ListColor.colorBlue),
  //                           borderRadius: BorderRadius.circular(
  //                               GlobalVariable.ratioWidth(context) * 50),
  //                         ),
  //                         child: Material(
  //                           borderRadius: BorderRadius.circular(
  //                               GlobalVariable.ratioWidth(context) * 50),
  //                           color: Colors.transparent,
  //                           child: InkWell(
  //                             customBorder: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(
  //                                   GlobalVariable.ratioWidth(context) * 50),
  //                             ),
  //                             onTap: () async {
  //                               // getFromGallery(type);
  //                               await chooseFile();
  //                               // Get.back();
  //                               checkAllFieldIsFilled();
  //                             },
  //                             child: Container(
  //                               padding: EdgeInsets.all(
  //                                   GlobalVariable.ratioWidth(Get.context) *
  //                                       20),
  //                               child: SvgPicture.asset(
  //                                 "assets/ic_upload_seller.svg",
  //                                 color: Colors.white,
  //                                 // width: GlobalVariable.ratioWidth(Get.context) * 24,
  //                                 // height: GlobalVariable.ratioWidth(Get.context) * 24,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: GlobalVariable.ratioWidth(Get.context) * 16,
  //                       ),
  //                       CustomText(
  //                         "Upload File",
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w600,
  //                         color: Colors.black,
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

  // void getFromGallery(int type) async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   _cropImage(pickedFile.path);
  // }
  // Future<void> getFromCamera() async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     // file.value = File(pickedFile.path);
  //     // await viewResult(file.value);
  //   }
  // }

  // Future<void> _cropImage(filePath) async {
  //   isSuccessUpload.value = false;
  //   fileDisplay.value.delete();

  //   // final fileResult = await GetToPage.toNamed<UploadLogoPerusahaanController>(
  //   //     Routes.UPLOAD_LOGO_PERUSAHAAN,
  //   //     arguments: filePath);
  //   // if (fileResult != null) {
  //   //   print("FILE RESULT :: $fileResult");
  //   //   fileDisplay.value = fileResult;
  //   //   isSuccessUpload.value = true;
  //   //   log("FILE VAL :: ${file.value}");
  //   // } else {
  //   //   isSuccessUpload.value = false;
  //   //   log("FILE VAL :: ${file.value}");
  //   // }
  // }

  // Future<double> getFileSize(File file) async {
  //   int sizeInBytes = file.lengthSync();
  //   double sizeInMb = sizeInBytes / (1024 * 1024);

  //   return sizeInMb;
  // }

  // Future<bool> isAllowedFormat(String path) async {
  //   final mimeType = lookupMimeType(path);

  //   log("File mimetype: " + mimeType);
  //   if (mimeType.endsWith('jpg') ||
  //       mimeType.endsWith('jpeg') ||
  //       mimeType.endsWith('png')) {
  //     return true;
  //   }

  //   return false;
  // }

  // Future<void> chooseFile() async {
  //   FilePickerResult pickedFile =
  //       await FilePicker.platform.pickFiles(type: FileType.image);
  //   if (pickedFile != null) {
  //     // log("Choosen File: " + pickedFile.names.toString());
  //     log("Choosen File: " + pickedFile.files.first.name.toString());
  //     log("Choosen File: " + pickedFile.files.first.size.toString());
  //     log("Choosen File: " + pickedFile.files.first.extension.toString());
  //     log("Choosen File: " + pickedFile.files.first.path.toString());
  //     // file.value = File(pickedFile.files.single.path);
  //     // file.value = File(pickedFile.files.first.path);
  //     // _cropImage(file.value);
  //     // await viewResult(file.value);
  //   }
  // }

  // Future<void> viewResult(File file) async {
  //   Get.back();
  //   String fileName = basename(file.path).toString();
  //   log("File: " + fileName);
  //   if (await getFileSize(file) <= 5) {
  //     if (await isAllowedFormat(file.path)) {
  //       // log("File: " + basename(file.path));
  //       log("File: SAFE");
  //       // addToList(type, file, fileName);
  //       await _cropImage(file);
  //     } else {
  //       errorMessage.value = "Format file Anda tidak sesuai!";
  //       CustomToastTop.show(
  //           context: Get.context, isSuccess: 0, message: errorMessage.value);
  //       file.writeAsString('');
  //       update();
  //       // log("File: " + errorMessage.toString());
  //       // addToList(type, null, errorMessage.value);
  //       return;
  //     }
  //   } else {
  //     errorMessage.value = "Ukuran File melebihi batas 5MB !";
  //     CustomToastTop.show(
  //         context: Get.context, isSuccess: 0, message: errorMessage.value);
  //     file.writeAsString('');
  //     update();

  //     return;
  //     // log("File: " + errorMessage.toString());
  //     // addToList(type, null, errorMessage.value);
  //   }
  //   // Navigator.pop(Get.context);
  // }

  checkAllFieldIsFilled() {
    if (namaPerusahaanValue.value != "" &&
            // pilihBadanUsaha.value != null &&
            pilihBidangUsaha.value != null && 
            // districtController.value != "" &&
        //     fileDisplay.value.path != "" ||
        // fileDisplay.value.path.isEmpty &&
            // alamatPerusahaanValue.value != "" &&
            kecamatanPerusahaanText.value != "" &&
            pilihKodePos.value != null &&
            namaPic1Value.value != "" &&
            email.value != "" &&
            noTelpPerusahaan.value != "" &&
            naoPic1Value.value != "" &&
            picturefilllogo.value != false &&
            lokasiakhir.value != " "
            ) {
      isFilled.value = true;
    } else {
      isFilled.value = false;
    }
    log('VALID : (${isValid.value}) ' +
        'FIELD ' +
        '(${isFilled.value})  \n' +
        ' Fotonya : ${picturefilllogo.value}' +
        ' ID DISTRICT : ${companydistrictid.value}' +
        ' Nama Usaha : ${namaPerusahaanValue.value}' +
        ', Badan Usaha : ${pilihBidangUsaha.value}' +
        ', Bidang Usaha : ${pilihBadanUsaha.value}' +
        ', Alamat : ' '${alamatPerusahaanC.text}' +
        ', Kecamatan : ${kecamatanPerusahaanText.value}' +
        ', Logo : ${fileDisplay.value.path}' +
        ', KodePos : ${kodepos.value}' +
        ', Kota : ${cityStoreArg.value}' +
        ', Prov : ${provinceStoreArg.value}' +
        ', NamaPIC1 : ${namaPIC1.text}' +
        ', NoPIC1 : ${noHpPIC1.text}' +
        ', NamaPIC2 : ${namaPIC2.text}' +
        ', NoPIC2 : ${noHpPIC2.text}' +
        ', NamaPIC3 : ${namaPIC2.text}' +
        ', Email : ${email.value}' +
        ', NoHpPIC3 : ${noHpPIC3.text}');
  }

  checkNamleField(String value) {
    if (value == "" || value.isEmpty || value.length.isLowerThan(3)) {
      CustomToastTop.show(
          message: "Nama PIC minimal 3 karakter!",
          context: Get.context,
          isSuccess: 0);
      isNamaPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      return;
    }

    if (!value.contains(RegExp(r"[a-zA-Z0-9.' ]")) || value.isNumericOnly) {
      CustomToastTop.show(
          message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
      isNamaPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      var start = value[0];
      if (value.endsWith(start)) {
        CustomToastTop.show(
            message: "Nama PIC tidak valid!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic1Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }
  }

  checkNamleField2(String value) {
    if (value == "" || value.isEmpty || value.length.isLowerThan(3)) {
      CustomToastTop.show(
          message: "Nama PIC minimal 3 karakter!",
          context: Get.context,
          isSuccess: 0);
      isNamaPic2Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      return;
    }

    if (!value.contains(RegExp(r"[a-zA-Z0-9.' ]")) || value.isNumericOnly) {
      CustomToastTop.show(
          message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
      isNamaPic2Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      var start = value[0];
      if (value.endsWith(start)) {
        CustomToastTop.show(
            message: "Nama PIC tidak valid!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }
  }

  pickContact1() async {
    isNamaPic1Valid.value = true;
    isNoPic1Valid.value = true;
    if (await checkAppPermissionContact() == PermissionStatus.granted) {
      // JIKA GRANTED
      Contact contactPicked = await contactPicker.selectContact();
      if (contactPicked != null) {
        var namaPicked = contactPicked.fullName.toString();
        namaPic1Value.value = namaPicked;
        namaPIC1.text = namaPic1Value.value;
        var noPicked = contactPicked.phoneNumber.number.toString();
        noPicked = noPicked.replaceAll('+', "");
        noPicked = noPicked.replaceAll('-', "");
        noPicked = noPicked.replaceAll(' ', "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+ )'), "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+?0[0-9]{14}$'), "");
        naoPic1Value.value = noPicked;
        noHpPIC1.text = naoPic1Value.value;
        checkNamleField(namaPic1Value.value);
        log('NUMBER: ${naoPic1Value.value}----${naoPic1Value.value.length} ');
      }

      // LAKUKAN APA

    }
  }

  pickContact2() async {
    isNamaPic2Valid.value = true;
    isNoPic2Valid.value = true;
    if (await checkAppPermissionContact() == PermissionStatus.granted) {
      // JIKA GRANTED
      Contact contactPicked = await contactPicker.selectContact();
      if (contactPicked != null) {
        var namaPicked = contactPicked.fullName.toString();
        namaPic2Value.value = namaPicked;
        namaPIC2.text = namaPic2Value.value;
        var noPicked = contactPicked.phoneNumber.number.toString();
        noPicked = noPicked.replaceAll('+', "");
        noPicked = noPicked.replaceAll('-', "");
        noPicked = noPicked.replaceAll(' ', "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+ )'), "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+?0[0-9]{14}$'), "");
        naoPic2Value.value = noPicked;
        noHpPIC2.text = naoPic2Value.value;
        checkNamleField2(namaPic2Value.value);
        log('NUMBER: ${naoPic2Value.value}----${naoPic2Value.value.length} ');
      }

      // LAKUKAN APA

    }
  }

  pickContact3() async {
    isNamaPic3Valid.value = true;
    isNoPic3Valid.value = true;
    if (await checkAppPermissionContact() == PermissionStatus.granted) {
      // JIKA GRANTED
      Contact contactPicked = await contactPicker.selectContact();
      if (contactPicked != null) {
        var namaPicked = contactPicked.fullName.toString();
        namaPic3Value.value = namaPicked;
        namaPIC3.text = namaPic3Value.value;
        var noPicked = contactPicked.phoneNumber.number.toString();
        noPicked = noPicked.replaceAll('+', "");
        noPicked = noPicked.replaceAll('-', "");
        noPicked = noPicked.replaceAll(' ', "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+ )'), "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+?0[0-9]{14}$'), "");
        naoPic3Value.value = noPicked;
        noHpPIC3.text = naoPic3Value.value;
        checkNamleField3(namaPic3Value.value);
        log('NUMBER: ${naoPic3Value.value}----${naoPic3Value.value.length} ');
      }

      // LAKUKAN APA

    }
  }

  checkNamleField3(String value) {
    if (value == "" || value.isEmpty || value.length.isLowerThan(3)) {
      CustomToastTop.show(
          message: "Nama PIC minimal 3 karakter!",
          context: Get.context,
          isSuccess: 0);
      isNamaPic3Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      return;
    }

    if (!value.contains(RegExp(r"[a-zA-Z0-9.' ]")) || value.isNumericOnly) {
      CustomToastTop.show(
          message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
      isNamaPic3Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      var start = value[0];
      if (value.endsWith(start)) {
        CustomToastTop.show(
            message: "Nama PIC tidak valid!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }
  }

  Future<PermissionStatus> checkAppPermissionContact() async {
    //CEK STATUS PERMISSION
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      //JIKA TIDAK DISETUJUI / DITOLAK
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request(); //REQUEST PERMISION
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission; //RETURN CONTACT PERMISSIOn
    }
  }

  getBadanUsaha() async {
    // postalCodeUsahaList.clear();
    // pilihBadanUsaha.value = null;
    var result = await ApiHelper(
            context: Get.context,
            isDebugGetResponse: true,
            isShowDialogLoading: false)
        .getBusinessField();
    badanUsahaList.value = result == null ? [] : result['Data'];
    print(badanUsahaList);
  }

  getBidangUsaha() async {
    // postalCodeUsahaList.clear();
    pilihBidangUsaha.value = null;
    var result = await ApiHelper(
            context: Get.context,
            isDebugGetResponse: true,
            isShowDialogLoading: false)
        .getBusinessEntity();
    bidangUsahaList.value = result == null ? [] : result['Data'];
    print(bidangUsahaList);
  }

  direct() async {
    if (isSpecialLegal.value == true) {
      // GetToPage.offAllNamed<LegalitasKhususController>(
      //   Routes.SUCCESS_REGISTER_SELLER_WITH_LEGALITY,
      // );
    } else {
      // await GetToPage.offAllNamed<LegalitasNormalController>(
      //   Routes.SUCCESS_REGISTER_SELLER_WITHOUT_LEGALITY,
      //   arguments: kategoriData,
      // );
    }
  }

  submitPendaftaran() async {
    // var parameter = {
    //   "name": namaPerusahaanValue.value,
    //   "address": alamatPerusahaanC.text,
    //   "postal_code": pilihKodePos.value,
    //   "CityID": cityStoreArg.value,
    //   "ProvinceID": provinceStoreArg.value,
    //   "BusinessEntityID": pilihBadanUsaha.value,
    //   "BusinessFieldID": pilihBidangUsaha.value,
    //   "name1": namaPIC1.text,
    //   "no1": noHpPIC1.text,
    //   "name2": namaPIC2.text,
    //   "no2": noHpPIC2.text,
    //   "name3": namaPIC3.text,
    //   "no3": noHpPIC3.text,
    // };
  }
  
  checkNoTelpField(String value) {
    var length = sv.isLength(value, 8, 14);
    var numeric = sv.isNumeric(value);
    if (value.isEmpty || value == "") {
      CustomToastTop.show(
          message: "No. HP PIC minimal 8 digit!", context: Get.context, isSuccess: 0);
      isNoTelpValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (length == false) {
      CustomToastTop.show(
          message: "No. HP PIC minimal 8 digit! ", context: Get.context, isSuccess: 0);
      isNoTelpValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (numeric == false) {
      CustomToastTop.show(
          message: "Format No Hp tidak sesuai!",
          context: Get.context,
          isSuccess: 0);
      isNoTelpValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    log('noHPValid : ${isNoPic1Valid.value}');
    log('masuk sini');
  }

  checkNoHP1Field(String value) {
    var length = sv.isLength(value, 8, 14);
    var numeric = sv.isNumeric(value);
    if (value.isEmpty || value == "") {
      CustomToastTop.show(
          message: "No. HP PIC minimal 8 digit!", context: Get.context, isSuccess: 0);
      isNoPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (length == false) {
      CustomToastTop.show(
          message: "No. HP PIC minimal 8 digit!", context: Get.context, isSuccess: 0);
      isNoPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (numeric == false) {
      CustomToastTop.show(
          message: "Format No Hp tidak sesuai!",
          context: Get.context,
          isSuccess: 0);
      isNoPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    log('noHPValid : ${isNoPic1Valid.value}');
     log('masuk sini');
  }

  checkNoHP2Field(String value) {
    var length = sv.isLength(value, 8, 14);
    var numeric = sv.isNumeric(value);
    if (value.isNotEmpty) {
      if (length == false) {
        CustomToastTop.show(
            message: "No. HP PIC minimal 8 digit!",
            context: Get.context,
            isSuccess: 0);
        isNoPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      } else if (numeric == false) {
        CustomToastTop.show(
            message: "No. HP PIC minimal 8 digit!",
            context: Get.context,
            isSuccess: 0);
        isNoPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }

    log('noHPValid : ${isNoPic2Valid.value}');
  }

  checkNoHP3Field(String value) {
    var length = sv.isLength(value, 8, 14);
    var numeric = sv.isNumeric(value);
    if (value.isNotEmpty) {
      if (length == false) {
        CustomToastTop.show(
            message: "No. HP PIC minimal 8 digit!",
            context: Get.context,
            isSuccess: 0);
        isNoPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      } else if (numeric == false) {
        CustomToastTop.show(
            message: "Format No Hp tidak sesuai!",
            context: Get.context,
            isSuccess: 0);
        isNoPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
      log('noHPValid : $isNoPic3Valid{.value}');
    }
  }

  checkNameUsahaField(String value) {
    if (value == "" || value.isEmpty) {
      CustomToastTop.show(
          message: "Nama Minimal 3 karakter!",
          context: Get.context,
          isSuccess: 0);
      isNamaPerusahaanValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    if (value.length.isLowerThan(3)) {
      CustomToastTop.show(
          message: "Nama Minimal 3 karakter!",
          context: Get.context,
          isSuccess: 0);
      isNamaPerusahaanValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    if (value.isNumericOnly || value.isNum) {
      CustomToastTop.show(
          message: "Format Nama tidak sesuai!",
          context: Get.context,
          isSuccess: 0);
      isNamaPerusahaanValid.value = false;
      isFilled.value = false;
      isValid.value = false;
      var start = value[0];
      if (value.endsWith(start)) {
        CustomToastTop.show(message: "Format Nama tidak sesuai!", context: Get.context, isSuccess: 0);
        isNamaPerusahaanValid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }
  }

  checkBadanUsahaField(String value) {
    if (value == "" || value.isEmpty) {
      CustomToastTop.show(message: "Field badan usaha harus diisi!", context: Get.context, isSuccess: 0);
      isbadanUsahaValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
  }

  checkBidangUsahaField(String value) {
    if (value == "" || value.isEmpty) {
      CustomToastTop.show(message: "Field bidang usaha harus diisi!", context: Get.context, isSuccess: 0);
      isBidangUsahaValid.value = false;
      isFilled.value = false;
      isValid.value = false;
      return;
    }
  }

  checkNamle1Field(String value) {
    if (value == "" || value.isEmpty || value.length.isLowerThan(3)) {
      CustomToastTop.show(message: "Nama Minimal 3 karakter!", context: Get.context, isSuccess: 0);
      isNamaPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (!value.contains(RegExp(r"[a-zA-Z0-9.' ]")) || value.isNumericOnly) {
      CustomToastTop.show(message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
      isNamaPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      var start = value[0];
      if (value.endsWith(start)) {
        CustomToastTop.show(message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
        isNamaPic1Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }
  }

  checkNamle2Field(String value) {
    if (value.isNotEmpty) {
      if (value.length.isLowerThan(3)) {
        CustomToastTop.show(message: "Nama Minimal 3 karakter!", context: Get.context, isSuccess: 0);
        isNamaPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
      if (value.isNumericOnly || value.isNum) {
        CustomToastTop.show(message: "Format Nama tidak sesuai!", context: Get.context, isSuccess: 0);
        isNamaPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
        var start = value[0];
        if (value.endsWith(start)) {
          CustomToastTop.show(message: "Format Nama tidak sesuai!", context: Get.context, isSuccess: 0);
          isNamaPic2Valid.value = false;
          isFilled.value = false;
          isValid.value = false;
        }
        CustomToastTop.show(message: "Format Nama tidak sesuai!", context: Get.context, isSuccess: 0);
        isNamaPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      } else {
        var start = value[0];
        if (value.endsWith(start)) {
          CustomToastTop.show(message: "Format Nama tidak sesuai!", context: Get.context, isSuccess: 0);
          isNamaPic2Valid.value = false;
          isFilled.value = false;
          isValid.value = false;
        }
      }
    }
  }

  checkpic2(String namavalue, String notelpvalue){
    if(namavalue.isEmpty || notelpvalue.isEmpty){
      CustomToastTop.show(message: "Field PIC 2 Harus Lengkap!", context: Get.context, isSuccess: 0);
      isNamaPic2Valid.value = false;
      isNoPic2Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    if (notelpvalue.length < 8){
      CustomToastTop.show(message: "No. HP PIC minimal 8 digit!", context: Get.context, isSuccess: 0);
      isNamaPic2Valid.value = false;
      isNoPic2Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
  }

  checkNamle3Field(String value) {
    if (value.isNotEmpty) {
      if (value.length.isLowerThan(3)) {
        CustomToastTop.show(message: "Nama Minimal 3 karakter!", context: Get.context, isSuccess: 0);
        isNamaPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
      if (value.isNumericOnly || value.isNum) {
        CustomToastTop.show(message: "Format Nama tidak sesuai!", context: Get.context, isSuccess: 0);
        isNamaPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
        var start = value[0];
        if (value.endsWith(start)) {
          CustomToastTop.show(message: "Format Nama tidak sesuai!", context: Get.context, isSuccess: 0);
          isNamaPic3Valid.value = false;
          isFilled.value = false;
          isValid.value = false;
        }
        CustomToastTop.show(message: "Format Nama tidak sesuai!", context: Get.context, isSuccess: 0);
        isNamaPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      } else {
        var start = value[0];
        if (value.endsWith(start)) {
          CustomToastTop.show(message: "Format Nama tidak sesuai!", context: Get.context, isSuccess: 0);
          isNamaPic3Valid.value = false;
          isFilled.value = false;
          isValid.value = false;
        }
      }
    }
  }

  checkAlamatField(String value) {
    if (value.isEmpty || value == "") {
      CustomToastTop.show(message: "Alamat tidak boleh kososng", context: Get.context, isSuccess: 0);
      isAlamaPerusahaanValid.value = false;
      isFilled.value = false;
    }
  }

  checkEmailField(String value) {
    if (value.isEmpty || value == "") {
      isEmailValid.value = false;
      isFilled.value = false;
      CustomToastTop.show(
        message: "Email tidak boleh kosong",
        context: Get.context,
        isSuccess: 0
      );
    } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
    
    } else {
      isEmailValid.value = false;
      isFilled.value = false;
      CustomToastTop.show(
        message: "Format penulisan email Anda salah!",
        context: Get.context,
        isSuccess: 0
      );
    }
  }
  checkFieldIsValidCross() async {
        if(pilihBidangUsaha.value == "3" || pilihBidangUsaha.value == "5"){
          tipeBadanUsaha.value = TipeBadanUsaha.PT_CV;
        }
        else{
          tipeBadanUsaha.value = TipeBadanUsaha.FIRMA_YAYASAN;
        }
        pageIndex.value = 3;
        changePageIndex(pageIndex.value);
  }

  checkFieldIsValid() async {
    await checkNameUsahaField(namaPerusahaanValue.value);
    await checkBidangUsahaField(pilihBidangUsaha.value);
    await checkNoTelpField(noTelpPerusahaan.value);
    await checkNamle1Field(namaPIC1.text);
    await checkNoHP1Field(noHpPIC1.text);
    log('1');
    if(namaPIC2.value.text != "" || noHpPIC2.value.text != ""){
      log('refoo cek PIC 2');
    await checkpic2(namaPIC2.text, noHpPIC2.text);
    }
    log('2');
    await checkEmailField(email.value);
    log('3');
    await validateCompanyData();
    log('4');
    if (isNamaPerusahaanValid.value != false &&
        isBidangUsahaValid.value != false &&
        isAlamaPerusahaanValid.value != false &&
        isEmailValid.value != false &&
        emailChanged.value == false &&
        isKecamatanValid.value != false &&
        isKodePosValid.value != false &&
        isNamaPic1Valid.value != false &&
        isNoPic1Valid.value != false &&
        isNamaPic2Valid.value != false &&
        isNoPic2Valid.value != false &&
        isNoTelpValid.value != false) {
      isValid.value = true;
      
      if(isValid.value == true){
        if(pilihBidangUsaha.value == "3" || pilihBidangUsaha.value == "5"){
          tipeBadanUsaha.value = TipeBadanUsaha.PT_CV;
        }
        else{
          tipeBadanUsaha.value = TipeBadanUsaha.FIRMA_YAYASAN;
        }
        log('refo error');
        pageIndex.value = 3;
        changePageIndex(pageIndex.value);
      }
    } else {
      isValid.value = false;
    }
  }
  // #################################
  // ##  END FUNCTION SECOND PAGE   ##
  // #################################



  // #################################
  // ##  START FUNCTION THIRD PAGE  ##
  // #################################
  Future setLegality() async {
    List<String> fileFields = [];
    List<File> files = [];
    List<MediaType> fileContents = [];

    for (var i = 0; i < fileKtpDirektur.length; i++) {
      fileFields.add("FileKtpDirektur[$i]");
      files.addAll(fileKtpDirektur.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileKtpDirektur[i] as File).path)));
    }

    for (var i = 0; i < fileNpwpPerusahaan.length; i++) {
      fileFields.add("FileNpwp[$i]");
      files.addAll(fileNpwpPerusahaan.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileNpwpPerusahaan[i] as File).path)));
    }

    for (var i = 0; i < fileKtp.length; i++) {
      fileFields.add("FileKtpPic[$i]");
      files.addAll(fileKtp.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileKtp[i] as File).path)));
    }

    for (var i = 0; i < fileAkta1.value.length; i++) {
      fileFields.add("FileAktaPendirian[$i]");
      files.addAll(fileAkta1.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileAkta1[i] as File).path)));
    }

    for (var i = 0; i < fileAkta2.value.length; i++) {
      fileFields.add("FileAktaADT[$i]");
      files.addAll(fileAkta2.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileAkta2[i] as File).path)));
    }

    for (var i = 0; i < fileAkta3.value.length; i++) {
      fileFields.add("FileAktaDireksi[$i]");
      files.addAll(fileAkta3.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileAkta3[i] as File).path)));
    }

    for (var i = 0; i < fileAkta4.value.length; i++) {
      fileFields.add("FileAktaPerubahan[$i]");
      files.addAll(fileAkta4.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileAkta4[i] as File).path)));
    }

    for (var i = 0; i < fileNib.value.length; i++) {
      fileFields.add("FileNIB[$i]");
      files.addAll(fileNib.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileNib[i] as File).path)));
    }

    for (var i = 0; i < fileSertifikat.value.length; i++) {
      fileFields.add("FileSertifikatStandard[$i]");
      files.addAll(fileSertifikat.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileSertifikat[i] as File).path)));
    }

    await ApiHelper(context: Get.context, isShowDialogLoading: false, isShowDialogError: false).setShipperRegistrationLegality(
      fileFields: fileFields, 
      files: files, 
      fileContents: fileContents,
      tipeModul: tipeModul.value,
      body: {
        'KtpDirektur': ktpDirekturController.text,
        'Npwp': npwpPerusahaanController.text,
        'KtpPic': ktpController.text
      }
    );
  }

  void resetLegality() {
    // Hilangkan semua data di form legalitas
    // fileAkta1.clear();
    // fileAkta1Result.clear();
    // fileAkta2.clear();
    // fileAkta2Result.clear();
    // fileAkta3.clear();
    // fileAkta3Result.clear();
    // fileKtpDirektur.clear();
    // fileKtpDirekturResult.clear();
    // fileAkta4.clear();
    // fileAkta4Result.clear();
    // fileNib.clear();
    // fileNibResult.clear();
    // fileSertifikat.clear();
    // fileSertifikatResult.clear();
    // fileNpwpPerusahaan.clear();
    // fileNpwpPerusahaanResult.clear();
    // fileKtp.clear();
    // fileKtpResult.clear();

    // ktpDirekturController.clear();
    // npwpPerusahaanController.clear();
    // ktpController.clear();

    // isValidKtpDirektur.value = true;
    // isValidNpwpPerusahaan.value = true;
    // isValidKtp.value = true;
    // isFilledThirdPage.value = false;

    // isValidFileKtpDirektur.value = false;
    // isValidFileNpwpPerusahaan.value = false;
    // isValidFileKtp.value = false;
  }

  void initLegality() {
    fileAkta1.clear();
    fileAkta1Result.clear();
    fileAkta2.clear();
    fileAkta2Result.clear();
    fileAkta3.clear();
    fileAkta3Result.clear();
    fileKtpDirektur.clear();
    fileKtpDirekturResult.clear();
    fileAkta4.clear();
    fileAkta4Result.clear();
    fileNib.clear();
    fileNibResult.clear();
    fileSertifikat.clear();
    fileSertifikatResult.clear();
    fileNpwpPerusahaan.clear();
    fileNpwpPerusahaanResult.clear();
    fileKtp.clear();
    fileKtpResult.clear();

    ktpDirekturController.clear();
    npwpPerusahaanController.clear();
    ktpController.clear();

    isValidKtpDirektur.value = true;
    isValidNpwpPerusahaan.value = true;
    isValidKtp.value = true;
    isFilledThirdPage.value = false;

    isValidFileKtpDirektur.value = false;
    isValidFileNpwpPerusahaan.value = false;
    isValidFileKtp.value = false;

    isFilledFromCrossAkta1.value = false;
    isFilledFromCrossAkta2.value = false;
    isFilledFromCrossAkta3.value = false;
    isFilledFromCrossAkta4.value = false;
    isFilledFromCrossNib.value = false;
    isFilledFromCrossSertifikat.value = false;
    isFilledFromCrossKtpDirektur.value = false;
    isFilledFromCrossNpwpPerusahaan.value = false;
    isFilledFromCrossKtp.value = false;
  }

  void fillThirdPage(var data) {
    initLegality();

    ktpDirekturController.text = data["KtpDirektur"].toString();
    npwpPerusahaanController.text = data["Npwp"].toString();
    ktpController.text = data["KtpPic"].toString();

    log("File Akta Pendirian: " + data["FileAktaPendirian"].length.toString());
    for(int i = 0; i < data["FileAktaPendirian"].length; i++){
      fileAkta1.add(File(data["FileAktaPendirian"][i]["FullPath"]));
      fileAkta1Result.add(data["FileAktaPendirian"][i]["Filename"]);
      isFilledFromCrossAkta1.value = true;
    }
    
    log("File Akta Adt: " + data["FileAktaAdt"].length.toString());
    for(int i = 0; i < data["FileAktaAdt"].length; i++){
      fileAkta2.add(File(data["FileAktaAdt"][i]["FullPath"]));
      fileAkta2Result.add(data["FileAktaAdt"][i]["Filename"]);
      isFilledFromCrossAkta2.value = true;
    }

    log("File Akta Direksi: " + data["FileAktaDireksi"].length.toString());
    for(int i = 0; i < data["FileAktaDireksi"].length; i++){
      fileAkta3.add(File(data["FileAktaDireksi"][i]["FullPath"]));
      fileAkta3Result.add(data["FileAktaDireksi"][i]["Filename"]);
      isFilledFromCrossAkta3.value = true;
    }

    log("File Akta Perubahan: " + data["FileAktaPerubahan"].length.toString());
    for(int i = 0; i < data["FileAktaPerubahan"].length; i++){
      fileAkta4.add(File(data["FileAktaPerubahan"][i]["FullPath"]));
      fileAkta4Result.add(data["FileAktaPerubahan"][i]["Filename"]);
      isFilledFromCrossAkta4.value = true;
    }

    log("File NIB: " + data["FileNib"].length.toString());
    for(int i = 0; i < data["FileNib"].length; i++){
      fileNib.add(File(data["FileNib"][i]["FullPath"]));
      fileNibResult.add(data["FileNib"][i]["Filename"]);
      isFilledFromCrossNib.value = true;
    }

    log("File Sertifikat Standard: " + data["FileSertifikatStandard"].length.toString());
    for(int i = 0; i < data["FileSertifikatStandard"].length; i++){
      fileSertifikat.add(File(data["FileSertifikatStandard"][i]["FullPath"]));
      fileSertifikatResult.add(data["FileSertifikatStandard"][i]["Filename"]);
      isFilledFromCrossSertifikat.value = true;
    }

    log("File KTP Direktur: " + data["FileKtpDirektur"].length.toString());
    for(int i = 0; i < data["FileKtpDirektur"].length; i++){
      fileKtpDirektur.add(File(data["FileKtpDirektur"][i]["FullPath"]));
      fileKtpDirekturResult.add(data["FileKtpDirektur"][i]["Filename"]);
      isFilledFromCrossKtpDirektur.value = true;
      isValidFileKtpDirektur.value = true;
    }

    log("File NPWP: " + data["FileNpwp"].length.toString());
    for(int i = 0; i < data["FileNpwp"].length; i++){
      fileNpwpPerusahaan.add(File(data["FileNpwp"][i]["FullPath"]));
      fileNpwpPerusahaanResult.add(data["FileNpwp"][i]["Filename"]);
      isFilledFromCrossNpwpPerusahaan.value = true;
      isValidFileNpwpPerusahaan.value = true;
    }

    log("File KTP PIC: " + data["FileKtpPic"].length.toString());
    for(int i = 0; i < data["FileKtpPic"].length; i++){
      fileKtp.add(File(data["FileKtpPic"][i]["FullPath"]));
      fileKtpResult.add(data["FileKtpPic"][i]["Filename"]);
      isFilledFromCrossKtp.value = true;
      isValidFileKtp.value = true;
    }

    if(isFilledFromCrossAkta1.value &&
        isFilledFromCrossAkta2.value &&
        isFilledFromCrossAkta3.value &&
        isFilledFromCrossAkta4.value &&
        isFilledFromCrossNib.value &&
        isFilledFromCrossSertifikat.value &&
        isFilledFromCrossKtpDirektur.value &&
        isFilledFromCrossNpwpPerusahaan.value &&
        isFilledFromCrossKtp.value
    ) isFilledThirdPage.value = true;
  }
  // ###############################
  // ##  END FUNCTION THIRD PAGE  ##
  // ###############################



  // PRIVATE CUSTOM BUTTON 
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
        GlobalVariable.ratioWidth(Get.context) * marginBottom
      ),
      width: width == null ? maxWidth ? MediaQuery.of(Get.context).size.width : null : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null ? null : GlobalVariable.ratioWidth(Get.context) * height,
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
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        border: useBorder
          ? Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * borderSize,
              color: borderColor ?? Color(ListColor.colorBlue),
            )
          : null
      ),
      child: Material(
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
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
              GlobalVariable.ratioWidth(Get.context) * paddingBottom
            ),
            width: maxWidth ? double.infinity : null,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius)
            ),
            child: customWidget == null
              ? CustomText(
                  text ?? "",
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                )
              : customWidget,
          )
        ),
      ),
    );
  }
}