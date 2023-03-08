import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/detail/rules_detail_iklan_buyer.dart';
import 'package:muatmuat/app/template/appbar/appbar_detail_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_title_compro_detail_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_title_compro_buyer.dart';
import 'package:muatmuat/app/template/widgets/carousel_image/carousel_image_buyer.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';

import '../../../../global_variable.dart';
import '../rules_buyer.dart';
import 'detail_iklan_controller.dart';

class DetailIklanComproView extends StatefulWidget {
  @override
  _DetailIklanComproViewState createState() => _DetailIklanComproViewState();
}

class _DetailIklanComproViewState extends State<DetailIklanComproView> {
  final controller = Get.put(DetailIklanController(), 
    tag: "${UniqueKey()}",
  );

  @override
  void initState() {
    super.initState();
    controller.args.value = Get.arguments;
    controller.fetchDataDetailIklan();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBarDetailBuyer(
        onClickBack: Get.back,
        title: "Detail",
        onClickFavorite: controller.addToWishlist,
        favorite: controller.isFavorite.value,
        onClickShare: controller.shareLink,
      ),
      body: Obx(() {
        if (controller.dataModelResponse.value.state ==
            ResponseStates.COMPLETE) {
          final data = controller.dataModelResponse.value.data;
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchDataDetailIklan();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RulesDetailIklanBuyer.getDetailWidgetBySubKategoriId(
                    context: context, 
                    layananId: "${controller.layananId}",
                    kategoriId: "${controller.args.value['KategoriID']}",
                    subKategoriId: "${controller.args.value['SubKategoriID']}", 
                    comproId: "${data['ID']}", 
                    data: data,
                  ),
                ],
              ),
            ),
          );
        } else if (controller.dataModelResponse.value.state ==
            ResponseStates.ERROR) {
          return ErrorDisplayComponent(
            "${controller.dataModelResponse.value.exception}",
            onRefresh: () => controller.fetchDataDetailIklan(),
          );
        }
        return LoadingComponent();
      }),
    ));
  }
}
