import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/app/modules/login/login_controller.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/widgets/dealer_brand/dealer_brand_buyer.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../selected_location_controller.dart';

class ListIklanPlacesPromoController extends GetxController {

  final locationController = Get.find<SelectedLocationController>();
  final refreshController = RefreshController();
  var argument = Rxn<Map>();
  var filter = Rxn<Map>();
  var brand = Rxn<DealerBrandModelBuyer>();
  var dataModelResponse = ResponseState<Map>().obs;
  var dataList = <Map>[].obs;
  var page = 0.obs; // default 0
  var searchResult = "".obs;
  var isFavorite = false.obs;
  final selectedSorting = Rxn<String>();
  var bannerAds = "".obs;
  var bannerTargetUrl = "".obs;

  var isLoading = false.obs;
  var scrollController = ScrollController();
  var bannerKey = GlobalKey();
  var listKey = GlobalKey();
  var badgeKey = GlobalKey();
  var buttonKey = GlobalKey();
  var lastPosition = 0.0.obs;

  var isBF = true.obs;
  var isTM = true.obs;

  Future fetchDataIklan({refresh = true}) async {
    try {
      if (refresh || isFavorite.value) {
        dataList.value = [];
        dataModelResponse.value = ResponseState.loading();
        page.value = 0; // reset value
      }

      // HARDCODED FOR PROMO KAB/KOTA
      String kategoriId = "${argument.value['KategoriID']}";
      String subKategoriId = "${argument.value['ID']}";
      if (kategoriId == "54") {
        kategoriId = "54,55";
      }
      if (subKategoriId == "50") {
        subKategoriId = "50,51";
      }

      // ensure argument is not null, initialize on "onInit" func in view
      final body = {
        'search': searchResult.value,
        'limit': locationController.location.value == null ? "10" : "5",
        'pageNow': "${page.value+1}",
        'isWishList': isFavorite.value ? "1" : "0"
      };

      if (subKategoriId != "49") {
        body['KategoriID'] = kategoriId;
        body['SubKategoriID'] = subKategoriId;
      }

      // add user ID if there is a user
      if (GlobalVariable.userModelGlobal.docID != null && GlobalVariable.userModelGlobal.docID.isNotEmpty) {
        body.addAll({
          'UserID': GlobalVariable.userModelGlobal.docID,
        });
      }

      // cek sorting
      if (selectedSorting.value != null && !isFavorite.value) {
        // split value from sorting;
        // ex: {sortBy: 'harga', sortType: 'asc'}
        body.addAll({
          'sortBy': selectedSorting.value.split(",").first,
          'sortType': selectedSorting.value.split(",").last,
        });
      }
      
      // input filter
      if (filter.value != null) {
        final obj = Map.from(filter.value)..removeWhere((key, value) {
          if (value['value'] != null) {
            if (value['value'] is List && (value['value'] as List).isNotEmpty) {
              return false;
            } else {
              if (value['value'] is String) return false;
              return true;
            }
          }
          return true;
        });
        body.addAll({
          'filter': jsonEncode(obj),
        });
      }

      // cek location
      if (locationController.location.value != null && !isFavorite.value) {
        body.addAll({
          'DistrictID': locationController.location.value.districtID.toString(),
          'CityID': locationController.location.value.cityID.toString(),
        });
      }

      final response = await ApiBuyer(context: Get.context).getDataPromo(body);
      if (response != null) {
        if (refresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else if ((response['Data'] as List).isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
          // if (locationController.location.value != null) getCurrentPosition(first: false, item: [...dataList.value, response['Data']]);
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
          
          // if (locationController.location.value != null && refresh) {
          //   lastPosition.value = 0;
          //   Future.delayed(Duration(milliseconds: 500), () {
          //     getCurrentPosition(first: true, item: dataList.value);
          //   });
          // }
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
      print("ERROR IKLAN PLACES :: $error");
      dataModelResponse.value = ResponseState.error("$error");
    }
  }

  Future addToWishlist(int index) async {
    String subKategoriId = "${dataList[index]['SubKategoriID']}";
    addToWishlistBuyer(
      body: {
        'KategoriID': "${dataList[index]['KategoriID']}",
        'SubKategoriID': "$subKategoriId",
        'IklanID': "${dataList[index]['ID']}",
        'isWishList': "${dataList[index]['favorit']}" == "1" ? "0" : "1",
        'UserID': GlobalVariable.userModelGlobal.docID
      },
      onSuccess: () {
        dataList[index]['favorit'] = "${dataList[index]['favorit']}" == "1" ? "0" : "1";
        dataList.refresh();
      },
    );
  }

  double getCurrentPosition({bool first = false, List item}) {
    int itemCount = 0;

    if (item != null && item.isNotEmpty) {
      itemCount = item.length - 2;
      lastPosition.value = (itemCount * 186) + getWidgetSizeByKey(buttonKey).height + getWidgetSizeByKey(bannerKey).height;
      // print("FIRST POSITION: ${(itemCount * 186)} + ${getWidgetSizeByKey(buttonKey).height} + ${getWidgetSizeByKey(bannerKey).height} = ${lastPosition.value}");
    }

    return lastPosition.value;
  }

  Size getWidgetSizeByKey(GlobalKey<State<StatefulWidget>> key) {
    RenderBox box = key.currentContext.findRenderObject() as RenderBox;
    return box.size;
  }
}

Future addToWishlistBuyer({
  Map<String, dynamic> body,
  VoidCallback onSuccess,
}) async {
  if (GlobalVariable.tokenApp.isEmpty) {
    GlobalAlertDialog.showAlertDialogCustom(
      context: Get.context,
      insetPadding: 17,
      customMessage: Container(
        margin: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 15,
          right: GlobalVariable.ratioWidth(Get.context) * 15,
          bottom: GlobalVariable.ratioWidth(Get.context) * 16,
        ),
        child: CustomText(
          "Silahkan Masuk atau Daftar terlebih dahulu jika belum punya akun muatmuat",
          textAlign: TextAlign.center,
          fontSize: 14,
          height: 21 / 14,
          color: Colors.black,
          fontWeight: FontWeight.w600
        ),
      ),
      borderRadius: 12,
      primaryColor: Color(ListColor.colorBlueTemplate),
      labelButtonPriority1: "Daftar",
      labelButtonPriority2: "Masuk",
      positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
      onTapPriority1: () {
        GetToPage.toNamed<RegisterUserController>(Routes.REGISTER_USER);
      },
      onTapPriority2: () {
        GetToPage.toNamed<LoginController>(Routes.LOGIN);
      }
    );
  } else {
    try {
      final response = await ApiBuyer(
        context: Get.context,
      ).saveWishlist(body);
      if (response != null) {
        if (response['Message'] != null && response['Message']['Code'] == 200) {
          onSuccess();
        } else {
          throw("error");
        }
      } else {
        throw("error");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      CustomToastTop.show(
        context: Get.context, 
        isSuccess: 0,
        message: "failed to add wishlist!",
      );
    }
  }
}