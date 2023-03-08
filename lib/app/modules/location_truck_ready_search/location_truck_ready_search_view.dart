import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_function.dart';
import 'package:muatmuat/app/modules/location_truck_ready_search/location_truck_ready_search_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class LocationTruckReadySearchView
    extends GetView<LocationTruckReadySearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          child: Container(
            color: Color(ListColor.color4),
            height: 2,
          ),
          preferredSize: Size.fromHeight(2),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: Color(ListColor
                      .colorBackgroundCircleBigFleetLokasiTrukSiapMuat),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image(
                    image: AssetImage("assets/lokasi_truk_siap_muat_icon.png"),
                    width: 30,
                    height: 30,
                    fit: BoxFit.fitWidth,
                  ),
                )),
            SizedBox(
              width: 10.0,
            ),
            CustomText(
              'BigFleetsLabelMenuTruckLocationsReadytoLoad'.tr,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: GlobalFunction.getFontSize(18.0),
            )
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // _getTextField("Address",
                    //     controller.textEditingAddressFromController.value, null),
                    GestureDetector(
                      onTap: () {
                        controller.gotoSearchCityFromDest();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // _getTextField("Address",
                              //     controller.textEditingAddressFromController.value, null),
                              _getTextFieldFromDest(
                                  'LTRSearchLabelPickup'.tr,
                                  controller
                                      .textEditingCityFromController.value,
                                  controller.markerFrom.value),
                              Container(
                                margin: EdgeInsets.only(left: 30, right: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                color: Colors.grey,
                              ),
                              _getTextFieldFromDest(
                                'LTRSearchLabelDestination'.tr,
                                controller.textEditingCityDestController.value,
                                controller.markerDest.value,
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: CustomText(
                                    'LTRSearchLabelTypeOfTruck'.tr,
                                    color: Colors.black,
                                    fontSize: 18)),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[800]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                color: Colors.white,
                              ),
                              child: DropdownButton(
                                underline: Container(),
                                hint: CustomText(
                                    'LTRSearchLabelSelectTypeOfTruck'.tr),
                                value: controller.valueHeadTruck.value,
                                items: controller.listHeadTruck.map((data) {
                                  return DropdownMenuItem(
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                60,
                                        child: CustomText(data.description)),
                                    value: data.description,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.setHeadTruck(value);
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                                child: CustomText(
                                    'LTRSearchLabelCarrierTruck'.tr,
                                    color: Colors.black,
                                    fontSize: 18)),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[800]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                color: Colors.white,
                              ),
                              child: DropdownButton(
                                underline: Container(),
                                hint: CustomText(
                                    'LTRSearchLabelSelectCarrierTruck'.tr),
                                value: controller.valueCarrierTruck.value,
                                items: controller.listCarrierTruck.map((data) {
                                  return DropdownMenuItem(
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          child: CustomText(data.description)),
                                      value: data.description);
                                }).toList(),
                                onChanged: (value) {
                                  controller.setCarrierTruck(value);
                                },
                              ),
                            ),
                            // SizedBox(height: 20),
                            // _getTextField(
                            //     'LTRSearchLabelNumberOfTruck'.tr,
                            //     controller
                            //         .textEditingNumberTruckController.value,
                            //     null),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              width: MediaQuery.of(context).size.width,
                              child: MaterialButton(
                                onPressed: () {
                                  controller.gotoResult();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                color: Color(ListColor.color4),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: CustomText('LTRSearchButtonSearch'.tr,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       border: Border.all(width: 1, color: Colors.grey)),
            //   padding: EdgeInsets.all(10),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("Destination",
            //           style:
            //               TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            //       _getTextField("Address",
            //           controller.textEditingAddressDestController.value, null),
            //       _getTextField(
            //           "City", controller.textEditingCityDestController.value, () {
            //         controller.gotoSearchCityDest();
            //       }),
            //     ],
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }

  Widget _getTextField(String title,
      TextEditingController textEditingController, Function onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child: CustomText(title, color: Colors.black, fontSize: 18)),
        GestureDetector(
          onTap: onTap,
          child: Container(
              // margin: EdgeInsets.only(right: isShort ? 100 : 0),
              child: CustomTextField(
            context: Get.context,
            controller: textEditingController,
            enabled: onTap == null,
            newInputDecoration: InputDecoration(
              fillColor: Colors.white,
              errorStyle: TextStyle(color: Colors.white),
              errorMaxLines: 2,
              contentPadding: EdgeInsets.all(10.0),
              filled: true,
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color(ListColor.color4), width: 5.0),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          )),
        ),
      ],
    );
  }

  Widget _getTextFieldFromDest(String title,
      TextEditingController textEditingController, String markerIcon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Container(
        //     margin: EdgeInsets.only(top: 10, bottom: 5),
        //     child: Text(title,
        //         style: TextStyle(color: Colors.black, fontSize: 18))),
        Container(
            // margin: EdgeInsets.only(right: isShort ? 100 : 0),
            child: Row(
          children: [
            Image(
              image: AssetImage("assets/" + markerIcon),
              width: 20,
              height: 20,
              fit: BoxFit.fitWidth,
            ),
            Expanded(
              child: CustomTextField(
                context: Get.context,
                controller: textEditingController,
                enabled: false,
                newContentPadding: EdgeInsets.all(10.0),
                newInputDecoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: title,
                  fillColor: Colors.white,
                  errorStyle: TextStyle(color: Colors.white),
                  errorMaxLines: 2,
                  filled: true,
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
