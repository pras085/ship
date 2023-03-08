import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/download_utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class DataTestimoniPortofolioBuyer {

  final String url;
  final String name;

  const DataTestimoniPortofolioBuyer({
    this.url,
    this.name,
  });

}

class TestimoniPortofolioBuyer extends StatelessWidget {
  final List<DataTestimoniPortofolioBuyer> dataList;

  const TestimoniPortofolioBuyer({
    Key key,
    @required this.dataList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          'Testimoni / Portfolio',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          withoutExtraPadding: true,
          height: 19.2/16,
        ),
        SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
        ListView.builder(
          shrinkWrap: true,
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  DownloadUtils.doDownload(
                    context: context, 
                    url: dataList[index].url,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(context) * 10,
                    horizontal: GlobalVariable.ratioWidth(context) * 20,
                  ),
                  margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(context) * 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 8),
                    border: Border.all(
                      color: Color(ListColor.colorGreyTemplate3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        GlobalVariable.urlImageTemplateBuyer + 'temp-check-paper.svg',
                        color: Color(ListColor.colorBlackTemplate),
                        height: GlobalVariable.ratioWidth(context) * 24,
                      ),
                      SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                      Expanded(
                        child: CustomText(
                          dataList[index].name,
                          withoutExtraPadding: true,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
