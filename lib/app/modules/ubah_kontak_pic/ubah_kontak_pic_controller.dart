import 'dart:developer';

import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/ubah_kontak_pic/ubah_kontak_pic_model.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:string_validator/string_validator.dart' as sv;

class UbahKontakPicController extends GetxController {
  //VALIDASI
  var isInit = true;
  var isLoading = true.obs;
  var isError = false.obs;
  var isValid = false.obs;
  var isFilled = false.obs;
  var errorMessage = "".obs;
  var isNamaPic1Valid = true.obs;
  var isNoPic1Valid = true.obs;
  var isNamaPic2Valid = true.obs;
  var isNoPic2Valid = true.obs;
  var isNamaPic3Valid = true.obs;
  var isNoPic3Valid = true.obs;

  var namaPic1 = "".obs;
  var namaPic2 = "".obs;
  var namaPic3 = "".obs;

  var namaPIC1C = TextEditingController(text: '').obs;
  var noHpPIC1C = TextEditingController(text: '').obs;
  var namaPIC2C = TextEditingController(text: '').obs;
  var noHpPIC2C = TextEditingController(text: '').obs;
  var namaPIC3C = TextEditingController(text: '').obs;
  var noHpPIC3C = TextEditingController(text: '').obs;

  final ContactPicker contactPicker = ContactPicker();
  final ContactPicker contactPicker2 = ContactPicker();
  final ContactPicker contactPicker3 = ContactPicker();

  var dataModelResponse = ResponseState<KontakPicShipperModel>().obs;
  var dataPIC = KontakPicShipperModel();

  final formKey = GlobalKey<FormState>().obs;

  // var isiAlamatC = TextEditingController;

  checkAllFieldIsFilled() {
    if (noHpPIC1C.value.text != "" && namaPIC1C.value.text != "") {
      isFilled.value = true;
    } else {
      isFilled.value = false;
    }
    log(
      'VALID : (${isValid.value}) ' +
          'FIELD ' +
          '(${isFilled.value})  \n' +
          ' Nama Pic1 : ' '${namaPIC1C.value.text}' +
          ', No Pic1 : ' '${noHpPIC1C.value.text}' +
          ', Nama Pic2: ' '${namaPIC2C.value.text}' +
          ', No Pic2 : ' '${noHpPIC2C.value.text}' +
          ', Nama Pic3: ' '${namaPIC3C.value.text}' +
          ', No Pic3 : ' '${noHpPIC3C.value.text}',
    );
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchDataPicFromAPi();
  }

  Future getData() async {
    if (dataPIC.data.pic1Name.isNotEmpty && dataPIC.data.pic1Phone.isNotEmpty) {
      namaPIC1C.value.text = dataPIC.data.pic1Name;
      noHpPIC1C.value.text = dataPIC.data.pic1Phone;
      namaPic1.value = namaPIC1C.value.text;
    } else {
      log('::: PIC 1 NULL :::');
    }
    if (dataPIC.data.pic2Name.isNotEmpty && dataPIC.data.pic2Phone.isNotEmpty) {
      namaPIC2C.value.text = dataPIC.data.pic2Name;
      noHpPIC2C.value.text = dataPIC.data.pic2Phone;
      namaPic2.value = namaPIC2C.value.text;
    } else {
      log('::: PIC 2 NULL :::');
    }
    if (dataPIC.data.pic3Name.isNotEmpty && dataPIC.data.pic3Phone.isNotEmpty) {
      namaPIC3C.value.text = dataPIC.data.pic3Name;
      noHpPIC3C.value.text = dataPIC.data.pic3Phone;
      namaPic3.value = namaPIC3C.value.text;
    } else {
      log('::: PIC 3 NULL :::');
    }
    log('::: GET DATA SUCCES :::');
    await checkAllFieldIsFilled();
  }

  Future<void> fetchDataPicFromAPi() async {
    try {
      dataModelResponse.value = ResponseState.loading();
      var response = await ApiProfile(
        context: Get.context,
        isShowDialogLoading: false,
      ).getDataPicShipper({});
      if (response != null) {
        // convert json to object
        dataPIC = KontakPicShipperModel.fromJson(response);
        if (response['Message']['Code'] == 200) {
          // sukses
          dataModelResponse.value = ResponseState.complete(KontakPicShipperModel.fromJson(response));
          if (dataPIC.data != null) {
            if (dataPIC.data.pic1Name != null) {
              await getData();
            }
          }
        } else {
          // error
          if (dataPIC.message.code != null) {
            throw (dataPIC.message.text);
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

  makeAllValid() {
    isNamaPic1Valid.value = true;
    isNamaPic2Valid.value = true;
    isNamaPic3Valid.value = true;
    isNoPic1Valid.value = true;
    isNoPic2Valid.value = true;
    isNoPic3Valid.value = true;
  }

  checkNamle1Field(String value) {
    if (value == "" || value.isEmpty || value.length.isLowerThan(3)) {
      CustomToastTop.show(
        message: "Nama Minimal 3 karakter!",
        context: Get.context,
        isSuccess: 0,
      );
      isNamaPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    if (!value.contains(RegExp(r"[a-zA-Z0-9.' ]")) || value.isNumericOnly) {
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

  checkNoHP1Field(String value) {
    var length = sv.isLength(value, 8, 14);
    var numeric = sv.isNumeric(value);
    if (value.isEmpty || value == "") {
      CustomToastTop.show(message: "No Hp minimal 8 digit", context: Get.context, isSuccess: 0);
      isNoPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (length == false) {
      CustomToastTop.show(message: "No Hp minimal 8 digit", context: Get.context, isSuccess: 0);
      isNoPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (numeric == false) {
      CustomToastTop.show(message: "Format No Hp tidak sesuai!", context: Get.context, isSuccess: 0);
      isNoPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    log('noHPValid 1 : ${isNoPic1Valid.value}');
  }

  checkNoHP2Field(String value) {
    var length = sv.isLength(value, 8, 14);
    var numeric = sv.isNumeric(value);
    if (value.isNotEmpty) {
      if (length == false) {
        CustomToastTop.show(message: "No Hp minimal 8 digit", context: Get.context, isSuccess: 0);
        isNoPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      } else if (numeric == false) {
        CustomToastTop.show(message: "Format No Hp tidak sesuai!", context: Get.context, isSuccess: 0);
        isNoPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }

    log('noHPValid 2 : ${isNoPic2Valid.value}');
  }

  checkNoHP3Field(String value) {
    var length = sv.isLength(value, 8, 14);
    var numeric = sv.isNumeric(value);
    if (value.isNotEmpty) {
      if (length == false) {
        CustomToastTop.show(message: "No Hp minimal 8 digit", context: Get.context, isSuccess: 0);
        isNoPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      } else if (numeric == false) {
        CustomToastTop.show(message: "Format No Hp tidak sesuai!", context: Get.context, isSuccess: 0);
        isNoPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
      log('noHPValid 3 : ${isNoPic3Valid.value}');
    }
  }

  checkNamleField2(String value) {
    if (value.isNotEmpty) {
      if (value.length.isLowerThan(3)) {
        CustomToastTop.show(message: "Nama PIC Minimal 3 karakter!", context: Get.context, isSuccess: 0);
        isNamaPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
      if (!value.contains(RegExp(r"[a-zA-Z0-9.' ]")) || value.isNumericOnly) {
        CustomToastTop.show(message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
        isNamaPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
        var start = value[0];
        if (value.endsWith(start)) {
          CustomToastTop.show(message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
          isNamaPic2Valid.value = false;
          isFilled.value = false;
          isValid.value = false;
        }
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
        var noPicked = contactPicked.phoneNumber.number.toString();
        noPicked = noPicked.replaceAll('+', "");
        noPicked = noPicked.replaceAll('-', "");
        noPicked = noPicked.replaceAll(' ', "");
        namaPIC1C.value.text = namaPicked;
        noHpPIC1C.value.text = noPicked;
        namaPic1.value = namaPicked;
        log('NUMBER: ${namaPIC1C.value.text}----${noHpPIC1C.value.text.length} ');
      }
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
        var noPicked = contactPicked.phoneNumber.number.toString();
        noPicked = noPicked.replaceAll('+', "");
        noPicked = noPicked.replaceAll('-', "");
        noPicked = noPicked.replaceAll(' ', "");

        // namaPic2.value = namaPicked;
        // noPic2.value = noPicked;
        // checkNamleField2(namaPic2.value);
        // log('NUMBER: ${noPic2.value}----${noPic2.value.length} ');
        namaPIC2C.value.text = namaPicked;
        namaPic2.value = namaPicked;
        noHpPIC2C.value.text = noPicked;
        // checkNamleField2(namaPIC2C.value.text);
        log('NUMBER: ${namaPIC2C.value.text}----${noHpPIC2C.value.text.length} ');
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
        var noPicked = contactPicked.phoneNumber.number.toString();
        noPicked = noPicked.replaceAll('+', "");
        noPicked = noPicked.replaceAll('-', "");
        noPicked = noPicked.replaceAll(' ', "");

        // namaPic3.value = namaPicked;
        // noPic3.value = noPicked;
        // checkNamleField3(namaPic3.value);
        // log('NUMBER: ${noPic3.value}----${noPic3.value.length} ');
        namaPIC3C.value.text = namaPicked;
        namaPic3.value = namaPicked;
        noHpPIC3C.value.text = noPicked;
        // checkNamleField3(namaPIC3C.value.text);
        log('NUMBER: ${namaPIC3C.value.text}----${noHpPIC3C.value.text.length} ');
      }

      // LAKUKAN APA

    }
  }

  checkNamleField3(String value) {
    if (value.isNotEmpty) {
      if (value.length.isLowerThan(3)) {
        CustomToastTop.show(message: "Nama PIC Minimal 3 karakter!", context: Get.context, isSuccess: 0);
        isNamaPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
        return;
      }
      if (!value.contains(RegExp(r"[a-zA-Z0-9.' ]")) || value.isNumericOnly) {
        CustomToastTop.show(message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
        isNamaPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
        var start = value[0];
        if (value.endsWith(start)) {
          CustomToastTop.show(message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
          isNamaPic3Valid.value = false;
          isFilled.value = false;
          isValid.value = false;
        }
      }
    }
  }

  Future<PermissionStatus> checkAppPermissionContact() async {
    //CEK STATUS PERMISSION
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.denied) {
      //JIKA TIDAK DISETUJUI / DITOLAK
      final Map<Permission, PermissionStatus> permissionStatus = await [Permission.contacts].request(); //REQUEST PERMISION
      return permissionStatus[Permission.contacts] ?? PermissionStatus.undetermined;
    } else {
      return permission; //RETURN CONTACT PERMISSIOn
    }
  }

  void cancel() {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "Batalkan Perubahan",
      context: Get.context,
      customMessage: Container(
        margin: EdgeInsets.only(
          bottom: GlobalVariable.ratioWidth(Get.context) * 16,
        ),
        child: CustomText(
          "Apakah Anda yakin akan\nmembatalkan perubahan ini ?",
          textAlign: TextAlign.center,
          fromCenter: true,
          height: 16.8 / 14,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      borderRadius: 12,
      labelButtonPriority1: "Kembali",
      labelButtonPriority2: "Ya",
      positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
      onTapPriority1: () {},
      onTapPriority2: () => checkFieldIsValid(),
      widthButton1: 104,
      widthButton2: 104,
      heightButton1: 36,
      heightButton2: 36,
    );
  }

  Future<void> checkValueIsSame() async {
    String errorMessage = "No. HP PIC tidak boleh sama!";
    if (noHpPIC2C.value.text.length > 1 && noHpPIC3C.value.text.length > 1) {
      if (noHpPIC1C.value.text == noHpPIC2C.value.text && noHpPIC2C.value.text == noHpPIC3C.value.text) {
        isNoPic1Valid.value = false;
        isNoPic2Valid.value = false;
        isNoPic3Valid.value = false;
        isValid.value = false;
        CustomToastTop.show(message: errorMessage, context: Get.context, isSuccess: 0);
        log(':::: 1 2 3 IsValid : ${isValid.value}');
        return;
      }
      if (noHpPIC1C.value.text == noHpPIC2C.value.text) {
        isNoPic1Valid.value = false;
        isNoPic2Valid.value = false;
        isValid.value = false;
        CustomToastTop.show(message: errorMessage, context: Get.context, isSuccess: 0);
        log(':::: 1 2 IsValid : ${isValid.value}');
        return;
      }
      if (noHpPIC2C.value.text == noHpPIC3C.value.text) {
        isNoPic2Valid.value = false;
        isNoPic3Valid.value = false;
        isValid.value = false;
        CustomToastTop.show(message: errorMessage, context: Get.context, isSuccess: 0);
        log(':::: 2 3 IsValid : ${isValid.value}');
        return;
      }
      if (noHpPIC1C.value.text == noHpPIC3C.value.text) {
        isNoPic1Valid.value = false;
        isNoPic3Valid.value = false;
        isValid.value = false;
        CustomToastTop.show(message: errorMessage, context: Get.context, isSuccess: 0);
        log(':::: 1 3 IsValid : ${isValid.value}');
        return;
      }
      if (isNamaPic1Valid.value != false &&
          isNoPic1Valid.value != false &&
          isNamaPic2Valid.value != false &&
          isNoPic2Valid.value != false &&
          isNamaPic3Valid.value != false &&
          isNoPic3Valid.value != false) {
        isValid.value = true;
        await doUpdateButton();
      } else {
        isValid.value = false;
        log('::: SAME ');
      }
    }
  }

  Future checkFieldIsValid() async {
    await checkNamle1Field(namaPIC1C.value.text);
    await checkNoHP1Field(noHpPIC1C.value.text);
    await checkNamleField2(namaPIC2C.value.text);
    await checkNoHP2Field(noHpPIC2C.value.text);
    await checkNamleField3(namaPIC3C.value.text);
    await checkNoHP3Field(noHpPIC3C.value.text);

    if (isNamaPic1Valid.value != false &&
        isNoPic1Valid.value != false &&
        isNamaPic2Valid.value != false &&
        isNoPic2Valid.value != false &&
        isNamaPic3Valid.value != false &&
        isNoPic3Valid.value != false) {
      isValid.value = true;
      await doUpdateButton();
      // await checkValueIsSame();
    } else {
      isValid.value = false;
    }
  }

  Future doUpdateButton() async {
    try {
      var body = {
        "pic_1_name": namaPIC1C.value.text,
        "pic_1_phone": noHpPIC1C.value.text,
        "pic_2_name": namaPIC2C.value.text,
        "pic_2_phone": noHpPIC2C.value.text,
        "pic_3_name": namaPIC3C.value.text,
        "pic_3_phone": noHpPIC3C.value.text,
      };

      var response = await ApiProfile(
        context: Get.context,
        isShowDialogLoading: true,
        isDebugGetResponse: true,
      ).doUpdateDataPicShipper(body);
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          log(":::: SUCESS");
          String errorMessage = response["Data"]["Message"];
          Get.back();
          CustomToastTop.show(context: Get.context, message: errorMessage, isSuccess: 1);
          return;
        } else {
          log(":::: GAGAL");
          String errorMessage = response["Data"]["Message"];
          if (response['Data']['Field'] != null) {
            String field = response['Data']['Field'];
            if (field == "pic1_phone") {
              checkValueIsSame();
            }
          }
          CustomToastTop.show(message: errorMessage, context: Get.context, isSuccess: 0);
        }
      }
    } catch (err) {
      print("Can't update data pic : " + err.toString());
    }
  }
}
