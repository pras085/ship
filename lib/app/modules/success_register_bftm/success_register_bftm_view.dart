import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class SuccessRegisterBFTM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Get.offNamed(Routes.FAKE_HOME);
        Get.offNamed(Routes.AFTER_LOGIN_SUBUSER);
        return false;
      },
      child: Container(
        color: Color(ListColor.colorWhite),
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset("assets/meteor_biru.png", 
                    width: GlobalVariable.ratioWidth(Get.context) * 91, 
                    height: GlobalVariable.ratioWidth(Get.context) * 91,),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(context) * 120, 
                            GlobalVariable.ratioWidth(context) * 88, 
                            GlobalVariable.ratioWidth(context) * 120, 
                            GlobalVariable.ratioWidth(context) * 46.19
                          ),
                          child: SvgPicture.asset(
                            'assets/ic_logo_muat_emoji.svg',
                            width: GlobalVariable.ratioWidth(context) * 120,
                            height: GlobalVariable.ratioWidth(context) * 119.63,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(context) * 16,
                            GlobalVariable.ratioWidth(context) * 0,
                            GlobalVariable.ratioWidth(context) * 16,
                            GlobalVariable.ratioWidth(context) * 20
                          ),
                          width: GlobalVariable.ratioWidth(context) * 328,
                          child: CustomText(
                            "BFTMRegisterAllSuccessTitle".tr,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.center,
                            height: 1.2,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(context) * 16,
                            GlobalVariable.ratioWidth(context) * 0,
                            GlobalVariable.ratioWidth(context) * 16,
                            GlobalVariable.ratioWidth(context) * 237.3
                          ),
                          width: double.infinity,
                          child: CustomText(
                            "BFTMRegisterAllSuccessDesc".tr,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            color: Color(ListColor.colorLightGrey14),
                            height: 1.2,
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            // Get.offNamed(Routes.FAKE_HOME);
                            Get.offNamed(Routes.AFTER_LOGIN_SUBUSER);
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                              GlobalVariable.ratioWidth(context) * 16,
                              GlobalVariable.ratioWidth(context) * 0,
                              GlobalVariable.ratioWidth(context) * 16,
                              GlobalVariable.ratioWidth(context) * 140
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: GlobalVariable.ratioWidth(context) * 9,
                            ),
                            width: double.infinity,
                            height: GlobalVariable.ratioWidth(context) * 36,
                            decoration: BoxDecoration(
                              color: Color(ListColor.colorBlue),
                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 18),
                            ),
                            child: Center(
                              child: CustomText(
                                "BFTMRegisterAllJelajahiProdukLain".tr,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(ListColor.colorWhite),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}