import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:readmore/readmore.dart';

import 'tentang_perusahaan_controller.dart';
import 'tentang_perusahaan_model.dart';

class TentangPerusahaanView extends GetView<TentangPerusahaanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ListColor.colorWhite),
      appBar: AppBarProfile(
        isBlueMode: true,
        isWithBackgroundImage: true,
        title: "Tentang Perusahaan",
        isCenter: false,
        isWithShadow: false,
      ),
      body: Obx(() {
        if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
          return _content(context, controller.dataModelResponse.value.data);
        } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
          return ErrorDisplayComponent(
            "${controller.dataModelResponse.value.exception}",
            onRefresh: () => controller.fetchTransporterData(),
          );
        }
        return LoadingComponent();
      }),
    );
  }

  Widget _content(BuildContext context, TentangPerusahaanModel snapData) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // company profile start here
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(context) * 20,
              horizontal: GlobalVariable.ratioWidth(context) * 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _contentDataPerusahaan(context: context, title: "Area Layanan", value: controller.areaLayananC.toString()),
                _contentDataPerusahaan(context: context, title: "Customer", value: controller.customerC.toString()),
                _contentDataPerusahaan(context: context, title: "Portfolio", value: controller.portofolioC.toString()),
                _contentDataPerusahaan(context: context, title: "Tahun mulai usaha", value: controller.tahunMulaiC),
                _contentDataPerusahaan(context: context, title: "Tahun pendirian badan usaha", value: controller.tahunPendirianC),
                _contentDataPerusahaan(context: context, title: "Keunggulan", value: controller.keunggulanC.toString()),
                _contentDataPerusahaan(context: context, title: "Layanan tambahan", value: controller.layananC.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentDataPerusahaan({
    @required BuildContext context,
    String title,
    String value,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(context) * 16,
        horizontal: GlobalVariable.ratioWidth(context) * 10,
      ),
      constraints: BoxConstraints(
        minHeight: GlobalVariable.ratioWidth(context) * 74,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: GlobalVariable.ratioWidth(context) * 1,
            color: Color(ListColor.colorLightGrey2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title ?? "-",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 6), // -2, cz custom text have 2px extra margin
          (value != null || value != '')
              ? ReadMoreText(
                  value,
                  trimLines: 5,
                  delimiter: ' ',
                  colorClickableText: Color(ListColor.colorBlueTemplate1),
                  trimMode: TrimMode.Line,
                  style: TextStyle(
                    color: Color(ListColor.colorBlack),
                    fontSize: GlobalVariable.ratioWidth(context) * 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'AvenirNext',
                    height: GlobalVariable.ratioWidth(context) * (16.8 / 14),
                  ),
                  trimCollapsedText: 'lihat lainnya',
                  trimExpandedText: 'sembunyikan lainnya',
                  moreStyle: TextStyle(
                    color: Color(ListColor.colorBlueTemplate1),
                    fontSize: GlobalVariable.ratioWidth(context) * 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'AvenirNext',
                  ),
                )
              : CustomText('-')
        ],
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;

  const ExpandableText({
    Key key,
    @required this.text,
    this.trimLines,
  }) : super(key: key);
  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool readMore = true;
  void onTap() {
    setState(() {
      readMore = !readMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextSpan link = TextSpan(
      text: readMore ? "lihat lainnya" : "sembunyikan lainnya",
      style: TextStyle(
        color: Color(ListColor.colorBlue),
        fontFamily: "AvenirNext",
        fontSize: GlobalVariable.ratioWidth(context) * 14,
        fontWeight: FontWeight.w600,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
    Widget result = LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraint) {
        assert(constraint.hasBoundedWidth);
        final double maxWidth = constraint.maxWidth;
        final text = TextSpan(text: widget.text);
        TextPainter textPainter = TextPainter(
          text: link,
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraint.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        textPainter.text = text;
        textPainter.layout(minWidth: constraint.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        int endIndex;
        final pos = textPainter.getPositionForOffset(
          Offset(textSize.width - linkSize.width, textSize.height),
        );
        endIndex = textPainter.getOffsetBefore(pos.offset);
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: TextStyle(
              color: Color(ListColor.colorBlue),
              fontFamily: "AvenirNext",
              fontSize: GlobalVariable.ratioWidth(context) * 14,
              fontWeight: FontWeight.w600,
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(text: widget.text);
        }
      },
    );
    return result;
  }
}
