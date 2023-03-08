import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/search_city/search_city_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class SearchCityView extends GetView<SearchCityController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText('SearchCityView'),
        centerTitle: true,
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                // margin: EdgeInsets.only(right: isShort ? 100 : 0),
                child: CustomTextField(
              context: Get.context,
              textInputAction: TextInputAction.search,
              controller: controller.textEditingCityController.value,
              onChanged: (value) {
                controller.addTextCity(value);
              },
              newContentPadding: EdgeInsets.all(10.0),
              newInputDecoration: InputDecoration(
                fillColor: Colors.white,
                errorStyle: TextStyle(color: Colors.white),
                errorMaxLines: 2,
                filled: true,
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(ListColor.color4), width: 5.0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SEARCH_LOCATION_MAP_MARKER);
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
                    CustomText('SearchCityButtonChooseMarkerMap'.tr,
                        color: Colors.green)
                  ],
                ),
              ),
            ),
            Expanded(
                child: Obx(
              () => ListView.builder(
                itemCount: controller.listCity.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      controller
                          .onClickListCity(controller.listCity[index].placeId);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: ListTile(
                        title:
                            CustomText(controller.listCity[index].description),
                      ),
                    ),
                  );
                },
              ),
            )),
          ]),
    );
  }
}
