import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/modules/pay/pay_controller.dart';

import 'package:flutter/foundation.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PayView extends GetView<PayController> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var result = Barcode("", BarcodeFormat.qrcode, null).obs;
  var flash = false.obs;
  var frontCamera = true.obs;
  QRViewController qrController;
  BuildContext viewContext;
  var panel = PanelController();
  var userSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    result.value = null;
    viewContext = context;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        _buildQrView(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: RawMaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              fillColor: Colors.white,
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Color(ListColor.color4),
                              ),
                              padding: EdgeInsets.all(4),
                              shape: CircleBorder(),
                            ),
                            margin: EdgeInsets.only(top: 20),
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              child: Obx(() => RawMaterialButton(
                                    onPressed: () {
                                      qrController.toggleFlash();
                                      flash.value = !flash.value;
                                    },
                                    fillColor: Colors.white,
                                    child: Icon(
                                      Icons.flash_on,
                                      color: flash.value
                                          ? Color(ListColor.color4)
                                          : null,
                                    ),
                                    padding: EdgeInsets.all(4),
                                    shape: CircleBorder(),
                                  )),
                              margin: EdgeInsets.only(top: 20),
                            ))
                      ],
                    )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      CustomText(
                          'Scan your QR code at here to automatically pay',
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: CustomText('or', fontSize: 15),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side:
                                    BorderSide(color: Color(ListColor.color4))),
                            onPressed: () {},
                            child: CustomText(
                              'Use debit card',
                              color: Color(ListColor.color4),
                            ),
                          ),
                          Container(width: 10),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side:
                                    BorderSide(color: Color(ListColor.color4))),
                            onPressed: () {},
                            child: CustomText(
                              'Use Go-Pay',
                              color: Color(ListColor.color4),
                            ),
                          ),
                          Container(width: 10),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side:
                                    BorderSide(color: Color(ListColor.color4))),
                            onPressed: () {},
                            child: CustomText(
                              'Use OVO',
                              color: Color(ListColor.color4),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SlidingUpPanel(
                controller: panel,
                backdropEnabled: true,
                maxHeight: MediaQuery.of(context).size.height - 100,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                collapsed: Container(
                    decoration: BoxDecoration(
                        color: Color(ListColor.color4),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Center(
                      child: CustomText("^\nSlide up to see more up",
                          textAlign: TextAlign.center, color: Colors.white),
                    )),
                panel: Container(
                    padding: EdgeInsets.all(20),
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: CustomText(
                                "v\nSlide down to close",
                                textAlign: TextAlign.center,
                              )),
                          (controller.contacts.value.isEmpty)
                              ? Expanded(
                                  child: Center(
                                      child: CustomText(
                                          (controller.loadContacts.value)
                                              ? "Loading"
                                              : "Empty")),
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Icon(Icons.search),
                                      TextFormField(
                                        // focusNode: userSearchNode,
                                        // onTap: (){
                                        //   userSearchNode.requestFocus();
                                        // },
                                        decoration: InputDecoration(
                                          hintText: 'Search',
                                          contentPadding:
                                              EdgeInsets.only(left: 40.0),
                                        ),
                                        controller: userSearch,
                                        onChanged: (text) {
                                          var filter = controller.contacts.value
                                              .where((element) => element
                                                  .displayName
                                                  .contains(userSearch.text));
                                          controller.contactsFilter.clear();
                                          controller.contactsFilter.value =
                                              filter.toList();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: controller.contactsFilter.length,
                                itemBuilder: (context, index) {
                                  var user =
                                      controller.contactsFilter.value[index];
                                  return Container(
                                      padding: EdgeInsets.all(20),
                                      child: CustomText(
                                        user.displayName,
                                        textAlign: TextAlign.left,
                                      ));
                                }),
                          )
                        ],
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView() {
    var scanArea = (MediaQuery.of(Get.context).size.width < 400 ||
            MediaQuery.of(Get.context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController viewController) {
    this.qrController = viewController;
    viewController.scannedDataStream.listen((scanData) async {
      if (!panel.isPanelOpen && scanData.format == BarcodeFormat.qrcode) {
        viewController.pauseCamera();
        result.value = scanData;
        CoolAlert.show(
            context: viewContext,
            type: CoolAlertType.info,
            title: 'Info',
            text: "Your qr code: ${scanData.code}",
            barrierDismissible: false,
            onConfirmBtnTap: () {
              Get.back();
              viewController.resumeCamera();
            });
      }
    });
  }
}
