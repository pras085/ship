import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BarangLainnyaController extends GetxController {
  final refreshController = RefreshController();
  var args = {}.obs;
  var dataModelResponse = ResponseState<Map>().obs;
  var dataList = <Map>[].obs;
  var page = 0.obs; // default 0
  var isFavorite = false.obs;

  void fetchDataBarangSeller({refresh = true}) async {
    try {
      String kategoriId = "${args['KategoriID']}";
      String subKategoriId = "${args['SubKategoriID']}";
      String sellerId = "${args['Data']['data_seller']['ID']}";

      if (refresh || isFavorite.value) {
        dataList.value = [];
        dataModelResponse.value = ResponseState.loading();
        page.value = 0; // reset value
      }

      // HARDCODED FOR KATALOG PRODUK
      String isKatalog = "0";
      if (subKategoriId == "24") {
        subKategoriId = "23";
        isKatalog = "1";
      }
      else if (subKategoriId == "26") {
        subKategoriId = "25";
        isKatalog = "1";
      }

      final body = {
        'KategoriID': kategoriId,
        'SubKategoriID': subKategoriId,
        'SellerID': sellerId,
        'isKatalog': isKatalog,
        'limit': "10",
        'pageNow': "${page.value+1}",
      };

      final response = await ApiBuyer(context: Get.context).getDataBarangSeller(body);
      if (response != null) {
        if (refresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else if ((response['Data'] as List).isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        if (response['Message']['Code'] == 200 && (response['Data'] is Iterable)) {
          // increase page
          page.value += 1;
          // sukses
          dataModelResponse.value = ResponseState.complete(response);
          final cList = dataList.value;
          dataList.value = [
            ...cList,
            ...response['Data'],
          ];
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
