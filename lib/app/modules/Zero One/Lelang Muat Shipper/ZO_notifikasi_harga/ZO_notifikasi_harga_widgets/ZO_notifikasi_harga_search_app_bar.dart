import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoNotifikasiHargaSearchAppBar extends StatelessWidget {
  final String hintText;
  final void Function(String) onChanged;
  final void Function(String) onSubmitted;
  final String initialSearch;

  const ZoNotifikasiHargaSearchAppBar({
    Key key,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.initialSearch,
  }) : super(key: key);

  InputBorder _getBorder(BuildContext context, bool isWithBorder) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: isWithBorder
            ? BorderSide(
                color: Color(ListColor.colorLightGrey10),
                width: GlobalVariable.ratioWidth(context) * 1.0,
              )
            : BorderSide.none,
      );

  @override
  Widget build(BuildContext context) {
    String text = initialSearch;
    bool showClear = text?.isNotEmpty ?? false;
    debugPrint('tff-build($text)');
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: ClipOval(
                    child: Material(
                      shape: const CircleBorder(),
                      color: Color(ListColor.colorBlue),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: GlobalVariable.ratioFontSize(context) * 24,
                          height: GlobalVariable.ratioFontSize(context) * 24,
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: GlobalVariable.ratioFontSize(context) * 14,
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
                        GestureDetector(
                          onTap: () {},
                          child: CustomTextField(
                            context: context,
                            controller: (TextEditingController(text: text)
                              ..selection = TextSelection.collapsed(
                                offset: text?.length ?? 0,
                              )),
                            onChanged: (value) {
                              debugPrint('tff-onChanged($value)');
                              onChanged?.call(value);
                              setState(() {
                                text = value;
                                showClear = text?.isNotEmpty ?? false;
                              });
                            },
                            enabled: true,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {
                              debugPrint('tff-onSubmitted($value)');
                              setState(() {
                                text = value;
                                showClear = text?.isNotEmpty ?? false;
                              });
                              onSubmitted?.call(value);
                              FocusManager.instance.primaryFocus.unfocus();
                            },
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            newContentPadding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(context) * 36,
                              vertical: GlobalVariable.ratioWidth(context) * 6,
                            ),
                            textSize: 14,
                            newInputDecoration: InputDecoration(
                              isDense: true,
                              isCollapsed: true,
                              hintText: hintText,
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                color: Color(ListColor.colorLightGrey2),
                                fontWeight: FontWeight.w600,
                              ),
                              enabledBorder: _getBorder(context, true),
                              border: _getBorder(context, true),
                              focusedBorder: _getBorder(context, true),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(context) * 8,
                          ),
                          child: SvgPicture.asset(
                            "assets/search_magnifition_icon.svg",
                            width: GlobalVariable.ratioFontSize(context) * 20,
                            height: GlobalVariable.ratioFontSize(context) * 20,
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
                                      text = '';
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
              ],
            ),
          ]),
    );
  }
}
