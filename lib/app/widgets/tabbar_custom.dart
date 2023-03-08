import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class TabbarCustom extends StatefulWidget {
  List<String> listMenu;
  int pos;
  void Function(int) onClickTab;
  double heightMenu;

  TabbarCustom(
      {@required this.listMenu,
      @required this.onClickTab,
      @required this.pos,
      this.heightMenu = 50});

  @override
  _TabbarCustomState createState() => _TabbarCustomState();
}

class _TabbarCustomState extends State<TabbarCustom> {
  bool isExpanded = false;
  bool isFirstTime = true;
  GlobalKey containerKey = GlobalKey();
  final AutoScrollController _autoScrollController = AutoScrollController();

  void _onCompleteBuild(BuildContext context) {
    if (isFirstTime) {
      isFirstTime = false;
      double widthScreen = MediaQuery.of(context).size.width;
      final renderObject =
          containerKey.currentContext?.findRenderObject() as RenderBox;
      double widthContainer = renderObject.size.width;
      if (widthScreen >= widthContainer) {
        isExpanded = true;
        setState(() {});
      }
    }
    _autoScrollController.scrollToIndex(widget.pos);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _onCompleteBuild(context));
    return Container(
     width: MediaQuery.of(context).size.width,
      height: GlobalVariable.ratioWidth(context) * widget.heightMenu,
      child: isExpanded
          ? Row(
              mainAxisSize: MainAxisSize.max,
              children: _allItemMenu(),
            )
          : ListView(
              controller: _autoScrollController,
              scrollDirection: Axis.horizontal,
              children: [
                  Container(
                    key: containerKey,
                    child: Row(children: _allItemMenu()),
                  )
                ]),
    );
  }

  Widget _perItem(String item, int index) {
    return isExpanded
        ? Expanded(
            child: _perItemDetail(item, index),
          )
        : _perItemDetail(item, index);
  }

  Widget _perItemDetail(String item, int index) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: _autoScrollController,
      index: index,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            widget.onClickTab(index);
          },
          child: Container(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16),
            decoration: BoxDecoration(
                border: Border(
                    //top: BorderSide(width: 1, color: Colors.transparent),
                    bottom: BorderSide(
                        width: 2,
                        color: index == widget.pos
                            ? Color(ListColor.color4)
                            : Color(ListColor.colorLightGrey10)))),
            child: Center(
                child: CustomText(item,
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    color: Color(index == widget.pos
                        ? ListColor.color4
                        : ListColor.colorLightGrey2))),
          ),
        ),
      ),
    );
  }

  List<Widget> _allItemMenu() {
    List<Widget> listWidget = [];
    for (int i = 0; i < widget.listMenu.length; i++) {
      listWidget.add(_perItem(widget.listMenu[i], i));
    }
    return listWidget;
  }
}
