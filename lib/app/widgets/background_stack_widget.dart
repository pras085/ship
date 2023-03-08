import 'package:flutter/material.dart';
import 'package:muatmuat/app/style/list_colors.dart';

class BackgroundStackWidget extends StatelessWidget {
  @required
  Widget body;
  BackgroundStackWidget({this.body});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color(ListColor.color4),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            left: -70,
            child: Image(
              image: AssetImage("assets/supergraphics1_icon.png"),
              width: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            bottom: -30,
            right: -70,
            child: Image(
              image: AssetImage("assets/supergraphics2_icon.png"),
              width: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(alignment: Alignment.center, child: body),
        ],
      ),
    );
  }
}
