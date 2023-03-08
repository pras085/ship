import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/list_iklan/list_iklan_places_promo_view.dart';
import 'package:muatmuat/app/modules/buyer/rules_buyer.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_model.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_view.dart';
import 'package:muatmuat/app/template/widgets/halaman_awal/halaman_awal_buyer.dart';
import 'package:muatmuat/app/template/widgets/navbar/navbar.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';

import '../list_iklan/list_iklan_view.dart';
import 'halaman_awal_controller.dart';
import '../selected_location_controller.dart';

class BuyerArgs {

  final int id;
  final String menuName;

  BuyerArgs({
    this.id,
    this.menuName,
  });

}

class HalamanAwalView extends StatefulWidget {

  @override
  _HalamanAwalViewState createState() => _HalamanAwalViewState();
}

class _HalamanAwalViewState extends State<HalamanAwalView> {

  // initiate for the first time
  // put at here, Get.find in other screen that accessed from this screen.
  final locationController = Get.put(SelectedLocationController());

  final controller = Get.put(HalamanAwalController());
  BuyerArgs args;

  @override
  void initState() {
    super.initState();
    args = Get.arguments as BuyerArgs;
    controller.layananId.value = "${args.id}";
    controller.fetchSubCategory();
  }

  @override
  void dispose() {
    // close when the screen disposed.
    locationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ListColor.colorBlueTemplate),
      body: Obx(() {
        if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
          final dataList = controller.dataModelResponse.value.data.data.dataLayanan;
          return Obx(() => HalamanAwalBuyer(
            title: args.menuName,
            image: Image.asset(RulesBuyer.getAssetImageForLanding(args.id, args.menuName),
              fit: BoxFit.cover,
            ),
            onBack: Get.back,
            location: locationController.location.value != null ? locationController.location.value.description : "Indonesia", /// location based from action [onLocationTap]
            onLocationTap: () async {
              final res = await Get.to(SelectLocationBuyerView());
              if (res != null && res is SelectLocationBuyerModel) {
                locationController.location.value = res;
              } else if (res != null && res is int) {
                locationController.location.value = null;
              }
            }, /// action when button location was tapped.
            children: dataList.map((e) {
              return ItemMenuHalamanAwalBuyer(
                context: context,
                image: Image.network(e.icon),
                menuTitle: "${e.nama}",
                onTap: () async {
                  final dataArgs = {
                    'layanan': controller.layananId.value,
                    'kategori': args.menuName,
                    'subKategori': e.nama,
                    ...e.toJson(),
                  };
                  await Get.to(controller.layananId.value == "10" ? ListIklanPlacesPromoView() : ListIklanView(),
                    arguments: dataArgs,
                  );
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                },
              );
            }).toList(),
          ));
        } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
          return ErrorDisplayComponent("${controller.dataModelResponse.value.exception}",
            onRefresh: () => controller.fetchSubCategory(),
          );
        }
        return LoadingComponent();
      }),
      /// [ctrl+click] on Navbar to read the documentation.
      bottomNavigationBar: Navbar(
        onTap1: () {},
        onTap2: () {},
        onTap3: () {},
        onTap4: () {},
        selectedIndex: 0,
      ),
    );
  }
}