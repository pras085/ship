import 'package:flutter/material.dart';
import 'package:muatmuat/app/template/widgets/detail_expansion_buyer/child_detail_expansion_buyer.dart';
import 'package:muatmuat/global_variable.dart';

class TextDetailExpansionBuyer extends ChildDetailExpansionBuyer {

  final String text;
  final bool isExpanded;
  final bool isInitialize;

  TextDetailExpansionBuyer({
    @required this.text,
    @required this.isExpanded,
    @required this.isInitialize,
  });

  @override
  Widget build(BuildContext context) {
    final textE = !isInitialize ? text : isExpanded ? text : text.length > 285 ? "${text.substring(0, 285)}..." : text;
    return Text(textE,
      style: TextStyle(
        fontSize: GlobalVariable.ratioWidth(context) * 14,
        height: 1.2,
        fontFamily: "AvenirNext",
        fontWeight: FontWeight.w400,
      ),
      // maxLines: !isInitialize ? null : isExpanded ? null : 6,
      // overflow: !isInitialize ? null : isExpanded ? null : TextOverflow.ellipsis,
    );
  }
}