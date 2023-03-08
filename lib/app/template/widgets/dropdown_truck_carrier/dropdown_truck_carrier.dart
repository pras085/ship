import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/dropdown_overlay.dart';

import '../../../../global_variable.dart';

class DropdownTruckCarrierBuyer extends StatelessWidget {

  final String title;
  final String valueTruck;
  final String valueCarrier;
  final List<String> dataListTruck;
  final List<String> dataListCarrier;
  final Function(String valueTruck) onSelectedTruck;
  final Function(String valueTruck) onSelectedCarrier;

  const DropdownTruckCarrierBuyer({
    Key key,
    @required this.title,
    @required this.valueTruck,
    @required this.valueCarrier,
    @required this.onSelectedTruck,
    @required this.onSelectedCarrier,
    @required this.dataListTruck,
    @required this.dataListCarrier,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          fontSize: 14,
          color: Color(ListColor.colorBlack),
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: GlobalVariable.ratioWidth(context) * 12,
        ),
        Row(
          children: [
            Expanded(
              child: _OutlineDropdownComponent(
                selectedData: valueTruck, 
                dataList: dataListTruck, 
                onSelected: (value) => onSelectedTruck(value), 
                hint: "BFTMRegisterTransporterPilihJenisTruk".tr,
              ),
            ),
            SizedBox(
              width: GlobalVariable.ratioWidth(context) * 8,
            ),
            Expanded(
              child: _OutlineDropdownComponent(
                selectedData: valueCarrier, 
                dataList: dataListCarrier, 
                onSelected: (value) => onSelectedCarrier(value), 
                hint: "BFTMRegisterTransporterPilihJenisCarrier".tr,
              ),
            )
          ],
        ),
      ],
    );
  }

}

class _OutlineDropdownComponent extends StatelessWidget {

  final String selectedData;
  final List<String> dataList;
  final Function(String value) onSelected;
  final String hint;
  final Color focusColor;

  const _OutlineDropdownComponent({
    Key key,
    @required this.selectedData,
    @required this.dataList,
    @required this.onSelected,
    this.hint = "choose..",
    this.focusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownOverlay<String>(
      value: selectedData,
      dataList: dataList,
      contentPadding: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(context) * 6,
        horizontal: GlobalVariable.ratioWidth(context) * 12,
      ),
      isExpanded: false,
      itemBuilder: (ctx, data) {
        return GestureDetector(
          onTap: () {
            onSelected(data);
            FocusScope.of(ctx).unfocus();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(context) * 6,
            ),
            child: CustomText(data,
              color: Color(ListColor.colorLightGrey4),
              withoutExtraPadding: true,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
      borderWidth: GlobalVariable.ratioWidth(context) * 1,
      radius: GlobalVariable.ratioWidth(context) * 6,
      borderColor: FocusScope.of(context).hasFocus ? focusColor ?? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey2),
      builder: (ctx, data, isOpen, hasFocus) {
        return Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
            side: BorderSide(
              color: hasFocus ? focusColor ?? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey2),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(context) * 8,
              horizontal: GlobalVariable.ratioWidth(context) * 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(data != null ? data : hint),
                ),
                SvgPicture.asset(isOpen ? GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_up.svg' : GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_down.svg',
                  width: GlobalVariable.ratioWidth(context) * 16,
                  height: GlobalVariable.ratioWidth(context) * 16,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}