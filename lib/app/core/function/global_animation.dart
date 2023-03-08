import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';

class LoadingAnimation extends StatelessWidget {
  LoadingAnimation(
    this.showImage,
    this.firstActive,
    this.secondActive,
    this.thirdActive,
  );

  bool showImage;
  bool firstActive;
  bool secondActive;
  bool thirdActive;
  var duration = 400;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Color(0x20000000),
        child: Container(
            width: 107,
            height: 107,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 7),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: AnimatedContainer(
                    margin: EdgeInsets.only(top: showImage ? 0 : 7),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: Image(
                      image: AssetImage("assets/loading_image.png"),
                      height: 87,
                    ),
                  ),
                  // child: AnimatedOpacity(
                  //   opacity: showImage ? 1.0 : 0.0,
                  //   duration: Duration(milliseconds: 500),
                  //   curve: Curves.easeInOut,
                  //   child: Image(
                  //     image: AssetImage("assets/loading_image.png"),
                  //     height: 87,
                  //   ),
                  // ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: double.infinity,
                      height: 20,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AnimatedContainer(
                              curve: Curves.bounceInOut,
                              duration: Duration(milliseconds: duration),
                              margin:
                                  EdgeInsets.only(left: firstActive ? 0 : 5),
                              width: firstActive ? 20 : 10,
                              height: firstActive ? 20 : 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      firstActive ? 20 : 10),
                                  color: firstActive
                                      ? Color(ListColor.color4)
                                      : Colors.grey),
                            ),
                          ),
                          AnimatedContainer(
                            curve: Curves.bounceInOut,
                            duration: Duration(milliseconds: duration),
                            width: secondActive ? 20 : 10,
                            height: secondActive ? 20 : 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    secondActive ? 20 : 10),
                                color: secondActive
                                    ? Color(ListColor.color4)
                                    : Colors.grey),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: AnimatedContainer(
                              curve: Curves.bounceInOut,
                              duration: Duration(milliseconds: duration),
                              margin:
                                  EdgeInsets.only(right: thirdActive ? 0 : 5),
                              width: thirdActive ? 20 : 10,
                              height: thirdActive ? 20 : 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      thirdActive ? 20 : 10),
                                  color: thirdActive
                                      ? Color(ListColor.color4)
                                      : Colors.grey),
                            ),
                          )
                        ],
                      )),
                )
              ],
            )));
  }
}
