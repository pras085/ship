import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/widgets/detail_expansion_buyer/child_detail_expansion_buyer.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class DetailExpansionBuyer extends StatefulWidget {

  final String headerText;
  final double maxHeight;
  final EdgeInsetsGeometry padding;
  final ChildDetailExpansionBuyer Function(bool isExpand, bool isInitialize) child;

  const DetailExpansionBuyer({
    @required this.headerText,
    this.maxHeight,
    this.padding,
    @required this.child,
  });

  @override
  _DetailExpansionBuyerState createState() => _DetailExpansionBuyerState();
}

class _DetailExpansionBuyerState extends State<DetailExpansionBuyer> {

  final _childKey = GlobalKey();
  double childSize = 0;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      childSize = _childKey.currentContext.size.height;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: widget.padding ?? EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(widget.headerText,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 16,
                ),
                if (widget.maxHeight != null && (childSize != 0 && childSize > widget.maxHeight))
                  AnimatedContainer(
                    key: _childKey,
                    height: childSize != 0 ? isExpanded ? childSize : widget.maxHeight : null,
                    duration: Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.easeIn,
                    child: Stack(
                      children: [
                        widget.child(isExpanded, childSize != 0),
                        // if (!isExpanded)
                        //   Positioned(
                        //     left: 0,
                        //     right: 0,
                        //     bottom: 0,
                        //     child: Container(
                        //       width: double.infinity,
                        //       height: widget.maxHeight * (1/4),
                        //       decoration: BoxDecoration(
                        //         gradient: LinearGradient(
                        //           begin: Alignment.bottomCenter,
                        //           end: Alignment.topCenter,
                        //           colors: [
                        //             Colors.black.withOpacity(0.4),
                        //             Colors.black.withOpacity(0.2),
                        //             Colors.black.withOpacity(0),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  )
                else 
                  Container(
                    key: _childKey,
                    child: widget.child(isExpanded, childSize != 0),
                  ),
                // SizedBox(
                //   height: GlobalVariable.ratioWidth(context) * 16,
                // ),
              ],
            ),
          ),
          if (widget.maxHeight != null && childSize > widget.maxHeight)
            InkWell(
              onTap: () {
                isExpanded = !isExpanded;
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(ListColor.colorGreyTemplate2),
                      width: GlobalVariable.ratioWidth(context) * 0.5,
                    ),
                  ),
                ),
                width: double.infinity,
                height: GlobalVariable.ratioWidth(context) * 52,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(isExpanded ? "Sembunyikan" : "Lihat Selengkapnya",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(ListColor.colorBlueTemplate1),
                      ),
                      SvgPicture.asset(isExpanded ? GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_up_frame.svg' : GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_down_frame.svg',
                        width: GlobalVariable.ratioWidth(context) * 22,
                        height: GlobalVariable.ratioWidth(context) * 22,
                        color: Color(ListColor.colorBlueTemplate1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

}