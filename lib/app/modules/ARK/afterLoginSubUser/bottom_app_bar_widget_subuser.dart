import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class BottomAppBarMuatSubuser extends StatefulWidget {
  BottomAppBarMuatSubuser({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<BottomAppBarItemModel> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => BottomAppBarMuatSubuserState();
}

class BottomAppBarMuatSubuserState extends State<BottomAppBarMuatSubuser> {
  int _selectedIndex = 0;
  //bool _onPressedMenu = false;
  final double _radiusBorderTopLeftRight = 15;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return Container(
      decoration: BoxDecoration(
        //Here goes the same radius, u can put into a var or function
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(_radiusBorderTopLeftRight),
          topLeft: Radius.circular(_radiusBorderTopLeftRight),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x54000000),
            spreadRadius: 2,
            blurRadius: 80,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(_radiusBorderTopLeftRight),
          topLeft: Radius.circular(_radiusBorderTopLeftRight),
        ),
        child: BottomAppBar(
          shape: widget.notchedShape,
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items,
            ),
          ),
          color: widget.backgroundColor,
        ),
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        // child: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     SizedBox(height: widget.iconSize),
        //     Text(
        //       widget.centerItemText ?? '',
        //       style: TextStyle(color: widget.color),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  Widget _buildTabItem({
    BottomAppBarItemModel item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    // Color color = _selectedIndex == index && _onPressedMenu
    //     ? widget.selectedColor
    //     : widget.color;
    Color color = widget.selectedColor;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            onHighlightChanged: (value) {
              setState(() {
                _selectedIndex = index;
                //_onPressedMenu = value;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  GlobalVariable.imagePath + "" + item.iconName,
                  color: color,
                ),
                //Icon(item.iconData, color: color, size: widget.iconSize),
                // Text(
                //   item.text,
                //   style: TextStyle(color: color),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
