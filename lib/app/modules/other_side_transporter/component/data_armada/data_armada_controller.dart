import 'package:get/get.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/data_armada/data_armada_model.dart';
import 'package:muatmuat/app/modules/other_side_transporter/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/utils/response_state.dart';

class DataArmadaController extends GetxController {
  var dataTransporterC = Get.find<OtherSideTransController>();
  var dataArmada = ResponseState<DataTruckModel>().obs;

  @override
  void onInit() async {
    super.onInit();
    // transporterID.value = '28';
    fetchData();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  fetchData() async {
    try {
      dataArmada.value = ResponseState.loading();
      final response = await ApiHelper(
        context: Get.context,
        isShowDialogLoading: false,
        isDebugGetResponse: true,
      ).getAllTruck({'TargetUserID': dataTransporterC.idtrans.value});
      if (response != null) {
        // convert json to object
        dataArmada.value = ResponseState.complete(DataTruckModel.fromJson(response));
        if (dataArmada.value.data.message.code == 200) {
        } else {
          // error
          if (dataArmada.value.data.message != null && dataArmada.value.data.message.code != 500) {
            throw ("${dataArmada.value.data.message.text}");
          }
          throw ("failed to fetch data!");
        }
      } else {
        // error
        throw (response['Data']['Message']);
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      dataArmada.value = ResponseState.error("$error");
    }
  }
}
