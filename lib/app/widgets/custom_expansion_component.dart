import 'package:flutter/material.dart';

class CustomExpansionComponent extends StatefulWidget {
  final Widget header;
  final Widget content;
  final bool isOpen;

  const CustomExpansionComponent({
    Key key,
    @required this.header,
    @required this.content,
    @required this.isOpen,
  }) : super(key: key);

  @override
  _CustomExpansionComponentState createState() =>
      _CustomExpansionComponentState();
}

class _CustomExpansionComponentState extends State<CustomExpansionComponent>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.header,
        AnimatedSize(
          duration: Duration(
            milliseconds: 500,
          ),
          curve: Curves.easeIn,
          vsync: this,
          child: widget.isOpen ? widget.content : Container(),
        ),
      ],
    );
  }
}
