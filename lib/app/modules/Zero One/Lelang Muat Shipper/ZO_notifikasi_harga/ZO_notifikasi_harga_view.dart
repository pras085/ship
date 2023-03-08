import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_app_bar.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_form_card.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_info.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_list_card.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoNotifikasiHargaView extends GetView<ZoNotifikasiHargaController> {
  const ZoNotifikasiHargaView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Color(ListColor.colorBlack).withOpacity(0.15),
            backgroundColor: Color(ListColor.colorWhite),
            automaticallyImplyLeading: false,
            leading: null,
            title: null,
            toolbarHeight: GlobalVariable.ratioWidth(context) * 56,
            flexibleSpace: ZoNotifikasiHargaAppBar(
              controller: controller,
            ),
          ),
          body: RefreshIndicator(
            onRefresh: controller.onViewRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(context) * 16,
                vertical: GlobalVariable.ratioWidth(context) * 20,
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (controller.isEditPage.isFalse) ...[
                      const ZoNotifikasiHargaInfo(),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 24,
                      ),
                    ],
                    ZoNotifikasiHargaFormCard(
                      controller: controller,
                    ),
                    if (controller.isEditPage.isFalse) ...[
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 24,
                      ),
                      const ZoNotifikasiHargaListCard(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
