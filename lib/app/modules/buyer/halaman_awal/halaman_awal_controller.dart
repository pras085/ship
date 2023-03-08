import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/app/utils/response_state.dart';

import 'halaman_awal_model.dart';

class HalamanAwalController extends GetxController {

  var dataModelResponse = ResponseState<HalamanAwalModel>().obs;
  var layananId = "".obs;

  void fetchSubCategory({isRefresh = true}) async {
    try {
      if (isRefresh) dataModelResponse.value = ResponseState.loading();
      final response = await ApiBuyer(context: Get.context).getSubKategori({
        'LayananID': layananId.value,
      });
      if (response != null) {
        // convert json to object
        dataModelResponse.value = ResponseState.complete(HalamanAwalModel.fromJson(response));
        if (dataModelResponse.value.data.message.code == 200) {
          // sukses
        } else {
          // error
          if (dataModelResponse.value.data.message != null && dataModelResponse.value.data.message.text != null) {
            throw("${dataModelResponse.value.data.message.text}");
          }
          throw("failed to fetch data!");
        }
      } else {
        // error
        throw("failed to fetch data!");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      dataModelResponse.value = ResponseState.error("$error");
    }
  }

}