import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/app/modules/buyer/barang_lainnya/barang_lainnya_view.dart';
import 'package:muatmuat/app/modules/buyer/list_iklan/list_iklan_controller.dart';
import 'package:muatmuat/app/modules/buyer/rules_buyer.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/global_variable.dart';

class KatalogProdukDetailBuyer extends StatefulWidget {

  final Map args;

  const KatalogProdukDetailBuyer({
    Key key,
    @required this.args,
  }) : super(key: key);

  @override
  State<KatalogProdukDetailBuyer> createState() => _KatalogProdukDetailBuyerState();
}

class _KatalogProdukDetailBuyerState extends State<KatalogProdukDetailBuyer> {

  Map args;
  var dataModelResponse = ResponseState<List>();

  @override
  void initState() {
    super.initState();
    args = widget.args;
    fetchDataIklan();
  }

  void fetchDataIklan() async {
    try {
      setState(() {
        dataModelResponse = ResponseState.loading();      
      });
      // ensure argument is not null, initialize on "onInit" func in view
      final body = {
        'KategoriID': "${args['KategoriID']}",
        'SubKategoriID': "${args['SubKategoriID']}",
        'search': '',
        'limit': "10",
        'pageNow': "1",
        'isKatalog': "1",
        'CompanyProfileID': "${args['ComproID']}",
      };

      final response = await ApiBuyer(context: context).getData(body);
      if (response != null) {
        if (response['Message']['Code'] == 200 && (response['Data'] is Iterable)) {
          // sukses
          dataModelResponse = ResponseState.complete(response['Data']);
          setState(() {});
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
      dataModelResponse = ResponseState.error("$error");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return !(dataModelResponse.state == ResponseStates.COMPLETE && dataModelResponse.data.isNotEmpty) ? SizedBox.shrink() : Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 16,
          ),
          child: Row(
            children: [
              CustomText(
                "Katalog Produk",
                fontWeight: FontWeight.w600,
                fontSize: 16,
                withoutExtraPadding: true,
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // revert version from list_iklan_controller.dart
                  String subKategoriId = "${args['SubKategoriID']}";
                  if (subKategoriId == "23") {
                    subKategoriId = "24";
                  }
                  else if (subKategoriId == "25") {
                    subKategoriId = "26";
                  }
                  Get.to(
                    () => BarangLainnyaView(), 
                    arguments: {
                      'LayananID': "${args['layanan']}",
                      'KategoriID': "${args['KategoriID']}",
                      'SubKategoriID': subKategoriId,
                      'title': 'Katalog Produk',
                      'Data': args['data'],
                    }
                  );
                },
                child: CustomText(
                  "Lihat Selengkapnya",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  withoutExtraPadding: true,
                  color: Color(ListColor.colorBlueTemplate1),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
        Container(
          padding: EdgeInsets.only(
            left: GlobalVariable.ratioWidth(context) * 16,
          ),
          child: Builder(
            builder: (ctx) {
              if (dataModelResponse.state == ResponseStates.COMPLETE) {
                return dataModelResponse.data.isEmpty ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset("assets/empty_result_buyer.svg",
                        width: GlobalVariable.ratioWidth(context) * 120,
                        height: GlobalVariable.ratioWidth(context) * 120,
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 16,
                      ),
                      CustomText("Tidak ada iklan tersedia!",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 16.8/14,
                        withoutExtraPadding: true,
                      ),
                    ],
                  ),
                ) : 
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: dataModelResponse.data.map((e) {
                      int i = dataModelResponse.data.indexOf(e);
                      final data = dataModelResponse.data[i];

                      // revert version from list_iklan_controller.dart
                      String subKategoriId = "${args['SubKategoriID']}";
                      if (subKategoriId == "23") {
                        subKategoriId = "24";
                      }
                      else if (subKategoriId == "25") {
                        subKategoriId = "26";
                      }
                      return Container(
                        width: GlobalVariable.ratioWidth(context) * 156,
                        margin: EdgeInsets.only(
                          right: GlobalVariable.ratioWidth(context) * i != dataModelResponse.data.length ? 8 : 0,
                        ),
                        child: RulesBuyer.getCardDataKey(
                          kategoriId: "${args['KategoriID']}",
                          subKategoriId: subKategoriId,
                          data: data,
                          onFavorited: () {
                            addToWishlistBuyer(
                              body: {
                                'KategoriID': "${args['KategoriID']}",
                                'SubKategoriID': subKategoriId,
                                'IklanID': "${data['ID']}",
                                'isWishList': data['favorit'] == "1" ? "0" : "1",
                                'UserID': GlobalVariable.userModelGlobal.docID
                              },
                              onSuccess: () {
                                data['favorit'] = data['favorit'] == "1" ? "0" : "1";
                                setState(() {});
                              },
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              } else if (dataModelResponse.state == ResponseStates.ERROR) {
                return ErrorDisplayComponent(
                  "${dataModelResponse.exception}",
                  onRefresh: () => fetchDataIklan(),
                );
              }
              return LoadingComponent();
            },
          ),
        ),
        // Container(
        //   padding: EdgeInsets.only(
        //     left: GlobalVariable.ratioWidth(context) * 16,
        //   ),
        //   height: GlobalVariable.ratioWidth(context) * 392.5,
        //   child: Builder(
        //     builder: (ctx) {
        //       if (dataModelResponse.state == ResponseStates.COMPLETE) {
        //         return dataModelResponse.data.isEmpty ? Center(
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               SvgPicture.asset("assets/empty_result_buyer.svg",
        //                 width: GlobalVariable.ratioWidth(context) * 120,
        //                 height: GlobalVariable.ratioWidth(context) * 120,
        //               ),
        //               SizedBox(
        //                 height: GlobalVariable.ratioWidth(context) * 16,
        //               ),
        //               CustomText("Tidak ada iklan tersedia!",
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.w600,
        //                 textAlign: TextAlign.center,
        //                 height: 16.8/14,
        //                 withoutExtraPadding: true,
        //               ),
        //             ],
        //           ),
        //         ) : ListView.builder(
        //           padding: EdgeInsets.only(
        //             right: GlobalVariable.ratioWidth(context) * 16,
        //           ),
        //           scrollDirection: Axis.horizontal,
        //           itemCount: dataModelResponse.data.length,
        //           itemBuilder: (ctx, i) {
        //             final data = dataModelResponse.data[i];
        //             // revert version from list_iklan_controller.dart
        //             String subKategoriId = "${args['SubKategoriID']}";
        //             if (subKategoriId == "23") {
        //               subKategoriId = "24";
        //             }
        //             else if (subKategoriId == "25") {
        //               subKategoriId = "26";
        //             }
        //             return Container(
        //               width: GlobalVariable.ratioWidth(context) * 156,
        //               margin: EdgeInsets.only(
        //                 right: GlobalVariable.ratioWidth(context) * i != dataModelResponse.data.length ? 8 : 0,
        //               ),
        //               child: RulesBuyer.getCardDataKey(
        //                 kategoriId: "${args['KategoriID']}",
        //                 subKategoriId: subKategoriId,
        //                 data: data,
        //                 onFavorited: () {},
        //               ),
        //             );
        //           },
        //         );
        //       } else if (dataModelResponse.state == ResponseStates.ERROR) {
        //         return ErrorDisplayComponent(
        //           "${dataModelResponse.exception}",
        //           onRefresh: () => fetchDataIklan(),
        //         );
        //       }
        //       return LoadingComponent();
        //     },
        //   ),
        // ),
        SizedBox(
          height: GlobalVariable.ratioWidth(context) * 24,
        ),
      ],
    );
  }

}