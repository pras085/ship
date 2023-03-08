import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/place_favorite/place_favorite_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class PlaceFavoriteView extends GetView<PlaceFavoriteController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return Scaffold(
      appBar: AppBar(
        title: CustomText('PlaceFavoriteView'),
        centerTitle: true,
      ),
      body: Obx(
        () => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: controller.isLoadingGetAllLocationManagement.value
              ? Center(
                  child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()),
                )
              : controller.isErrorGetAllLocationManagement.value
                  ? Center(
                      child: Container(
                          child: GestureDetector(
                        onTap: () {
                          controller.getLocationManagement();
                        },
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.refresh,
                                  color:
                                      Color(ListColor.colorIconWithTextBase)),
                              CustomText('PlaceFavoriteTryAgain'.tr,
                                  color:
                                      Color(ListColor.colorIconWithTextBase)),
                            ],
                          ),
                        ),
                      )),
                    )
                  : controller.listAllLocationManagement.length == 0
                      ? Center(
                          child: Container(
                              child: GestureDetector(
                            onTap: () {
                              controller.gotoPlaceFavoriteEditor();
                            },
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add_circle_outline,
                                      color: Color(
                                          ListColor.colorIconWithTextBase)),
                                  CustomText('PlaceFavoriteAddNewLocation'.tr,
                                      color: Color(
                                          ListColor.colorIconWithTextBase)),
                                ],
                              ),
                            ),
                          )),
                        )
                      : ListView.builder(
                          itemCount:
                              controller.listAllLocationManagement.length,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        onTap: () {
                                          controller.gotoPlaceFavoriteEditor(
                                              index: index);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.location_city),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CustomText(
                                                          controller
                                                              .listAllLocationManagement[
                                                                  index]
                                                              .name,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      Container(
                                                        child: CustomText(
                                                          controller
                                                              .listAllLocationManagement[
                                                                  index]
                                                              .address,
                                                          color: Color(ListColor
                                                              .colorLightGrey),
                                                        ),
                                                      ),
                                                    ]),
                                              )
                                            ],
                                          ),
                                        )),
                                  )),
                              Container(
                                  height: 1,
                                  width: MediaQuery.of(context).size.width - 20,
                                  color: Color(ListColor.colorLightGrey))
                            ]);
                          },
                        ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.gotoPlaceFavoriteEditor();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
