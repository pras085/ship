import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';

import 'package:muatmuat/app/widgets/custom_expansion_component.dart';
import 'package:muatmuat/global_variable.dart';

class SubscriptionPilihMetodePembayaranExpansionComponent
    extends StatefulWidget {
  final Widget header;
  final Widget content;
  final bool initiallyOpen;

  const SubscriptionPilihMetodePembayaranExpansionComponent({
    Key key,
    @required this.header,
    @required this.content,
    this.initiallyOpen = false,
  }) : super(key: key);

  @override
  _SubscriptionPilihMetodePembayaranExpansionComponentState createState() =>
      _SubscriptionPilihMetodePembayaranExpansionComponentState();
}

class _SubscriptionPilihMetodePembayaranExpansionComponentState
    extends State<SubscriptionPilihMetodePembayaranExpansionComponent> {
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    isOpen = widget.initiallyOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          GlobalVariable.ratioWidth(context) * 10,
        ),
        side: BorderSide(
          color: Color(ListColor.colorLightGrey10),
        ),
      ),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: CustomExpansionComponent(
        header: Material(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(ListColor.colorLightGrey10),
            ),
          ),
          color: Colors.white,
          elevation: 5,
          child: InkWell(
            onTap: () => setState(() {
              isOpen = !isOpen;
            }),
            child: Padding(
              padding: EdgeInsets.all(
                GlobalVariable.ratioWidth(context) * 12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: widget.header,
                  ),
                  SvgPicture.asset(
                    isOpen
                        ? GlobalVariable.urlImageTemplateBuyer + "ic_chevron_up.svg"
                        : GlobalVariable.urlImageTemplateBuyer + "ic_chevron_down.svg",
                    width: GlobalVariable.ratioWidth(context) * 24,
                    height: GlobalVariable.ratioWidth(context) * 24,
                  ),
                ],
              ),
            ),
          ),
        ),
        isOpen: isOpen,
        content: widget.content,
      ),
    );
  }
}
