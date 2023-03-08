import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/point_tac_pap_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';

class TACPAPController extends GetxController {
  final isGettingDataPoint = false.obs;
  final isAllPointChecked = false.obs;
  final isButtonOnBottom = false.obs;

  final listPoint = [].obs;

  String title;
  String titleNextButton;
  void Function() onConfirm;

  ScrollController _scrollController = ScrollController();

  GlobalKey _container1Key = GlobalKey();
  GlobalKey _container2Key = GlobalKey();

  double _heightContainer1 = 0;
  double _heightContainer2 = 0;

  TACPAPController(
      {this.title = "", this.titleNextButton = "", this.onConfirm});

  @override
  void onInit() {}

  void addListPoint(List<PointTACPAPModel> data) {
    listPoint.clear();
    listPoint.addAll(data);
    if (listPoint.length > 0) listPoint[0].isChecked = true;
  }

  void setIsGettingDataPoint(bool isGettingData) {
    isGettingDataPoint.value = isGettingData;
  }

  void showModalBottomSheetIsGettingDataPointTrue() {
    setIsGettingDataPoint(true);
    _showModalBottom();
  }

  void _onCompleteBuild() {
    //print(isGettingDataPoint.value);
    if (!isGettingDataPoint.value &&
        (_heightContainer1 == 0 || _heightContainer2 == 0)) {
      if (_heightContainer1 == 0) {
        final renderBox =
            _container1Key.currentContext.findRenderObject() as RenderBox;
        _heightContainer1 = renderBox.size.height;
      }
      if (_heightContainer2 == 0) {
        final renderBox =
            _container2Key.currentContext.findRenderObject() as RenderBox;
        _heightContainer2 = renderBox.size.height;
      }
      print("container1:" + _heightContainer1.toString());
      print("container2:" + _heightContainer2.toString());
      isButtonOnBottom.value = _heightContainer2 < _heightContainer1 - 80;
    }
  }

  void _showModalBottom() {
    isAllPointChecked.value = false;
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return Obx(() {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _onCompleteBuild());
            return Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height - 100,
              child: Column(children: [
                Container(
                    padding: EdgeInsets.fromLTRB(20, 32, 20, 0),
                    child: CustomText(title,
                        fontSize: 24, fontWeight: FontWeight.w600)),
                Expanded(
                  child: Container(
                      key: _container1Key,
                      color: Colors.white,
                      child: isGettingDataPoint.value
                          ? Center(
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator()))
                          : Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              // child: _contentWidget())),
                              child: !isButtonOnBottom.value
                                  ? SingleChildScrollView(
                                      child: _contentWidget())
                                  : _contentWidget())),
                ),
              ]),
            );
          });
        });
  }

  Widget _contentWidget() {
    return Container(
      key: _container2Key,
      child: Column(
        mainAxisSize:
            isButtonOnBottom.value ? MainAxisSize.max : MainAxisSize.min,
        children: _getListPoint(),
      ),
    );
  }

  List<Widget> _getListPoint() {
    List<Widget> list = [];
    //String allData = "";
    if (listPoint.length > 0) {
      for (int i = 0; i < listPoint.length; i++) {
        PointTACPAPModel pointTACPAPModel = listPoint[i];
        // allData += pointTACPAPModel.data;
        // list.add(_getDetailPoint(pointTACPAPModel, i));
        list.add(i == 0
            // ? Expanded(child: _getDetailPoint0(pointTACPAPModel.data))
            ? (isButtonOnBottom.value
                ? Expanded(child: _getDetailPoint0(pointTACPAPModel.data))
                : _getDetailPoint0(pointTACPAPModel.data))
            : _getDetailPoint(pointTACPAPModel, i));
      }
      // list.insert(
      //     0,
      //     isButtonOnBottom.value
      //         ? Expanded(child: _getDetailPoint0(allData))
      //         : _getDetailPoint0(allData));
    }
    list.add(SizedBox(height: 16));
    if (!isGettingDataPoint.value) list.add(_buttonConfirm());
    list.add(SizedBox(height: 16));
    return list;
  }

  Widget _buttonConfirm() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Color(isAllPointChecked.value
            ? ListColor.color4
            : ListColor.colorLightGrey12),
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.transparent,
        child: InkWell(
          onTap: isAllPointChecked.value
              ? () {
                  onConfirm();
                }
              : null,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: Center(
              child: CustomText(titleNextButton,
                  fontSize: 14,
                  color: isAllPointChecked.value
                      ? Colors.white
                      : Color(ListColor.colorLightGrey13),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getDetailPoint0(String data) {
    return Container(
      // height: isButtonOnBottom.value
      //     ? null
      //     : MediaQuery.of(Get.context).size.height * 0.45,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(ListColor.colorLightGrey2)),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      margin: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      padding: EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.all(11),
        // child: SingleChildScrollView(
        child: Html(
          data: data,
          onLinkTap: (url) {
            print("Opening $url...");
            _urlLauncher(url);
          },
        ),
        // ),
      ),
      // Scrollbar(
      //   controller: _scrollController,
      //   isAlwaysShown: true,
      //   child: SingleChildScrollView(
      //     controller: _scrollController,
      //     child: Container(
      //       padding: EdgeInsets.all(11),
      //       child: Html(
      //         data: data,
      //         onLinkTap: (url) {
      //           print("Opening $url...");
      //           _urlLauncher(url);
      //         },
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget _getDetailPoint(
      PointTACPAPModel termsAndConditionsPointModel, int index) {
    return index == 0
        ? SizedBox.shrink()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              CheckBoxCustom(
                value: termsAndConditionsPointModel.isChecked,
                onChanged: !isGettingDataPoint.value
                    ? (value) {
                        _setCheckboxPoint(value, index);
                      }
                    : null,
              ),
              // Theme(
              //   data: ThemeData(unselectedWidgetColor: Color(ListColor.color4)),
              //   child: Checkbox(
              //     value: termsAndConditionsPointModel.isChecked,
              //     onChanged: !isGettingDataPoint.value
              //         ? (value) {
              //             _setCheckboxPoint(value, index);
              //           }
              //         : null,
              //     checkColor: Colors.white,
              //     activeColor: Color(ListColor.color4),
              //   ),
              // ),
              Expanded(
                child: Html(
                  data: termsAndConditionsPointModel.data,
                  onLinkTap: (url) {
                    print("Opening $url...");
                    _urlLauncher(url);
                  },
                ),
              ),
            ],
          );
  }

  void _urlLauncher(String url) async {
    if (await canLaunch(url)) {
      //await launch(url);
      Get.toNamed(Routes.WEBVIEW_TAC_PAP, arguments: url);
    }
  }

  void _setCheckboxPoint(bool isChecked, int index) {
    listPoint[index].isChecked = isChecked;
    listPoint.refresh();
    isAllPointChecked.value = _isAllCheckedPoint();
  }

  _isAllCheckedPoint() {
    bool result = true;
    for (PointTACPAPModel model in listPoint) {
      if (!model.isChecked) {
        result = false;
        break;
      }
    }
    return result;
  }
}
