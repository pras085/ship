import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_model.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../global_variable.dart';

class BadgePlacesModelBuyer {

  final String text;
  // type used for separated badge.
  final int type;
  final VoidCallback onTap;

  const BadgePlacesModelBuyer({
    @required this.text,
    @required this.type,
    @required this.onTap,
  });

}

class BadgePlacesBuyer extends StatefulWidget {

  final VoidCallback onTransportationStoreTap;
  final VoidCallback onHumanCapitalTap;
  final VoidCallback onPropertyWarehouseTap;
  final SelectLocationBuyerModel location;

  const BadgePlacesBuyer({
    Key key,
    @required this.location,
    this.onTransportationStoreTap,
    this.onHumanCapitalTap,
    this.onPropertyWarehouseTap,
  }) : super(key: key);

  @override
  _BadgePlacesBuyerState createState() => _BadgePlacesBuyerState();
}

class _BadgePlacesBuyerState extends State<BadgePlacesBuyer> {

  var dataModelResponse = ResponseState<List<BadgePlacesModelBuyer>>();

  @override
  void initState() {
    super.initState();
    fetchCounter();
  }

  Future<void> fetchCounter() async {
    try {
      dataModelResponse = ResponseState.loading();
      setState(() {});
      final body = {
        'DistrictID': widget.location.districtID.toString(),
        'CityID': widget.location.cityID.toString(),
      };
      final response = await Future.wait([
        ApiBuyer(context: context).getCounterPromoIklan(body),
        ApiBuyer(context: context).getCounterIklan(body),
        ApiBuyer(context: context).getPlacesPromo(body),
      ]);
      if (response != null) {
        List<BadgePlacesModelBuyer> result = [];
        if (response[0]['Message']['Code'] == 200 && (response[0]['Data'] is Map)) {
          if ("${response[0]['Data']['transportation_store']}" != "0") {
            result.add(
              BadgePlacesModelBuyer(
                text: "${Utils.delimeter("${response[0]['Data']['transportation_store']}")} Produk Transportation Store",
                type: 0,
                onTap: widget.onTransportationStoreTap,
              ),
            );
          }
          if ("${response[0]['Data']['human_capital']}" != "0") {
            result.add(
              BadgePlacesModelBuyer(
                text: "${Utils.delimeter("${response[0]['Data']['human_capital']}")} Lowongan Kerja",
                type: 0,
                onTap: widget.onHumanCapitalTap,
              ),
            );
          }
          if ("${response[0]['Data']['property_&_warehouse']}" != "0") {
            result.add(
              BadgePlacesModelBuyer(
                text: "${Utils.delimeter("${response[0]['Data']['property_&_warehouse']}")} Gudang dan Peralatan Dijual Disewakan",
                type: 0,
                onTap: widget.onPropertyWarehouseTap,
              ),
            );
          }
        } else {
          // error
          if (response[0]['Message'] != null && response[0]['Message']['Text'] != null) {
            throw("${response[0]['Message']['Text']}");
          }
          throw("failed to fetch data!");
        }
        if (response[1]['Message']['Code'] == 200 && (response[1]['Data'] is Map)) {
          if ("${response[1]['Data']['tsm']['value']}" != "0") {
            result.add(
              BadgePlacesModelBuyer(
                text: "${Utils.delimeter("${response[1]['Data']['tsm']['value']}")} Truk Siap Muat di Big Fleets",
                type: 0,
                onTap: () {},
              ),
            );
          }
          if ("${response[1]['Data']['shipper']['value']}" != "0") {
            result.add(
              BadgePlacesModelBuyer(
                text: "${Utils.delimeter("${response[1]['Data']['shipper']['value']}")} Muatan Siap Diangkut di Big Fleets",
                type: 0,
                onTap: () {},
              ),
            );
          }
        } else {
          // error
          if (response[1]['Message'] != null && response[1]['Message']['Text'] != null) {
            throw("${response[1]['Message']['Text']}");
          }
          throw("failed to fetch data!");
        }
        if (response[2]['Message']['Code'] == 200 && (response[2]['Data'] is Map)) {
          if ("${response[2]['Data']['HargaTransportCount']}" != "0") {
            result.add(
              BadgePlacesModelBuyer(
                text: "${Utils.delimeter("${response[2]['Data']['HargaTransportCount']}")} Truk Siap Muat di Transport Market",
                type: 1,
                onTap: () {},
              ),
            );
          }
          if ("${response[2]['Data']['LelangMuatCount']}" != "0") {
            result.add(
              BadgePlacesModelBuyer(
                text: "${Utils.delimeter("${response[2]['Data']['LelangMuatCount']}")} Kebutuhan Truk di Transport Market",
                type: 1,
                onTap: () {},
              ),
            );
          }
        } else {
          // error
          if (response[2]['Message'] != null && response[2]['Message']['Text'] != null) {
            throw("${response[2]['Message']['Text']}");
          }
          throw("failed to fetch data!");
        }
        dataModelResponse = ResponseState.complete(result);
        setState(() {});
      } else {
        // error
        throw("failed to fetch data!");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      dataModelResponse = ResponseState.error("$error");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dataModelResponse.state == ResponseStates.COMPLETE) {
      final firstRow = dataModelResponse.data.where((e) => e.type == 0).toList();
      final secondRow = dataModelResponse.data.where((e) => e.type == 1).toList();
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(context) * 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                for (int i=0;i<firstRow.length;i++)
                  Container(
                    margin: EdgeInsets.only(
                      right: GlobalVariable.ratioWidth(context) * (i == firstRow.length-1 ? 0 : 4),
                    ),
                    child: _card(firstRow[i]),
                  ),
              ],
            ),
            if (secondRow.isNotEmpty)
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 4,
              ),
            Row(
              children: [
                for (int i=0;i<secondRow.length;i++)
                  Container(
                    margin: EdgeInsets.only(
                      right: GlobalVariable.ratioWidth(context) * (i == secondRow.length-1 ? 0 : 4),
                    ),
                    child: _card(secondRow[i]),
                  ),
              ],
            ),
          ],
        ),
      );
    } else if (dataModelResponse.state == ResponseStates.ERROR) {
      return ErrorDisplayComponent(dataModelResponse.exception, 
        isOnlyButton: true,
        onRefresh: () => fetchCounter(),
      );
    }
    return _loadingWidget();
  }

  Widget _card(BadgePlacesModelBuyer model) {
    return GestureDetector(
      onTap: model.onTap,
      child: Container(
        padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
          color: Color(0xFFE6EAF3),
        ),
        child: CustomText(model.text,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 14.4/12,
          withoutExtraPadding: true,
          color: Color(0xFF002D84),
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(context) * 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                for (int i=0;i<4;i++)
                  Container(
                    width: GlobalVariable.ratioWidth(context) * 100,
                    height: GlobalVariable.ratioWidth(context) * 26,
                    margin: EdgeInsets.only(
                      right: GlobalVariable.ratioWidth(context) * (i == 3 ? 0 : 4),
                    ),
                    color: Colors.white,
                  ),
              ],
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(context) * 4,
            ),
            Row(
              children: [
                for (int i=0;i<3;i++)
                  Container(
                    width: GlobalVariable.ratioWidth(context) * 180,
                    height: GlobalVariable.ratioWidth(context) * 26,
                    margin: EdgeInsets.only(
                      right: GlobalVariable.ratioWidth(context) * (i == 2 ? 0 : 4),
                    ),
                    color: Colors.white,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _moveToPage() async {
    // 1. cek status login
    if (GlobalVariable.tokenApp != null && GlobalVariable.tokenApp.isNotEmpty) {
      // kondisi sudah login
      // 2. cek user status
      try {
        final response = await ApiProfile(
          context: context,
          isShowDialogLoading: true,
          isShowDialogError: true,
        ).getUserStatus({});
        if (
          response != null 
          && response['Data'] != null
          && response['Data']['UserLevel'] != null
        ) {
          // jika userLevel != 2/-2/3
          if (
            "${response['Data']['UserLevel']}" == "0"
            || "${response['Data']['UserLevel']}" == "1"
            || "${response['Data']['UserLevel']}" == "2"
          ) {
            showDialogBelumLogin(() {
              // cek jika user masih belum verifikasi
              if ("${response['Data']['UserLevel']}" == "2" && response['Data']['ShipperIsVerifBF'] == "-1") {
                // muncul popup masih dalam tahap verifikasi.
              }
            });
          } else {
            // 3. redirect ke spesific page
          }
        }
      } catch (e) {

      }
    } else {
      // kondisi belum login
      showDialogBelumLogin(() {
        
      });
    }
  }

  void showDialogBelumLogin(VoidCallback onTap) {
    GlobalAlertDialog.showAlertDialogCustom(
      context: context,
      title: "Pemberitahuan",
      message: "Untuk dapat melihat daftar Truk Siap Muat di Big Fleets, Anda harus mendaftarkan diri terlebih dahulu sebagai Shipper pada fitur Big Fleets. Ayo segera daftarkan diri Anda",
      onTapPriority1: Get.back,
      labelButtonPriority1: "Tidak",
      labelButtonPriority2: "Daftar",
      onTapPriority2: onTap,
    );
  }

}