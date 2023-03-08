import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class LayoutCustomAppBar extends StatelessWidget {
  AppBar _appBar = AppBar(
    title: Text('Demo'),
  );
  Widget body;
  String title;
  void Function() onCompleteBuildWidget;

  LayoutCustomAppBar({this.title, this.body, this.onCompleteBuildWidget});

  @override
  Widget build(BuildContext context) {
    //WidgetsBinding.instance.addPostFrameCallback((_) => onCompleteBuildWidget);
    return Scaffold(
        backgroundColor: Color(ListColor.color4),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(_appBar.preferredSize.height),
            child: SafeArea(
              child: Container(
                color: Color(ListColor.color4),
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      right: 0,
                      child: Image(
                        image: AssetImage(GlobalVariable.imagePath +
                            "fallin_star_3_icon.png"),
                        height: _appBar.preferredSize.height,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: _backButtonWidget()),
                          Align(
                              alignment: Alignment.center,
                              child: _titleProfileWidget())
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle.light,
          child: body,
        ));
  }

  Widget _titleProfileWidget() {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
    );
  }

  Widget _backButtonWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: ClipOval(
          child: Material(
              shape: CircleBorder(),
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      child: Center(
                          child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30 * 0.7,
                        color: Color(ListColor.color4),
                      ))))),
        ),
      ),
    );
  }
}
