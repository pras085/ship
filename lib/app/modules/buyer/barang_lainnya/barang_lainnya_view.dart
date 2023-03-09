import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/list_iklan/list_iklan_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/dialog/dialog_buyer.dart';
import 'package:muatmuat/app/template/otherproduct/other_product.dart';
import 'package:muatmuat/app/template/widgets/appbar/appbar_other_products.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../global_variable.dart';
import '../rules_buyer.dart';
import 'barang_lainnya_controller.dart';

class BarangLainnyaView extends StatefulWidget {
  @override
  _BarangLainnyaViewState createState() => _BarangLainnyaViewState();
}

class _BarangLainnyaViewState extends State<BarangLainnyaView> {
  final controller = Get.put(BarangLainnyaController(), 
    tag: "${UniqueKey()}",
  );

  @override
  void initState() {
    super.initState();
    controller.args.value = Get.arguments;
    controller.fetchDataBarangSeller();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var namaSeller = controller.args['Data']['data_seller']['nama_indidivu_perusahaan'];
    if(
      controller.args['SubKategoriID'] == '13' // Repair & Maintenance | Proulk Lainnya
    ){
      namaSeller = controller.args['Data']['data_seller']['nama_seller'];
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBarOtherProducts(
          onClickBack: Get.back,
          title: controller.args['title'] ?? "Barang Lainnya Dari Penjual"
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return OtherProduct(
                urlimg: controller.args['Data']['data_seller']['image_seller'], 
                headertext: namaSeller ?? controller.args['Data']['data_seller']['nama_individu_perusahaan'], 
                isVerified: controller.args['Data']['data_seller']['verified'] == 1, 
                joined: controller.args['Data']['data_seller']['anggota_sejak'], 
                ontap: () => DialogBuyer.showCallBottomSheet(listData: controller.args['Data'])
              );
            }),
            Container(
              height: GlobalVariable.ratioWidth(context) * 5,
              color: Color(ListColor.colorBgTemplate),
            ),
            SizedBox(height: GlobalVariable.ratioWidth(context) * 24),
            Padding(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(context) * 16
              ),
              child: CustomText(
                'Barang Dari Penjual',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
            Expanded(
              child: Obx(() {
                return SmartRefresher(
                  enablePullUp: true,
                  controller: controller.refreshController,
                  onLoading: controller.dataModelResponse.value.state == ResponseStates.COMPLETE && controller.dataList.value.isNotEmpty ? () {
                    controller.fetchDataBarangSeller(
                      refresh: false,
                    );
                  } : null,
                  onRefresh: controller.dataModelResponse.value.state == ResponseStates.COMPLETE ? () {
                    controller.fetchDataBarangSeller();
                  } : null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() {
                        if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
                          final dataList = controller.dataList.value;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // LIST PRODUCT
                              if (dataList.isEmpty)
                                Container(
                                  width: GlobalVariable.ratioWidth(context) * 328,
                                  // height: GlobalVariable.ratioWidth(context) * 153,
                                  constraints: BoxConstraints(
                                    minHeight: GlobalVariable.ratioWidth(context) * 153,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: GlobalVariable.ratioWidth(context) * 16,
                                    vertical: GlobalVariable.ratioWidth(context) * 0,
                                  ),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset("assets/empty_result_buyer.svg",
                                        width: GlobalVariable.ratioWidth(context) * 120,
                                        height: GlobalVariable.ratioWidth(context) * 120,
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: GlobalVariable.ratioWidth(context) * 16,
                                    vertical: GlobalVariable.ratioWidth(context) * 10,
                                  ),
                                  child: StaggeredGrid.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: GlobalVariable.ratioWidth(context) * 10,
                                    crossAxisSpacing: GlobalVariable.ratioWidth(context) * 16,
                                    children: [
                                      for (int i=0;i<dataList.length;i++)
                                        RulesBuyer.getCardDataKey(
                                          kategoriId: controller.args['KategoriID'],
                                          subKategoriId: controller.args['SubKategoriID'],
                                          data: dataList[i],
                                          onFavorited: () {
                                            String subKategoriId = "${controller.args.value['ID']}";
                                            if ("$subKategoriId" == "24") {
                                              subKategoriId = "23";
                                            }
                                            else if ("$subKategoriId" == "26") {
                                              subKategoriId = "25";
                                            }
                                            addToWishlistBuyer(
                                              body: {
                                                'KategoriID': "${controller.args.value['KategoriID']}",
                                                'SubKategoriID': "$subKategoriId",
                                                'IklanID': dataList[i]['ID'],
                                                'isWishList': dataList[i]['favorit'] == "1" ? "0" : "1",
                                                'UserID': GlobalVariable.userModelGlobal.docID
                                              },
                                              onSuccess: () {
                                                dataList[i]['favorit'] = dataList[i]['favorit'] == "1" ? "0" : "1";
                                                controller.dataList.refresh();
                                              },
                                            );
                                          }
                                        ),
                                    ],
                                  ),
                                ),
                            ],
                          );
                        } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: GlobalVariable.ratioWidth(context) * 150,
                            ),
                            child: ErrorDisplayComponent("${controller.dataModelResponse.value.exception}",
                              onRefresh: () => controller.fetchDataBarangSeller(),
                            ),
                          );
                        }
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: GlobalVariable.ratioWidth(context) * 150,
                          ),
                          child: LoadingComponent(),
                        );
                      }),
                    ],
                  ),
                );
              }),
            )
          ],
        )
      ),
    );
  }
}
