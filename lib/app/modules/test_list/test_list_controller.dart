import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';

class TestListController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController tabController;

  final mitraModelExample = MitraModel.fromJson({
    'DocID': '1',
    'Transporter': 'PT Transporter',
    'TransporterKota': 'Surabaya',
    'AreaLayanan': 'Surabaya, Malang',
    'QtyAreaLayanan': '2',
  }).obs;

  final isTabDesign1 = true.obs;
  final isTabDesign2 = false.obs;
  final listMitra = [].obs;

  final mitraTileKey = GlobalKey().obs;

  final widthMitraTile = 0.0.obs;
  final heightMitraTile = 0.0.obs;

  final isShowMitraTileKey = true.obs;

  bool _isCompleteBuild = false;

  @override
  void onInit() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() {
      isTabDesign1.value = tabController.index == 0;
      isTabDesign2.value = tabController.index == 1;
      listMitra.refresh();
    });
    listMitra.addAll([
      MitraModel.fromJson({
        'DocID': '1',
        'Transporter': 'PT Transporter',
        'TransporterKota': 'Surabaya',
        'AreaLayanan': 'Surabaya, Malang',
        'QtyAreaLayanan': '2',
      }),
      MitraModel.fromJson({
        'DocID': '2',
        'Transporter': 'PT Transporter 2',
        'TransporterKota': 'Malang',
        'AreaLayanan': 'Gresik, Malang',
        'QtyAreaLayanan': '2',
      }),
      MitraModel.fromJson({
        'DocID': '2',
        'Transporter': 'PT Transporter 2',
        'TransporterKota': 'Malang',
        'AreaLayanan': 'Gresik, Malang',
        'QtyAreaLayanan': '2',
      }),
      MitraModel.fromJson({
        'DocID': '2',
        'Transporter': 'PT Transporter 2',
        'TransporterKota': 'Malang',
        'AreaLayanan': 'Gresik, Malang',
        'QtyAreaLayanan': '2',
      }),
      MitraModel.fromJson({
        'DocID': '2',
        'Transporter': 'PT Transporter 2',
        'TransporterKota': 'Malang',
        'AreaLayanan': 'Gresik, Malang',
        'QtyAreaLayanan': '2',
      }),
      MitraModel.fromJson({
        'DocID': '2',
        'Transporter': 'PT Transporter 2',
        'TransporterKota': 'Malang',
        'AreaLayanan': 'Gresik, Malang',
        'QtyAreaLayanan': '2',
      }),
      MitraModel.fromJson({
        'DocID': '2',
        'Transporter': 'PT Transporter 2',
        'TransporterKota': 'Malang',
        'AreaLayanan': 'Gresik, Malang',
        'QtyAreaLayanan': '2',
      }),
      MitraModel.fromJson({
        'DocID': '2',
        'Transporter': 'PT Transporter 2',
        'TransporterKota': 'Malang',
        'AreaLayanan': 'Gresik, Malang',
        'QtyAreaLayanan': '2',
      }),
      MitraModel.fromJson({
        'DocID': '2',
        'Transporter': 'PT Transporter 2',
        'TransporterKota': 'Malang',
        'AreaLayanan': 'Gresik, Malang',
        'QtyAreaLayanan': '2',
      })
    ]);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  onCompleteBuildWidget() async {
    if (!_isCompleteBuild) {
      _isCompleteBuild = true;

      //getAllMitra(0);
    }
    final renderBox =
        mitraTileKey.value.currentContext.findRenderObject() as RenderBox;
    widthMitraTile.value = renderBox.size.width;
    heightMitraTile.value = renderBox.size.height;
    isShowMitraTileKey.value = false;
    listMitra.refresh();
  }
}
