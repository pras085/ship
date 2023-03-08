import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/file_example/file_example_controller.dart';
import 'package:muatmuat/app/widgets/double_tappable_interactive_viewer.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class FileExample extends GetView<FileExampleController> {
  const FileExample();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(ListColor.color4),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(context) * 16,
                          GlobalVariable.ratioWidth(context) * 16,
                          GlobalVariable.ratioWidth(context) * 8,
                          GlobalVariable.ratioWidth(context) * 16,
                        ),
                        width: GlobalVariable.ratioWidth(context) * 24,
                        height: GlobalVariable.ratioWidth(context) * 24,
                        child: CustomBackButton(
                          context: context, 
                          onTap: () {
                            Get.back();
                          },
                        )
                      ),
                      CustomText(
                        "BFTMRegisterAllContohFile".tr,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.downloadFile(controller.url.value);
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                      0,
                      GlobalVariable.ratioWidth(context) * 16,
                      GlobalVariable.ratioWidth(context) * 16,
                      GlobalVariable.ratioWidth(context) * 16,
                    ),
                    child: SvgPicture.asset(
                      'assets/ic_download.svg',
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    ),
                  ),
                )
              ],
            ),
            titleSpacing: 0,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            color: Colors.white,
            child: Obx(() => DoubleTappableInteractiveViewer(
              scaleDuration: Duration(milliseconds: 600),
              child:Image.network(
                controller.url.value,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
            ))
          ),
        ),
      ),
    );
  }
}