import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/change_language.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/intro_shipper/intro_controller.dart';
import 'package:muatmuat/app/modules/intro_shipper/intro_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../../global_variable.dart';

Widget popupcustom(BuildContext context) {
  return Container(
      height: GlobalVariable.ratioWidth(context) * 10,
      width: GlobalVariable.ratioWidth(context) * 10,
      color: Colors.transparent);
}

contentoption(context) {
  return CircularProgressIndicator();
}

class SimpleSnappingSheet extends StatelessWidget {
  final ScrollController listViewController = new ScrollController();
  final _keyDialog = new GlobalKey<State>();
  var isLoading = true.obs;
  var loadChangeLanguage = false.obs;

  @override
  Widget build(BuildContext context) {
    final IntroShipperController introcontroller = Get.find();
    // ChangeLanguage changeLanguage = ChangeLanguage(context);
    return SnappingSheet(
      controller: introcontroller.snapcontroller,
      onSheetMoved: (sheetPosition) {
        print('oSheetMoved');
        print('current position ${sheetPosition.pixels}');
        sheetPosition.pixels < 0
            ? introcontroller.showlan()
            : print('not changing stat');
      },
      onSnapCompleted: (sheetPosition, snappingPosition) {
        print('onSnapCompleted');
        print('current position ${sheetPosition.pixels}');
        print('current snapping position ${snappingPosition.toString()}');
        // sheetPosition.pixels < 0 ?
        // introcontroller.showlan() : print('not changing stat');
      },
      onSnapStart: (sheetPosition, snappingPosition) {
        print('current position ${sheetPosition.pixels}');
        print('current snapping position ${snappingPosition.toString()}');
      },
      lockOverflowDrag: true,
      initialSnappingPosition: SnappingPosition.factor(
        snappingCurve: Curves.elasticOut,
        snappingDuration: Duration(milliseconds: 1750),
        positionFactor: 0.50,
      ),
      snappingPositions: const [
        SnappingPosition.factor(
          positionFactor: -1.1,
          snappingCurve: Curves.easeOutExpo,
          snappingDuration: Duration(seconds: 1),
          grabbingContentOffset: GrabbingContentOffset.top,
        ),
        SnappingPosition.factor(
          snappingCurve: Curves.elasticOut,
          snappingDuration: Duration(milliseconds: 1750),
          positionFactor: 0.50,
        ),
      ],
      grabbing: GrabbingWidget(),
      grabbingHeight: 32,
      sheetAbove: null,
      sheetBelow: SnappingSheetContent(
        draggable: true,
        // childScrollController: listViewController,
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(context) * 10,
                      left: GlobalVariable.ratioWidth(context) * 16,
                      bottom: GlobalVariable.ratioWidth(context) * 12),
                  child: CustomText(
                    'Ubah Bahasa',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(ListColor.colorBlack),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(context) * 16,
                      bottom: GlobalVariable.ratioWidth(context) * 16.85),
                  child: CustomText(
                    'Pilih bahasa yang kamu gunakan',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF676767),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(context) * 16,
                      bottom: GlobalVariable.ratioWidth(context) * 8), //14
                  child: Row(
                    children: [
                      Container(
                        height: GlobalVariable.ratioWidth(context) * 16,
                        width: GlobalVariable.ratioWidth(context) * 16,
                        child: Image.asset('assets/indo.png'),
                      ),
                      SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                      Container(
                          height: GlobalVariable.ratioWidth(context) * 17,
                          width: GlobalVariable.ratioWidth(context) * 119,
                          child: Center(
                              child: CustomText(
                            'Bahasa Indonesia',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorBlack),
                          ))),
                      SizedBox(width: GlobalVariable.ratioWidth(context) * 160),
                      Obx(
                        () => RadioButtonCustom(
                            width: GlobalVariable.ratioWidth(context) * 15.57,
                            height: GlobalVariable.ratioWidth(context) * 15.57,
                            isWithShadow: true,
                            groupValue: introcontroller.selectedLang.toString(),
                            value: introcontroller.indo.value,
                            onChanged: (value) async {
                              introcontroller.selectedLang.value = value;
                              introcontroller.chglan.value = true;
                              introcontroller.clearslide();

                              //  introcontroller.chglan.value = false;
                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return popupcustom(context);
                              //       // .popupgoldtransporter(context, '', '');
                              //       // return CustomDialog()
                              //       //     .contentTransportMarket(context);
                              //     });
                              await changeLanguage(
                                  'id', 'id_ID', 'Indonesia', introcontroller);
                              // var response = await ApiHelper(
                              //         context: Get.context,
                              //         isShowDialogLoading: false)
                              //     .getOnBoardid();
                              // if (response != null) {
                              //   final message = MessageFromUrlModel.fromJson(
                              //       response["Message"]);
                              //   if (message != null && message.code == 200) {
                              //     introcontroller.slideIndex.value = 0;
                              //     for (var data in response["Data"]) {
                              //       introcontroller.listSlides.add(
                              //         IntroModelShipper(
                              //           data['Title'],
                              //           data['Description'],
                              //           data['Icon'],
                              //         ),
                              //       );
                              //     }
                              //   } else {}
                              //   introcontroller.chglan.value = false;
                              //   Navigator.pop(
                              //       context, GlobalVariable.languageCode);
                              //   print(GlobalVariable.languageCode);
                              // }
                            }),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(context) * 16,
                        right: GlobalVariable.ratioWidth(context) * 16),
                    child: Container(
                      height: GlobalVariable.ratioWidth(context) * 0.5,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xFFC6CBD4),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(context) * 16,
                      top: GlobalVariable.ratioWidth(context) * 8), //14
                  child: Row(
                    children: [
                      Container(
                          height: GlobalVariable.ratioWidth(context) * 16,
                          width: GlobalVariable.ratioWidth(context) * 16,
                          child: Image.asset('assets/eng.png')),
                      SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                      Container(
                          height: GlobalVariable.ratioWidth(context) * 17,
                          width: GlobalVariable.ratioWidth(context) * 119,
                          child: CustomText(
                            'English',
                            textAlign: TextAlign.left,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorBlack),
                          )),
                      SizedBox(width: GlobalVariable.ratioWidth(context) * 160),
                      Obx(() => RadioButtonCustom(
                          width: GlobalVariable.ratioWidth(context) * 15.57,
                          height: GlobalVariable.ratioWidth(context) * 15.57,
                          groupValue: introcontroller.selectedLang.toString(),
                          value: introcontroller.eng.value,
                          onChanged: (value) async {
                            introcontroller.selectedLang.value = value;
                            print(GlobalVariable.languageCode);
                            introcontroller.chglan.value = true;
                            introcontroller.clearslide();
                            // await changeLanguage.setChangeLanguage(
                            //     'en', 'en_US', 'English');
                            //  introcontroller.chglan.value = false;
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return popupcustom(context);
                            //       // .popupgoldtransporter(context, '', '');
                            //       // return CustomDialog()
                            //       //     .contentTransportMarket(context);
                            //     });
                            await changeLanguage(
                                'en', 'en_US', 'English', introcontroller);
                            // var response = await ApiHelper(
                            //         context: Get.context,
                            //         isShowDialogLoading: false)
                            //     .getOnBoarden();

                            // var response =
                            // await ApiHelper(context: Get.context, isShowDialogLoading: false)
                            //     .getOnBoard();
                            // if (response != null) {
                            //   final message = MessageFromUrlModel.fromJson(
                            //       response["Message"]);
                            //   if (message != null && message.code == 200) {
                            //     introcontroller.slideIndex.value = 0;
                            //     for (var data in response["Data"]) {
                            //       introcontroller.listSlides.add(
                            //         IntroModelShipper(
                            //           data['Title'],
                            //           data['Description'],
                            //           data['Icon'],
                            //         ),
                            //       );
                            //     }
                            //   } else {}
                            //   introcontroller.chglan.value = false;
                            //   Navigator.pop(
                            //       context, GlobalVariable.languageCode);
                            //   print(GlobalVariable.languageCode);
                            // }
                          }))
                    ],
                  ),
                ),
              ],
            ),
            // child: ListView.builder(
            //   controller: listViewController,
            //   itemBuilder: (context, index) {
            //     return Container(
            //       margin: const EdgeInsets.all(15),
            //       color: Colors.green[200],
            //       height: 100,
            //       child: Center(
            //         child: Text(index.toString()),
            //       ),
            //     );
            //   },
            // ),
          ),
        ),
      ),
      // child: Background(),
    );
  }

  Future changeLanguage(String idLanguage, String typeLanguage,
      String nameLanguage, IntroShipperController introcontroller) async {
    loadChangeLanguage.value = true;
    showDialog(
        context: Get.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: _keyDialog,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText('GlobalLabelDialogLoading'.tr,
                            color: Colors.blueAccent)
                      ]),
                    )
                  ]));
        });
    // var response = await ApiProfile(context: Get.context, isShowDialogLoading: false).setUserLanguage({
    //   "Locale" : typeLanguage
    // });
    // if (response != null) {
    //   if (response["Message"]["Code"] == 200) {
    try {
      var locale = Locale(idLanguage);
      await SharedPreferencesHelper.setLanguage(
          idLanguage, typeLanguage, nameLanguage);
      await ChangeLanguage(Get.context).getLanguage();
      Get.updateLocale(locale);
      var response =
          await ApiHelper(context: Get.context, isShowDialogLoading: false)
              .getOnBoard();
      if (response != null) {
        final message = MessageFromUrlModel.fromJson(response["Message"]);
        if (message != null && message.code == 200) {
          introcontroller.slideIndex.value = 0;
          for (var data in response["Data"]) {
            introcontroller.listSlides.add(
              IntroModelShipper(
                data['Title'],
                data['Description'],
                data['Icon'],
              ),
            );
          }
        }
        loadChangeLanguage.value = false;
        introcontroller.chglan.value = false;
        Get.back();
      } else {
        Get.back();
        // error
      }
    } catch (e) {
      print("error = " + e.toString());
      loadChangeLanguage.value = false;
      introcontroller.chglan.value = false;
      Get.back();
    }
    
    // } else {
    //   Get.back();
    // }
  }
}

/// Widgets below are just helper widgets for this example

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Placeholder(
        color: Colors.green[200],
      ),
    );
  }
}

class GrabbingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 7),
            width: GlobalVariable.ratioWidth(context) * 94,
            height: GlobalVariable.ratioWidth(context) * 5.5,
            decoration: BoxDecoration(
              color: Color(0xFFC6CBD4),
              borderRadius: BorderRadius.circular(90),
            ),
          ),
          // SizedBox(
          //   height: GlobalVariable.ratioWidth(context) * 24
          // )
          // Container(
          //   color: Colors.grey[200],
          //   height: 2,
          //   margin: EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
          // )
        ],
      ),
    );
  }
}
