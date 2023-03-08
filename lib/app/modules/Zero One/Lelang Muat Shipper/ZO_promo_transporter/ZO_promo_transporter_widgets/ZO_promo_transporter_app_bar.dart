import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterAppBar extends StatelessWidget {
  final bool isReadOnly;
  final void Function(String) onChanged;
  final void Function(String) onSubmit;
  final void Function() onTap;
  final void Function() onBackTap;
  final void Function() onSortTap;
  final bool isSortActive;
  final String text;
  const ZoPromoTransporterAppBar({
    Key key,
    this.isReadOnly = false,
    this.onChanged,
    this.onSubmit,
    this.onTap,
    this.onBackTap,
    this.onSortTap,
    this.isSortActive,
    this.text,
  }) : super(key: key);

  InputBorder _getBorder(bool isWithBorder) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: isWithBorder
            ? BorderSide(
                color: Color(ListColor.colorLightGrey10),
                width: GlobalVariable.ratioWidth(Get.context) * 1.0,
              )
            : BorderSide.none,
      );

  @override
  Widget build(BuildContext context) {
    final isDisabled = onSortTap == null;
    final sortBackgroundColor = isDisabled || !isSortActive
        ? Colors.transparent
        : Color(ListColor.colorBlack);
    final sortForegroundColor = isDisabled
        ? const Color(0xffD7D7D7)
        : isSortActive
            ? Color(ListColor.colorWhite)
            : isReadOnly
                ? Color(ListColor.colorBlue)
                : Color(ListColor.colorBlack);
    String _text = text;
    bool showClear = _text?.isNotEmpty ?? false;

    return Container(
      decoration: BoxDecoration(color: Color(ListColor.colorWhite), boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 15,
          color: Color(ListColor.colorBlack).withOpacity(0.15),
        )
      ]),
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Color(ListColor.colorWhite),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: ClipOval(
                        child: Material(
                          shape: const CircleBorder(),
                          color: Color(ListColor.colorBlue),
                          child: InkWell(
                            onTap: () async {
                              if (onBackTap == null) {
                                Get.back();
                              } else {
                                onBackTap();
                              }
                            },
                            child: Container(
                              width: GlobalVariable.ratioFontSize(context) * 24,
                              height:
                                  GlobalVariable.ratioFontSize(context) * 24,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: GlobalVariable.ratioFontSize(context) *
                                      14,
                                  color: Color(ListColor.colorWhite),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                    Expanded(
                      child: StatefulBuilder(builder: (context, setState) {
                        return Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            CustomTextField(
                              context: context,
                              enabled: true,
                              textInputAction: TextInputAction.search,
                              onTap: onTap,
                              controller: _text == null
                                  ? null
                                  : (TextEditingController(text: _text)
                                    ..selection = TextSelection.collapsed(
                                      offset: _text?.length ?? 0,
                                    )),
                              onSubmitted: (value) {
                                FocusManager.instance.primaryFocus.unfocus();
                                onSubmit?.call(value);
                              },
                              onChanged: (value) {
                                onChanged?.call(value);
                                if (value.isEmpty) {
                                  if (showClear) {
                                    setState(() {
                                      showClear = false;
                                      // if (text != null) {
                                      _text = value;
                                      // }
                                    });
                                  }
                                } else {
                                  if (!showClear) {
                                    setState(() {
                                      showClear = true;
                                      // if (text != null) {
                                      _text = value;
                                      // }
                                    });
                                  }
                                }
                              },
                              readOnly: isReadOnly,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              newContentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(context) * 36,
                                vertical:
                                    GlobalVariable.ratioWidth(context) * 6,
                              ),
                              textSize: 14,
                              newInputDecoration: InputDecoration(
                                isDense: true,
                                isCollapsed: true,
                                hintText:
                                    ZoPromoTransporterStrings.searchHint.tr,
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: TextStyle(
                                  color: Color(ListColor.colorLightGrey2),
                                  fontWeight: FontWeight.w600,
                                ),
                                enabledBorder: _getBorder(true),
                                border: _getBorder(true),
                                focusedBorder: _getBorder(true),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: GlobalVariable.ratioWidth(context) * 8,
                              ),
                              child: SvgPicture.asset(
                                "assets/search_magnifition_icon.svg",
                                width:
                                    GlobalVariable.ratioFontSize(context) * 20,
                                height:
                                    GlobalVariable.ratioFontSize(context) * 20,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: showClear
                                  ? GestureDetector(
                                      onTap: () {
                                        onChanged?.call('');
                                        setState(() {
                                          showClear = false;
                                          // if (text != null) {
                                          _text = '';
                                          // }
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: Color(ListColor.colorGrey3),
                                          size: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              24,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                    ClipOval(
                      child: Material(
                        shape: const CircleBorder(),
                        color: sortBackgroundColor,
                        child: InkWell(
                          onTap: onSortTap == null
                              ? null
                              : () {
                                  FocusManager.instance.primaryFocus.unfocus();
                                  onSortTap?.call();
                                },
                          child: Container(
                            width: GlobalVariable.ratioFontSize(context) * 24,
                            height: GlobalVariable.ratioFontSize(context) * 24,
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "assets/sorting_icon.svg",
                              color: sortForegroundColor,
                              height:
                                  GlobalVariable.ratioFontSize(context) * 24,
                              width: GlobalVariable.ratioFontSize(context) * 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
