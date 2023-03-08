import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_function.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import 'from_dest_search_location_controller.dart';

class FromDestSearchLocationView
    extends GetView<FromDestSearchLocationController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
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
            SizedBox(
              width: 10.0,
            ),
            CustomText('FDSLLabelSearchLocation'.tr,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: GlobalFunction.getFontSize(18.0))
          ],
        ),
      ),
      body: Container(
        child: Obx(
          () => Column(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.white),
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // _getTextField("Address",
                    //     controller.textEditingAddressFromController.value, null),
                    _getTextField(
                        'FDSLLabelHintPickUpLocation'.tr,
                        controller.textEditingCityFromController.value,
                        controller.focusNodeCityFrom.value,
                        controller.markerFrom.value,
                        true),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.grey,
                    ),
                    _getTextField(
                        'FDSLLabelHintDestinationLocation'.tr,
                        controller.textEditingCityDestController.value,
                        controller.focusNodeCityDest.value,
                        controller.markerDest.value,
                        false),
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 1, color: Colors.grey),
                            color: Colors.white),
                        child: Material(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              controller.goToMap();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.map_outlined,
                                    color: Colors.green,
                                  ),
                                  CustomText('FDSLButtonChooseMarkerMap'.tr,
                                      color: Colors.green),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ]),
            ),

            (controller.isShowSavedPlace.value
                ? Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      height: 80,
                      child: controller.isLoadingGetAllLocationManagement.value
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              ))
                          : controller.isErrorGetAllLocationManagement.value
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.getLocationManagement();
                                    },
                                    child: Center(
                                        child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.refresh,
                                            color: Color(ListColor.colorGrey)),
                                        CustomText('FDSLTryAgain'.tr)
                                      ],
                                    )),
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller
                                          .isLengthLocationManagementZero()
                                      ? 1
                                      : controller
                                          .listAllLocationManagement.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        decoration: BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                blurRadius: 2,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.white),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.transparent,
                                          child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              onTap: () {
                                                if (controller
                                                    .isLengthLocationManagementZero()) {
                                                  Get.toNamed(
                                                      Routes.PLACE_FAVORITE);
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.location_city),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    CustomText(
                                                        controller
                                                                .isLengthLocationManagementZero()
                                                            ? 'FDSLAddLocationManagement'
                                                                .tr
                                                            : controller
                                                                .listAllLocationManagement[
                                                                    index]
                                                                .name,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600)
                                                  ],
                                                ),
                                              )),
                                        ));
                                  },
                                ),
                    ),
                    Container(
                        color: Colors.white,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.PLACE_FAVORITE);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Icon(Icons.location_city),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    CustomText('FDSLButtonSavedPlace'.tr,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              )),
                        )),
                  ])
                : Container()),

            controller.isShowSavedPlace.value
                ? Expanded(
                    child: ListView.builder(
                      itemCount: controller.listHistoryLocation.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            // await controller.onClickListCity(
                            //     controller.listCity[index].placeId);
                          },
                          child: Container(
                            child: Column(children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: ListTile(
                                  title: CustomText(controller
                                      .listHistoryLocation[index].address),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                color: Colors.grey,
                              )
                            ]),
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: controller.isGettingDataCity.value
                              ? Center(
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator()),
                                )
                              : (controller.isEmptyResult.value
                                  ? Center(child: CustomText('FDSLNoResult'.tr))
                                  : ListView.builder(
                                      itemCount: controller.listCity.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            FocusScope.of(context).unfocus();
                                            await controller.onClickListCity(
                                                controller
                                                    .listCity[index].placeId);
                                          },
                                          child: Container(
                                            child: Column(children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: ListTile(
                                                  title: CustomText(controller
                                                      .listCity[index]
                                                      .description),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 1,
                                                color: Colors.grey,
                                              )
                                            ]),
                                          ),
                                        );
                                      },
                                    )),
                        ),
                        (controller.isShowConfirmButton.value
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                color: Colors.white,
                                child: Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: MaterialButton(
                                      onPressed: () {
                                        controller.getBack();
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      color: Color(ListColor.color4),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 10.0),
                                        child: CustomText('FDSLLabelConfirm'.tr,
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container()),
                      ],
                    ),
                  ),
            //Expanded(child: ListView.builder(itemBuilder: ,),)
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

  Widget _getTextField(
      String title,
      TextEditingController textEditingController,
      FocusNode focusNode,
      String markerIcon,
      bool autoFocus) {
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
                onChanged: (value) {
                  controller.addTextCity(value, textEditingController);
                },
                focusNode: focusNode,
                autofocus: autoFocus,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  controller.forceSearchCity(value, focusNode);
                },
                onEditingComplete: () {},
                newContentPadding: EdgeInsets.all(10.0),
                newInputDecoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  hintText: title,
                  fillColor: Colors.white,
                  errorStyle: TextStyle(color: Colors.white),
                  errorMaxLines: 2,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 5.0),
                    // borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            textEditingController.text != ""
                ? GestureDetector(
                    onTap: () {
                      controller.clearTextFromDest(textEditingController);
                    },
                    child: Icon(Icons.clear_rounded))
                : Container(),
          ],
        )),
      ],
    );
  }
}
