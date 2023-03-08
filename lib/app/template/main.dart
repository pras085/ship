import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/template/media_preview/media_preview_buyer.dart';
import 'package:muatmuat/app/template/dialog/dialog_buyer.dart';
import 'package:muatmuat/app/template/example/example_card_product.dart';
import 'package:muatmuat/app/template/example/example_checkbox_buyer/example_checkbox_buyer_view.dart';
import 'package:muatmuat/app/template/example/example_detai_laporkan/example_detail_laporkan.dart';
import 'package:muatmuat/app/template/example/example_detail_buyer_product/example_detail_buyer_product_view.dart';
import 'package:muatmuat/app/template/example/example_detail_card/example_detail_all_card.dart';
import 'package:muatmuat/app/template/example/example_detail_card/example_detail_card_desc.dart';
import 'package:muatmuat/app/template/example/example_detail_expansion_buyer/example_detail_expansion_buyer.dart';
import 'package:muatmuat/app/template/dropdown/refo_widget.dart';
import 'package:muatmuat/app/template/otherproduct/other_product.dart';
import 'package:muatmuat/app/template/similiarads/similar_ads.dart';
import '../../global_variable.dart';
import 'example/example_checkbox_buyer/example_checkbox_buyer_controller.dart';
import 'example/example_detai_laporkan/example_detail_laporkan_controller.dart';
import 'example/example_detail_buyer_product/example_detail_buyer_product_controller.dart';
import 'example/example_detail_card/example_detail_card.dart';
import 'example/example_halaman_awal_buyer.dart';
import 'example/example_detail_profile_buyer/example_detail_profile_buyer.dart';
import 'package:muatmuat/global_variable.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<WidgetMenuModel> listMenuResult = [];

  // PLACE YOUR WIDGET HERE
  List<WidgetMenuModel> get listMenu => [
        WidgetMenuModel(
          id: 0,
          name: "Halaman Awal",
          onTap: () {
            Get.to(() => ExampleHalamanAwalBuyer());
          },
        ),
        WidgetMenuModel(
          id: 1,
          name: "Filter Checkbox",
          onTap: () {
            Get.to(
              () => ExampleCheckboxBuyerView(),
              binding: ExampleCheckboxBuyerBinding(),
            );
          },
        ),
        WidgetMenuModel(
          id: 2,
          name: "Dialog Sortir Vertikal",
          onTap: showExampleSortingDialog,
        ),
        WidgetMenuModel(
          id: 3,
          name: "Dialog Detail",
          onTap: () {
            DialogBuyer.detail(
              context: context,
              title: "Rute yang dilayani",
              listDetail: [
                "Surabaya",
                "Sidoarjo",
                "Kediri",
                "Malang",
                "Malang",
                "Malang",
                "Malang",
              ],
            );
          },
        ),
        WidgetMenuModel(
          id: 4,
          name: "Card Product",
          onTap: () => Get.to(() => ExampleCardProductBuyer()),
        ),
        WidgetMenuModel(
          id: 5,
          name: "Detail Product Buyer",
          onTap: () => Get.to(
            () => ExampleDetailProductBuyer(),
            binding: ExampleDetailProductBuyerBinding(),
          ),
        ),
        WidgetMenuModel(
          id: 6,
          name: "Bottom Sheet Hubungi",
          onTap: () => DialogBuyer.showCallBottomSheet(),
        ),
        WidgetMenuModel(
          id: 7,
          name: "Laporkan Iklan Buyer",
          onTap: () => Get.to(
            () => ExampleDetailLaporkanView(),
            binding: ExampleDetailLaporkanBindings(),
          ),
        ),
        WidgetMenuModel(
          id: 8,
          name: "Detail Expansion",
          onTap: () => Get.to(() => ExampleDetailExpansionBuyer()),
        ),
        WidgetMenuModel(
          id: 9,
          name: "Detail Profile",
          onTap: () => Get.to(() => ExampleDetailProfileBuyer()),
        ),
        WidgetMenuModel(
          id: 10,
          name: "Dropdown Filter",
          onTap: () => Get.to(() => RefoWidget()),
        ),
        WidgetMenuModel(
          id: 11,
          name: "Detail Card Scroll",
          onTap: () => Get.to(() => ExampleDetailCard()),
        ),
        WidgetMenuModel(
          id: 11,
          name: "Lihat Barang Lainnya",
          onTap: () => Get.to(() => OtherProduct(
                urlimg: 'https://internalqc.assetlogistik.com//public//assets//media//company_logo//1263-20230124212049-company_logo.jpg',
                headertext: 'PT Siba Rembulan',
                joined: '2021',
                ontap: (){print('hello');},
              )),
          // onTap: () => Get.to(() => MapGlobal(), binding: MapGlobalBinding(), arguments: [[1,'Surabaya', 'Jawa Timur'],[2,'Gresik', 'Jawa Timur'],[3,'Surakarta', 'Jawa Timur'],[4, 'Surajaya', 'Jawa Timur'],[5, 'Suraya', 'Jawa Timur'], [6, 'Suraningrat', 'Jawa Tengah']]),
        ),
        WidgetMenuModel(
          id: 12,
          name: "Iklan Serupa",
          onTap: () => Get.to(() => SimilarAds()),
          // onTap: () => Get.to(() => MapGlobal(), binding: MapGlobalBinding(), arguments: [[1,'Surabaya', 'Jawa Timur'],[2,'Gresik', 'Jawa Timur'],[3,'Surakarta', 'Jawa Timur'],[4, 'Surajaya', 'Jawa Timur'],[5, 'Suraya', 'Jawa Timur'], [6, 'Suraningrat', 'Jawa Tengah']]),
        ),
        // WidgetMenuModel(
        //   id: 12,
        //   name: "Lihat Gambar",
        //   onTap: () => Get.to(() => MediaPreviewBuyerMultiple()),
        // ),
        WidgetMenuModel(
          id: 13,
          name: "Detail Card Show All",
          onTap: () => Get.to(() => ExampleDetailAllCard()),
        ),
        WidgetMenuModel(
          id: 14,
          name: "Detail With Desc",
          onTap: () => Get.to(() => ExampleDetailCardDescView()),
        ),
      ];

  @override
  void initState() {
    super.initState();
    listMenuResult = [...listMenu];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Template Widget Buyer"),
      ),
      body: Padding(
        padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "search widget here ... ",
              ),
              onChanged: (val) {
                listMenuResult = listMenu.where((e) => e.name.toLowerCase().contains(val.toLowerCase())).toList();
                setState(() {});
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listMenuResult.length,
                itemBuilder: (c, i) {
                  return Card(
                    child: ListTile(
                      title: Text("${listMenuResult[i].name}"),
                      onTap: listMenuResult[i].onTap,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // EXAMPLE USAGE FOR SORTING FILTER
  void showExampleSortingDialog() {
    // DUMMY LIST, CHANGE THE DATA ACCORDING TO THE API.
    final List<Map<String, dynamic>> listSorting = [
      {
        'name': "Waktu Dibuat",
        'child': [
          {'id': "terbaru", 'name': "Terbaru"},
          {'id': "terlama", 'name': "Terlama"},
        ],
      },
      {
        'name': "Harga",
        'child': [
          {'id': "tertinggi", 'name': "Tertinggi"},
          {'id': "terendah", 'name': "Terendah"},
        ],
      },
      {
        'name': "Tahun",
        'child': [
          {'id': "tahunTerbaru", 'name': "Terbaru"},
          {'id': "tahunTerlama", 'name': "Terlama"},
        ],
      },
    ];
    // call the class
    DialogBuyer.sorting(
      context: context,
      onReset: () {}, // when reset button was tapped
      itemCount: listSorting.length, // the length of list sorting from api
      itemBuilder: (c, i) {
        // builder, to build the item.
        return SortingTileDialogBuyer(
          context: context,
          label: listSorting[i]['name'],
          childCount: (listSorting[i]['child'] as List).length,
          childBuilder: (_, idx) {
            // Start to render the view for radio button and its label.
            final o = (listSorting[i]['child'] as List)[idx];
            return SortingTileContentDialogBuyer(
              context: context,
              groupValue: "terbaru", // newest value, change this with your variable
              value: o['id'], // default value for each radio button.
              text: o['name'], // label for the item.
              onTap: () {
                // example onSelect
                // yourVariabel = o['id'];
                Get.back(); // close the dialog immediately after click/update the value.
              },
            );
          },
        );
      },
    );
  }
}

class WidgetMenuModel {
  int id;
  String name;
  VoidCallback onTap;

  WidgetMenuModel({
    this.id,
    this.name,
    this.onTap,
  });
}

class ExampleCheckboxBuyerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExampleCheckboxBuyerController());
  }
}

class ExampleDetailLaporkanBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ExampleDetailLaporkanController());
  }
}

class ExampleDetailProductBuyerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExampleDetailProductBuyerController());
  }
}
