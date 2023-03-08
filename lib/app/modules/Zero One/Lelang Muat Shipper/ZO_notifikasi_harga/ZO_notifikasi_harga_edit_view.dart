import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_notifikasi_harga_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_edit_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_app_bar.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_form_card.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_info.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_list_card.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoNotifikasiHargaEditView
    extends GetView<ZoNotifikasiHargaEditController> {
  final ZoNotifikasiHargaModel data;
  const ZoNotifikasiHargaEditView({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   controller.initFieldsForEdit(data);
    // });
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
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(context) * 16,
              vertical: GlobalVariable.ratioWidth(context) * 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ZoNotifikasiHargaFormCard(
                  controller: controller,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
