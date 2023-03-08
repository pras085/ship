import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/app/modules/buyer/list_iklan/list_iklan_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:share/share.dart';

class DetailIklanController extends GetxController {
  var args = {}.obs;
  var dataModelResponse = ResponseState<Map>().obs;
  var isFavorite = false.obs;
  var layananId = "".obs;

  void fetchDataDetailIklan({isRefresh = true}) async {
    try {

      // HARDCODED FOR KATALOG PRODUK
      String subKategoriId = "${args.value['SubKategoriID']}";
      if (subKategoriId == "24") {
        subKategoriId = "23";
      }
      else if (subKategoriId == "26") {
        subKategoriId = "25";
      }

      if (isRefresh) dataModelResponse.value = ResponseState.loading();
      final body = {
        'KategoriID': "${args.value['KategoriID']}",
        'SubKategoriID': subKategoriId,
        'IklanID': "${args.value['IklanID']}",
      };
      // add user ID if there is a user
      if (GlobalVariable.userModelGlobal.docID != null && GlobalVariable.userModelGlobal.docID.isNotEmpty) {
        body.addAll({
          'UserID': GlobalVariable.userModelGlobal.docID,
        });
      }
      final response = await ApiBuyer(context: Get.context).getDataDetail(body);
      if (response != null) {
        if (response["Message"] != null && response["Message"]["Code"] == 200) {
          layananId.value = response["SupportingData"]["LayananID"].toString();

          // sorting by field
          final responseList = (response["Data"] as List);
          final tempList = List<Map>.from(responseList);

          if (tempList.isNotEmpty && tempList.first is Map) {
            // sukses
            isFavorite.value = tempList.first['favorit'] == "1";
            dataModelResponse.value = ResponseState.complete(tempList.first);
          } else {
            throw("Data not found!");
          }
        } else {
          // error
          if (response["Message"] != null &&
              response["Message"]["Text"] != null) {
            throw ("${response["Message"]["Text"]}");
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

  void addToWishlist() async {
    String subKategoriId = "${args.value['SubKategoriID']}";
    if ("$subKategoriId" == "24") {
      subKategoriId = "23";
    }
    else if ("$subKategoriId" == "26") {
      subKategoriId = "25";
    }
    addToWishlistBuyer(
      body: {
        'KategoriID': "${args.value['KategoriID']}",
        'SubKategoriID': "$subKategoriId",
        'IklanID': "${args.value['IklanID']}",
        'isWishList': isFavorite.value ? "1" : "0",
        'UserID': GlobalVariable.userModelGlobal.docID
      },
      onSuccess: () {
        isFavorite.value = !isFavorite.value;
        final controller = Get.find<ListIklanController>();
        int index = controller.dataList.indexWhere((e) => e['ID'] == args.value['IklanID']);
        controller.dataList[index]['favorit'] = isFavorite.value ? "1" : "0";
        controller.dataList.refresh();
      },
    );
  }

  void shareLink() {
    String moduleName = args.value['Layanan'].toString().replaceAll(" ", "-").toLowerCase();
    String path = "detail?kategoriID=${args.value['KategoriID']}&subKategoriID=${args.value['SubKategoriID']}&detail=${args.value['IklanID']}";
    String linkWeb = Uri.encodeComponent("${ApiHelper.urlInternal}$moduleName/$path");
    String dynamicLink = "https://azshipper.page.link/?link=$linkWeb&apn=com.azlogistik.muatmuat";
    Share.share(dynamicLink);
  }

}
