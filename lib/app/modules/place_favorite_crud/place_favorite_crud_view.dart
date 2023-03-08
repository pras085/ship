import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/place_favorite_crud/place_favorite_crud_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class PlaceFavoriteCrudView extends GetView<PlaceFavoriteCrudController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText('PlaceFavoriteCrudView'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: [
          _getTextField('PlaceFavoriteLabelName'.tr,
              controller.textEditingNameController.value, null),
          _getTextField('PlaceFavoriteLabelAddress'.tr,
              controller.textEditingAddressController.value, () {
            controller.gotoSearchCity();
          }),
          FlatButton(
            onPressed: () {
              controller.saveLocationManagement();
            },
            color: Color(ListColor.colorBlue),
            child: CustomText('PlaceFavoriteLabelButtonConfirm'.tr,
                color: Colors.white),
          ),
        ]),
      ),
    );
  }

  Widget _getTextField(String title,
      TextEditingController textEditingController, Function onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: EdgeInsets.only(top: 10, bottom: 5),
            child: CustomText(title, color: Colors.black, fontSize: 18)),
        GestureDetector(
          onTap: onTap,
          child: Container(
              // margin: EdgeInsets.only(right: isShort ? 100 : 0),
              child: CustomTextField(
            context: Get.context,
            controller: textEditingController,
            enabled: onTap == null,
            newContentPadding: EdgeInsets.all(10.0),
            newInputDecoration: InputDecoration(
              fillColor: Colors.white,
              errorStyle: TextStyle(color: Colors.white),
              errorMaxLines: 2,
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
}
