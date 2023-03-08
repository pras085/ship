import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/dropdown_overlay.dart';
import 'package:muatmuat/global_variable.dart';


class DropdownFilter extends StatelessWidget {
  // final List truck;
  // final List carrier;

  // const DropdownFilter({
  //   @required this.truck,
  //   @required this.carrier
  // });

  @override
  Widget build(BuildContext context) {
    // timeago.setLocaleMessages('id', LocaleMessagesId());
    // timeago.setLocaleMessages('en', LocaleMessagesEn());

    // int maxLength = 0;
    // for (var i = 0; i < description.keys.toList().length; i++) {
    //   if (description.keys.toList()[i].length >= maxLength) {
    //     maxLength = description.keys.toList()[i].length;
    //   }
    // }

    // if (maxLength > 10) maxLength = 10;
    List<dynamic> truck = ['Analis', 'GG', 'Hino', 'Dutro'];
    List<dynamic> carrier = ['Analis', 'GG', 'Hino', 'Dutro'];
    return Padding(
      padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(context) * 16),
      child: Container(
        height: GlobalVariable.ratioWidth(context) * 100,
        width: GlobalVariable.ratioWidth(context) * 328,
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Jenis Truk dan Carrier',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(context) * 12
            ),
          Row(
            children: [
              Container(
                height: GlobalVariable.ratioWidth(context) * 33,
                width: GlobalVariable.ratioWidth(context) * 160,
                child: DropdownOverlay(
                // bgColor: controller.postalCodeList == [] ? Color(0xFFCECECE) : Color(ListColor.colorWhite), 
        // value: controller.pilihKodePos.value != null
        //               ? controller.pilihKodePos.value.toString()
        //               : null,
        dataList: List<dynamic>.from(truck),
        // contentPadding: EdgeInsets.symmetric(
        //     vertical: GlobalVariable.ratioWidth(Get.context) * 6,
        //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
        // ),
        itemBuilder: (ctx, data) {
                return GestureDetector(
                  onTap: () {
                    // print(data.toString() +' refo');
                    //  print(data['ID'].toString() + ' refo');

                    // controller.choosentruck.value =  data['ID'].toString();
                    // controller.jenistruk.value = data['Description'].toString();
                    // FocusManager.instance.primaryFocus.unfocus();

                      // controller.chooseTruck(data['ID'].toString(), data['Description'].toString());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 6,
                    ),
                    child: CustomText(data.toString(),
                      color: Color(ListColor.colorLightGrey4),
                      withoutExtraPadding: true,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
        },
        borderWidth: GlobalVariable.ratioWidth(Get.context) * 1,
        radius: GlobalVariable.ratioWidth(Get.context) * 6,
        borderColor: FocusScope.of(Get.context).hasFocus ? Color(ListColor.colorBlue) ?? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey2),
        builder: (ctx, data, isOpen, hasFocus) {
                return Container(
                  height: GlobalVariable.ratioWidth(Get.context) *  40,
                  child: Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                      side: BorderSide(
                        color: hasFocus ? Color(ListColor.colorBlue) ?? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey2),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child:
                            CustomText('Pilih Truck'),
                            // CustomText(controller.jenistruk.value == "" ? 'Pilih Jenis Truk' : controller.jenistruk.value, color: controller.jenistruk.value == "" ? Color(0xFFCECECE) : Colors.black,) 
                            // CustomText(controller.pilihKodePos.value != null ? controller.kodepos.value : controller.districtController.value.text == ""
                            //       ? 'Pilih Kecamatan terlebih dahulu'
                            //       : 'RegisterSellerPerusahaanIndexLabelFieldKodePos2'.tr),
                          ),
                          SvgPicture.asset(isOpen ? GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_up.svg' : GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_down.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 16,
                            height: GlobalVariable.ratioWidth(Get.context) * 16,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
              ),
      SizedBox(width: GlobalVariable.ratioWidth(context) * 8,),
      Container(
                height: GlobalVariable.ratioWidth(context) * 33,
                width: GlobalVariable.ratioWidth(context) * 160,
                child: DropdownOverlay(
                // bgColor: controller.postalCodeList == [] ? Color(0xFFCECECE) : Color(ListColor.colorWhite), 
        // value: controller.pilihKodePos.value != null
        //               ? controller.pilihKodePos.value.toString()
        //               : null,
        dataList: List<dynamic>.from(carrier),
        // contentPadding: EdgeInsets.symmetric(
        //     vertical: GlobalVariable.ratioWidth(Get.context) * 6,
        //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
        // ),
        itemBuilder: (ctx, data) {
                return GestureDetector(
                  onTap: () {
                    // print(data.toString() +' refo');
                    //  print(data['ID'].toString() + ' refo');

                    // controller.choosentruck.value =  data['ID'].toString();
                    // controller.jenistruk.value = data['Description'].toString();
                    // FocusManager.instance.primaryFocus.unfocus();

                      // controller.chooseTruck(data['ID'].toString(), data['Description'].toString());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 6,
                    ),
                    child: CustomText(data.toString(),
                      color: Color(ListColor.colorLightGrey4),
                      withoutExtraPadding: true,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
        },
        borderWidth: GlobalVariable.ratioWidth(Get.context) * 1,
        radius: GlobalVariable.ratioWidth(Get.context) * 6,
        borderColor: FocusScope.of(Get.context).hasFocus ? Color(ListColor.colorBlue) ?? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey2),
        builder: (ctx, data, isOpen, hasFocus) {
                return Container(
                  height: GlobalVariable.ratioWidth(Get.context) *  40,
                  child: Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                      side: BorderSide(
                        color: hasFocus ? Color(ListColor.colorBlue) ?? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey2),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child:
                            CustomText('Pilih Carrier'),
                            // CustomText(controller.jenistruk.value == "" ? 'Pilih Jenis Truk' : controller.jenistruk.value, color: controller.jenistruk.value == "" ? Color(0xFFCECECE) : Colors.black,) 
                            // CustomText(controller.pilihKodePos.value != null ? controller.kodepos.value : controller.districtController.value.text == ""
                            //       ? 'Pilih Kecamatan terlebih dahulu'
                            //       : 'RegisterSellerPerusahaanIndexLabelFieldKodePos2'.tr),
                          ),
                          SvgPicture.asset(isOpen ? GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_up.svg' : GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_down.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 16,
                            height: GlobalVariable.ratioWidth(Get.context) * 16,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
              ),
            
            ],
          )  
          ],
        )
        ,
      ),
    );
  }
}