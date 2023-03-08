import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas/ubah_kelengkapan_legalitas_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/download_utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import '../../../../global_variable.dart';

class ItemUbahKelengkapanLegalitasIndividuComponent extends StatefulWidget {

  final String title;
  final String valueString;
  final FileKelengkapanLegalitasComponent child;

  const ItemUbahKelengkapanLegalitasIndividuComponent({
    Key key,
    @required this.title,
    this.valueString,
    this.child,
  }) : super(key: key);

  @override
  _ItemUbahKelengkapanLegalitasIndividuComponentState createState() => _ItemUbahKelengkapanLegalitasIndividuComponentState();
}

class _ItemUbahKelengkapanLegalitasIndividuComponentState extends State<ItemUbahKelengkapanLegalitasIndividuComponent> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
        border: Border.all(
          color: Color(ListColor.colorGrey3),
          width: GlobalVariable.ratioWidth(context) * 0.5,
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(context) * 14,
        GlobalVariable.ratioWidth(context) * 10,
        GlobalVariable.ratioWidth(context) * 14,
        GlobalVariable.ratioWidth(context) * 12,
      ),
      margin: EdgeInsets.only(
        bottom: GlobalVariable.ratioWidth(context) * 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: (GlobalVariable.ratioWidth(context) * 14) * 2.3 / 11,
            ),
            child: RichText(
              text: TextSpan(
                text: widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: GlobalVariable.ratioWidth(context) * 14,
                  color: Color(ListColor.colorGrey3),
                  fontFamily: "AvenirNext",
                  height: GlobalVariable.ratioWidth(context) * 1.2,
                ),
              ),
            ),
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 10,
          ),
          if (widget.valueString != null)
            CustomText(widget.valueString,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            )
          else if (widget.child != null)
            widget.child,
        ],
      ),
    );
  }
  
}

class FileKelengkapanLegalitasComponent extends StatelessWidget {
  
  final String fileId;
  final String fileName;
  final String filePath;

  const FileKelengkapanLegalitasComponent({
    @required this.fileId,
    @required this.fileName,
    @required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    String iconAsset = "";
    final fFormat = filePath.split(".").last.toUpperCase();
    if (fFormat == "ZIP" 
    || fFormat == "PDF"
    || fFormat == "PNG"
    || fFormat == "JPG"
    || fFormat == "XLS"
    ) {
      iconAsset = "assets/ic_$fFormat.svg";
    } else if (fFormat == "JPEG") {
      iconAsset = "assets/ic_JPG.svg";
    } else {
      iconAsset = "assets/ic_XLS.svg";
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: GlobalVariable.ratioWidth(context) * 182,
      ),
      child: RawScrollbar(
        thumbColor: Color(ListColor.colorGrey3),
        thickness: GlobalVariable.ratioWidth(Get.context) * 4,
        radius: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(iconAsset,
                    width: GlobalVariable.ratioWidth(context) * 30,
                    height: GlobalVariable.ratioWidth(context) * 30,
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(context) * 8,
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(context) * 210,
                    child: CustomText(fileName,
                      color: Color(ListColor.colorBlue),
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            _iconDownload(
              context,
              fileId,
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconDownload(
    BuildContext context,
    String fileId,
  ) {
    return Container(
      margin: EdgeInsets.only(
        left: GlobalVariable.ratioWidth(context) * 12,
      ),
      child: InkWell(
        onTap: () {
          GlobalAlertDialog.showDialogWarningWithoutTitle(
            context: context,
            customMessage: Container(
              margin: EdgeInsets.only(
                bottom:
                    GlobalVariable.ratioWidth(context) *
                        20,
              ),
              width: GlobalVariable.ratioWidth(Get.context) * 296,
              child: CustomText("Password Dokumen Anda merupakan gabungan dari \"6 digit terakhir No. KTP Pendaftar/Pemegang Akun dan Kode Referral",
                textAlign: TextAlign.center,
                fontSize: 14,
                height: 22 / 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                withoutExtraPadding: true,
              ),
            ),
            labelButtonPriority1: "Unduh Dokumen",
            buttonWidth: 193,
            onTapPriority1: () async {
              try {
                final response = await ApiProfile(
                  context: Get.context,
                  isShowDialogLoading: true,
                  isShowDialogError: true,
                ).zipFileOnDownload({
                  'file': [fileId].toString(),
                });
                DownloadUtils.doDownload(
                  context: context,
                  url: response['Data']['Link'],
                );
              } catch (error) {
                print("Error : $error");
              }
            },
          );
        },
        child: SvgPicture.asset("assets/ic_download.svg",
          width: GlobalVariable.ratioWidth(context) * 18,
          height: GlobalVariable.ratioWidth(context) * 18,
          color: Color(ListColor.colorBlue),
        ),
      ),
    );
  }

}