import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas/ubah_kelengkapan_legalitas_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/download_utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/scroll_parent_component.dart';

import '../../../../global_variable.dart';
import '../ubah_kelengkapan_legalitas_model.dart';

class ItemUbahKelengkapanLegalitasComponent extends StatefulWidget {

  final String title;
  final List<FileLegalitas> files;
  final String valueString;
  final String errorMessage;
  final VoidCallback onTapUpload;
  final Function(int id) onTapDelete;
  final bool isOpsional;
  final bool isUpload;
  final double progress;

  const ItemUbahKelengkapanLegalitasComponent({
    Key key,
    @required this.title,
    this.files,
    this.valueString,
    this.errorMessage = "",
    this.onTapUpload,
    this.onTapDelete,
    this.isOpsional = false,
    this.isUpload = false,
    this.progress,
  }) : super(key: key);

  @override
  _ItemUbahKelengkapanLegalitasComponentState createState() => _ItemUbahKelengkapanLegalitasComponentState();
}

class _ItemUbahKelengkapanLegalitasComponentState extends State<ItemUbahKelengkapanLegalitasComponent> {
  
  final ctrl = Get.find<UbahKelengkapanLegalitasController>();

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
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
                      children: [
                        if (widget.isOpsional)
                          TextSpan(
                            text: " (opsional)",    
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: GlobalVariable.ratioWidth(context) * 14,
                              color: Color(ListColor.colorGrey3),
                              fontFamily: "AvenirNext",
                              fontStyle: FontStyle.italic,
                              height: GlobalVariable.ratioWidth(context) * 1.2,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.files != null && widget.files.length > 1)
                _iconDownload(context),
            ],
          ),
          widget.errorMessage.trim().isNotEmpty ? _errorUpload(
            errorMessage: widget.errorMessage,
          ) :
          SizedBox.shrink(),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 10,
          ),
          if (widget.isUpload ?? false)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 9),
              ),
              margin: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(context) * 10,
              ),
              child: LinearProgressIndicator(
                value: widget.progress,
                valueColor: AlwaysStoppedAnimation(Color(ListColor.colorBlue)),
                backgroundColor: Color(ListColor.colorGrey3),
                minHeight: GlobalVariable.ratioWidth(context) * 4,
              ),
            )
          else Container(),
          if (widget.valueString != null)
            CustomText(widget.valueString,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            )
          else if (widget.files != null)
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: GlobalVariable.ratioWidth(context) * 182,
              ),
              child: RawScrollbar(
                thumbColor: Color(ListColor.colorGrey3),
                thickness: GlobalVariable.ratioWidth(Get.context) * 4,
                radius: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
                child: ScrollParentComponent(
                  controller: ctrl.scrollController,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.files.length,
                    itemBuilder: (ctx, i) {
                      String iconAsset = "";
                      final fFormat = widget.files[i].fileFilename.split(".").last.toUpperCase();
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
                      
                      return Container(
                        margin: EdgeInsets.only(
                          bottom: GlobalVariable.ratioWidth(context) * widget.files.length-1 == i ? 0 : 8,
                        ),
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
                                    width: GlobalVariable.ratioWidth(context) * (widget.isOpsional ? 202 : 210),
                                    child: CustomText(widget.files[i].name,
                                      color: Color(ListColor.colorBlue),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                if (widget.isOpsional)
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(context) * 12,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        GlobalAlertDialog.showAlertDialogCustom(
                                          context: context,
                                          title: "Hapus Dokumen",
                                          message: "Apakah Anda yakin akan menghapus dokumen ini?",
                                          labelButtonPriority1: "Batal",
                                          labelButtonPriority2: "Hapus",
                                          positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
                                          onTapPriority2: () => widget.onTapDelete(widget.files[i].fileID),
                                        );
                                      },
                                      child: SvgPicture.asset("assets/ic_close1,5.svg",
                                        width: GlobalVariable.ratioWidth(context) * 18,
                                        height: GlobalVariable.ratioWidth(context) * 18,
                                        color: Color(ListColor.colorLightGrey4),
                                      ),
                                    ),
                                  ),
                                if (widget.files.length == 1)
                                  _iconDownload(context),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          if (widget.isOpsional)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.files.length > 0)
                  SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 10,
                  ),
                Row(
                  children: [
                    _button(
                      context: context,
                      paddingLeft: 24,
                      paddingRight: 24,
                      height: 30,
                      backgroundColor: Color(ListColor.colorBlue),
                      customWidget: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: GlobalVariable.ratioWidth(context) * 6,
                            ),
                            child: SvgPicture.asset("assets/ic_upload_seller.svg",
                              width: GlobalVariable.ratioWidth(context) * 12,
                              height: GlobalVariable.ratioWidth(context) * 12,
                              color: Color(ListColor.colorWhite),
                            ),
                          ),
                          Container(
                            width: GlobalVariable.ratioWidth(context) * 53,
                            alignment: Alignment.center,
                            child: CustomText("Upload",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              textAlign: TextAlign.center,
                              color: Color(ListColor.colorWhite),
                            ),
                          ),
                        ],
                      ),
                      onTap: widget.onTapUpload,
                    ),
                  ],
                ),
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 8, // -2px untuk gap customtext
                ),
                CustomText("Format file jpg/png/pdf max. 5MB",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(ListColor.colorGrey3),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _iconDownload(BuildContext context) {
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
              child: CustomText("Password Dokumen Anda merupakan gabungan dari \"6 digit terakhir No. KTP ${ctrl.subject} dan Kode Referral",
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
                  'file': widget.files.map((e) => e.fileID).toList().toString(),
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

  Widget _errorUpload({
    String errorMessage,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: GlobalVariable.ratioWidth(Get.context) * 7,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: GlobalVariable.ratioWidth(Get.context) * 3,
              right: GlobalVariable.ratioWidth(Get.context) * 6,
            ),
            child: SvgPicture.asset(
              "assets/ic_error_upload_seller.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 16,
              height: GlobalVariable.ratioWidth(Get.context) * 16,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 16),
              child: CustomText(
                errorMessage,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorRed),
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button({
    @required BuildContext context,
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(context) * marginLeft,
          GlobalVariable.ratioWidth(context) * marginTop,
          GlobalVariable.ratioWidth(context) * marginRight,
          GlobalVariable.ratioWidth(context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(context).size.width
              : null
          : GlobalVariable.ratioWidth(context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(context) * paddingLeft,
                  GlobalVariable.ratioWidth(context) * paddingTop,
                  GlobalVariable.ratioWidth(context) * paddingRight,
                  GlobalVariable.ratioWidth(context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * borderRadius)),
              child: Center(
                child: customWidget == null
                    ? CustomText(
                        text ?? "",
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: color,
                      )
                    : customWidget,
              ),
            )),
      ),
    );
  }
}