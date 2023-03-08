import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/app/utils/response_state.dart';

import 'dealer_brand_buyer.dart';

class DealerBrandBuyerController extends GetxController {

  DealerBrandBuyerController() {
    fetchDataListBrand();
  }

  var dataModelResponse = ResponseState<List<DealerBrandModelBuyer>>().obs;

  void fetchDataListBrand() async {
    try {
      dataModelResponse.value = ResponseState.loading();
      final response = await ApiBuyer(context: Get.context).getBrand({});
      if (response != null) {
        if (response['Message']['Code'] == 200 && (response['Data'] is List)) {
          // convert json to object
          dataModelResponse.value = ResponseState.complete((response['Data'] as List).map((e) => DealerBrandModelBuyer.fromJson(e)).toList());
        } else {
          // error
          if (response['Message'] != null && response['Message']['Text'] != null) {
            throw("${response['Message']['Text']}");
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