import 'package:flutter/material.dart';

class ScrollParentComponent extends StatelessWidget {

  final ScrollController controller;
  final Function(bool isBottom) onBottom;
  final Widget child;

  const ScrollParentComponent({
    Key key,
    @required this.controller,
    this.onBottom,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollNotification>(
      onNotification: (OverscrollNotification value) {
        if (onBottom != null) onBottom(value.metrics.pixels > 0 && value.metrics.atEdge);
        if (value.overscroll < 0 && controller.offset + value.overscroll <= 0) {
          if (controller.offset != 0) controller.jumpTo(0);
          return true;
        }
        if (controller.offset + value.overscroll >= controller.position.maxScrollExtent) {
          if (controller.offset != controller.position.maxScrollExtent) {
            controller.jumpTo(controller.position.maxScrollExtent);
          }
          return true;
        }
        controller.jumpTo(controller.offset + value.overscroll);
        return true;
     },
     child: child,
    );
  }
}