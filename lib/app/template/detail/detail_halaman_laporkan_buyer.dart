import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:muatmuat/global_variable.dart';

class DetailHalamanLaporkanBuyer extends StatelessWidget {
  final List<String> listReport;
  final RxString selectedValue;
  final Function onUploadTap;
  final Function onCancelTap;
  final Function onNextTap;
  RxBool isCheck;

  DetailHalamanLaporkanBuyer({
    @required this.listReport,
    @required this.selectedValue,
    @required this.onUploadTap,
    this.onCancelTap,
    this.onNextTap,
  });

  Widget build(BuildContext context) {
    return Container(
      height: GlobalVariable.ratioWidth(context) * 328,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 20,
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            'Pilih kategori pelanggaran yang terjadi pada iklan ini',
            fontWeight: FontWeight.w700,
            height: 16.8 / 14,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 20),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  height: GlobalVariable.ratioWidth(context) * 0.5,
                  color: Color(ListColor.colorGreyTemplate8),
                  margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(context) * 16),
                );
              },
              shrinkWrap: true,
              itemCount: listReport.length,
              itemBuilder: (context, i) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioButtonCustom(
                      value: listReport[i],
                      colorSelected: Color(ListColor.colorBlue),
                      colorUnselected: Color(ListColor.colorGreyTemplate4),
                      groupValue: selectedValue.value,
                      onChanged: (value) {
                        selectedValue.value = value;
                      },
                      isWithShadow: true,
                      isDense: true,
                      width: GlobalVariable.ratioWidth(context) * 16,
                      height: GlobalVariable.ratioWidth(context) * 16,
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                    Expanded(
                      child: CustomText(
                        listReport[i],
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorGreyTemplate3),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void openBottomSheet({
    @required BuildContext context,
    @required TextEditingController textController,
    @required RxBool isChecked,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 16),
          topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 16),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: GlobalVariable.ratioWidth(context) * 604,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                  color: Color(ListColor.colorGreyTemplate7),
                ),
                width: GlobalVariable.ratioWidth(context) * 38,
                height: GlobalVariable.ratioWidth(context) * 3,
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(context) * 6,
                  bottom: GlobalVariable.ratioWidth(context) * 15,
                ),
              ),
              Container(
                height: GlobalVariable.ratioWidth(context) * 24,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: Get.back,
                        child: SvgPicture.asset(
                          GlobalVariable.urlImageTemplateBuyer + 'ic_close_grey.svg',
                          width: GlobalVariable.ratioWidth(context) * 24,
                          height: GlobalVariable.ratioWidth(context) * 24,
                          color: Color(ListColor.colorBlueTemplate1),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        "Laporkan Iklan",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
              Container(
                width: GlobalVariable.ratioWidth(context) * 328,
                height: GlobalVariable.ratioWidth(context) * 386,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'Detail Pelanggaran*',
                      fontWeight: FontWeight.w600,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(context) * 12, //coba
                        bottom: GlobalVariable.ratioWidth(context) * 16,
                      ),
                      padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 8),
                      height: GlobalVariable.ratioWidth(context) * 100,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(ListColor.colorGreyTemplate2)),
                      ),
                      child: CustomTextFormField(
                        context: context,
                        controller: textController,
                        newInputDecoration: InputDecoration(
                          hintText: 'Jelaskan pelanggaran yang terjadi',
                          hintStyle: TextStyle(
                            color: Color(ListColor.colorGreyTemplate8),
                            fontWeight: FontWeight.w500,
                            fontSize: GlobalVariable.ratioWidth(context) * 12,
                          ),
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    CustomText(
                      'Foto Bukti Laporan',
                      fontWeight: FontWeight.w600,
                      withoutExtraPadding: true,
                    ),
                    Container(
                      height: GlobalVariable.ratioWidth(context) * 76,
                      width: GlobalVariable.ratioWidth(context) * 192,
                      padding: EdgeInsets.zero,
                      color: Color(ListColor.colorWhiteTemplate),
                    ),
                    Container(
                      height: GlobalVariable.ratioWidth(context) * 32,
                      width: GlobalVariable.ratioWidth(context) * 328,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Color(ListColor.colorWhiteTemplate),
                        border: Border(
                          bottom: BorderSide(
                            color: Color(ListColor.colorGreyTemplate9),
                            width: GlobalVariable.ratioWidth(context) * 0.5,
                          ),
                          top: BorderSide(
                            color: Color(ListColor.colorGreyTemplate9),
                            width: GlobalVariable.ratioWidth(context) * 0.5,
                          ),
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(context) * 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CheckBoxCustom2(
                            onChanged: (bool) {},
                          ),
                          SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                          CustomText(
                            'Saya dengan ini menyataka bahwa segala informasi yang dilaporkan memang benar',
                            withoutExtraPadding: true,
                            color: Color(ListColor.colorGreyTemplate3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              componentFixedButton(
                onReportTap: () => openBottomSheet(
                  context: context,
                  textController: textController,
                  isChecked: isChecked,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget componentFixedButton({
    BuildContext context,
    Function onReportTap,
    RxString selectedValue,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 12,
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 24,
      ),
      decoration: BoxDecoration(
        color: Color(ListColor.colorWhiteTemplate),
        border: Border(
          bottom: BorderSide(
            color: Color(ListColor.colorGreyTemplate2),
            width: GlobalVariable.ratioWidth(context) * 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [

// ?          ),
        ],
      ),
    );
  }
}
