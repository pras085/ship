import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/modules/choose_user_type/choose_user_type_controller.dart';
import 'package:muatmuat/app/modules/choose_user_type/choose_user_type_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class ChooseUserTypeView extends GetView<ChooseUserTypeController> {
  double _sizeTopAndBottom(BuildContext context) =>
      MediaQuery.of(context).size.height / 8.4;
  double _sizeMarginBetweenTitleMenu = 40;
  double _sizeMarginTopInfoButton = 40;
  double _sizeTitleFont = 16;
  double _sizeInfoButtonFont = 16;
  double _sizeMarginVerticalPerItem = 8;
  double _sizePaddingInsidePerItem = 10;
  double _sizeMarginBottomBetweenRegisterLogin = 21;
  double _sizeContainerTitle() => _sizeMarginBetweenTitleMenu + _sizeTitleFont;
  double _sizeContainerInfoButton() =>
      _sizeMarginTopInfoButton + _sizeInfoButtonFont + 40;
  double _sizeHeightPerItem(BuildContext context) =>
      (MediaQuery.of(context).size.height -
          (_sizeTopAndBottom(context) * 2) -
          _sizeContainerTitle() -
          _sizeContainerInfoButton()) /
      controller.listDataAllMenu.length;
  double _sizeWidthHeightIconPerItem(BuildContext context) =>
      _sizeHeightPerItem(context) -
      (_sizePaddingInsidePerItem * 2) -
      _sizeMarginVerticalPerItem;

  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuild());
    return Scaffold(
      backgroundColor: Color(ListColor.color4),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => controller.isError.value
                  ? Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                size: 50,
                                color: Colors.white,
                              ),
                              SizedBox(height: 10),
                              CustomText(
                                'GlobalLabelErrorNoConnection'.tr,
                                textAlign: TextAlign.center,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                  onTap: () {
                                    controller.checkRoleRegister();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: CustomText('GlobalButtonTryAgain'.tr,
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ))
                              // OutlinedButton(
                              //   style: OutlinedButton.styleFrom(
                              //       backgroundColor:
                              //           Color(ListColor.color4),
                              //       side: BorderSide(
                              //           width: 2,
                              //           color: Color(
                              //               ListColor.color4)),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius:
                              //             BorderRadius.all(
                              //                 Radius.circular(20)),
                              //       )),
                              //   onPressed: () {
                              //     _gettingDataVariable(
                              //         setIsSuccesFalse: false);
                              //   },
                              //   child: Container(
                              //     padding: EdgeInsets.symmetric(
                              //         horizontal: 25, vertical: 10),
                              //     child: Text(
                              //         "GlobalButtonTryAgain".tr,
                              //         style: TextStyle(
                              //             fontWeight:
                              //                 FontWeight.w600,
                              //             color: Color(ListColor.color4))),
                              //   ),
                              // ),
                            ]),
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: controller.listDataLogin.length > 0
                          ? _listItemMenu(context)
                          : _listItemMenu(context),
                    ),
            )),
      ),
    );
  }

  List<Widget> _listItemMenu(BuildContext context) {
    double heightListItemOnly =
        (_sizeHeightPerItem(context) * controller.listDataAllMenu.length);
    double heightListItemWithRegisterLoginGroup =
        _sizeMarginBottomBetweenRegisterLogin +
            _sizeContainerTitle() +
            (_sizeHeightPerItem(context) * controller.listDataAllMenu.length);
    double heightMarginBottom = _sizeTopAndBottom(context) -
        (heightListItemWithRegisterLoginGroup - heightListItemOnly);
    List<Widget> listWidget = [
      SizedBox(
        height: _sizeTopAndBottom(context),
      ),
      Container(
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        height: _sizeContainerTitle(),
        child: CustomText(
            controller.listDataLogin.length > 0
                ? "DashboardIndexLoginAkun".tr
                : "DashboardIndexDaftarAkun".tr,
            textAlign: TextAlign.center,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: _sizeTitleFont),
      ),
    ];
    List<Widget> listWidgetItem = [];
    if (controller.listDataLogin.length > 0 &&
        controller.listDataRegister.length > 0) {
      for (ChooseUserTypeModel data in controller.listDataLogin) {
        listWidgetItem.add(Container(
            width: MediaQuery.of(context).size.width,
            height: _sizeHeightPerItem(context),
            child: _itemPerMenu(data, context)));
      }
      listWidgetItem.add(SizedBox(
        height: _sizeMarginBottomBetweenRegisterLogin,
      ));
      listWidgetItem.add(Container(
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        height: _sizeContainerTitle(),
        child: CustomText("DashboardIndexDaftarAkun".tr,
            textAlign: TextAlign.center,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: _sizeTitleFont),
      ));
      for (ChooseUserTypeModel data in controller.listDataRegister) {
        listWidgetItem.add(Container(
            width: MediaQuery.of(context).size.width,
            height: _sizeHeightPerItem(context),
            child: _itemPerMenu(data, context)));
      }
    } else {
      for (ChooseUserTypeModel data in (controller.listDataRegister.length > 0
          ? controller.listDataRegister
          : controller.listDataLogin)) {
        listWidgetItem.add(Container(
            width: MediaQuery.of(context).size.width,
            height: _sizeHeightPerItem(context),
            child: _itemPerMenu(data, context)));
      }
    }
    // for (int i = 0; i < controller.listDataAllMenu.length; i++) {
    //   if (controller.listDataLogin.length > 0) {
    //     listWidgetItem.add(SizedBox(
    //       height: _sizeMarginBottomBetweenRegisterLogin,
    //     ));
    //     listWidgetItem.add(Container(
    //       alignment: Alignment.topCenter,
    //       width: MediaQuery.of(context).size.width,
    //       height: _sizeContainerTitle(),
    //       child: Text("Anda ingin login mendaftar".tr,
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //               color: Colors.white,
    //               fontWeight: FontWeight.w600,
    //               fontSize: _sizeTitleFont)),
    //     ));
    //     listWidgetItem.add(Container(
    //         width: MediaQuery.of(context).size.width,
    //         height: _sizeHeightPerItem(context),
    //         child: _itemPerMenu(controller.listData[i], context)));
    //   } else
    //     listWidgetItem.add(Container(
    //         width: MediaQuery.of(context).size.width,
    //         height: _sizeHeightPerItem(context),
    //         child: _itemPerMenu(controller.listData[i], context)));
    // }
    listWidget.add(Container(
      height: heightListItemWithRegisterLoginGroup,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: listWidgetItem,
      ),
    ));
    listWidget.add(
      SizedBox(
        height: heightMarginBottom < 0
            ? heightMarginBottom * -1
            : heightMarginBottom,
      ),
    );
    listWidget.add(Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      height: _sizeContainerInfoButton(),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: BorderSide(width: 1, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              )),
          onPressed: () {
            controller.goToInformationPage();
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: CustomText("DashboardIndexInfoAkun".tr,
                  textAlign: TextAlign.center,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: _sizeInfoButtonFont)),
        ),
      ),
    ));
    return listWidget;
  }

  Widget _itemPerMenu(
      ChooseUserTypeModel chooseUserTypeModel, BuildContext context) {
    double borderRadius = 6;
    double widthHeightIcon = _sizeWidthHeightIconPerItem(context);
    return Container(
        margin: EdgeInsets.symmetric(vertical: _sizeMarginVerticalPerItem),
        width: MediaQuery.of(Get.context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white),
        child: Material(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.transparent,
          child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: chooseUserTypeModel.onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomText(
                          chooseUserTypeModel.title,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: _sizeTitleFont,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image(
                        image:
                            AssetImage("assets/" + chooseUserTypeModel.urlIcon),
                        //width: widthHeightIcon,
                        height: widthHeightIcon,
                        fit: BoxFit.fitHeight,
                      ),
                    ]),
              )),
        ));
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      CustomToast.show(
          context: Get.context, message: 'GlobalLabelBackAgainExit'.tr);
      return Future.value(false);
    } else {
      SharedPreferencesHelper.setLogOut();
    }
    return Future.value(true);
  }
}
