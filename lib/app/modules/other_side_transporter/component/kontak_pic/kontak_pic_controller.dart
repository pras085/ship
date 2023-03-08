import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/other_side_transporter/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/modules/ubah_kontak_pic/ubah_kontak_pic_model.dart';
import 'package:muatmuat/app/utils/response_state.dart';

class KontakPICController extends GetxController {
  var dataTransporterC = Get.find<OtherSideTransController>();
  var dataModelResponse = ResponseState<KontakPicShipperModel>().obs;

  var loading = false.obs;
  var isFilled = false.obs;

  var reportCategory = [].obs;
  var groupValue = "".obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchDataPicFromAPi();
  }

  Future copyNumber(String number) async {
    await Clipboard.setData(ClipboardData(text: number)).then(
      (value) => CustomToast.show(
        buttonText: "Tutup",
        context: Get.context,
        message: 'Kode Referral berhasil disalin',
      ),
    );
  }

  Future<void> fetchDataPicFromAPi() async {
    try {
      print(":::" + dataTransporterC.idtrans.value.toString());
      dataModelResponse.value = ResponseState.loading();
      var response = await ApiProfile(context: Get.context).getDataPicTransporter('${dataTransporterC.idtrans.value}');
      if (response != null) {
        // convert json to object
        if (response['Message']['Code'] == 200) {
          // sukses
          dataModelResponse.value = ResponseState.complete(KontakPicShipperModel.fromJson(response));
        } else {
          // error
          if (dataModelResponse.value.data.message.code != null) {
            throw (dataModelResponse.value.data.message.text);
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

  Future launchWhatsApp(String phoneNumber) async {
    var formatter = phoneNumber.replaceAll('-', '');
    formatter = phoneNumber.replaceAll('+', '');
    try {
      await FlutterOpenWhatsapp.sendSingleMessage(formatter, 'Hallo');
    } catch (e) {
      throw 'Could not launch $e';
    }
  }
}
