import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/list_user/list_user_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ListUserView extends GetView<ListUserController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 16),
                      child: ClipOval(
                        child: Material(
                            shape: CircleBorder(),
                            color: Color(ListColor.color4),
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    child: Center(
                                        child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                      color: Colors.white,
                                    ))))),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText("Diumumkan Kepada",
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          body: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Obx(() => ListView(
                          children: [
                            controller.selectedJenisMitra.length == 0
                                ? SizedBox.shrink()
                                : Obx(
                                    () => Column(
                                      children: [
                                        Container(
                                            // margin: EdgeInsets.all(
                                            //     GlobalVariable.ratioWidth(Get.context) *
                                            //         16),
                                            child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  dividerColor:
                                                      Colors.transparent,
                                                ),
                                                child: ListTileTheme(
                                                  minVerticalPadding: 0,
                                                  child: ExpansionTile(
                                                      initiallyExpanded: true,
                                                      title: CustomText(
                                                          "Semua Group/Transporter",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color(ListColor
                                                              .colorLightGrey4)),
                                                      trailing: Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color: Colors.black),
                                                      onExpansionChanged:
                                                          (value) {
                                                        controller
                                                            .isExpandJenisMitra
                                                            .value = value;
                                                      },
                                                      children: [
                                                        ConstrainedBox(
                                                            constraints: BoxConstraints(
                                                                minHeight: 0,
                                                                maxHeight: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    226),
                                                            child: Scrollbar(
                                                              isAlwaysShown:
                                                                  true,
                                                              child:
                                                                  SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                      margin: EdgeInsets.symmetric(
                                                                          horizontal: GlobalVariable.ratioWidth(Get.context) *
                                                                              16),
                                                                      child:
                                                                          _lineSaparator()),
                                                                  for (var index =
                                                                          0;
                                                                      index <
                                                                          controller
                                                                              .selectedJenisMitra
                                                                              .length;
                                                                      index++)
                                                                    childView(
                                                                        controller
                                                                            .selectedJenisMitra
                                                                            .values
                                                                            .toList()[index],
                                                                        () {
                                                                      controller.selectedJenisMitra.removeWhere((key,
                                                                              value) =>
                                                                          value ==
                                                                          controller
                                                                              .selectedJenisMitra
                                                                              .values
                                                                              .toList()[index]);
                                                                    })
                                                                ],
                                                              )),
                                                            ))
                                                      ]),
                                                ))),
                                        controller.isExpandJenisMitra.value
                                            ? SizedBox.shrink()
                                            : Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16),
                                                child: _lineSaparator())
                                      ],
                                    ),
                                  ),
                            controller.selectedGroup.length == 0
                                ? SizedBox.shrink()
                                : Obx(
                                    () => Column(
                                      children: [
                                        Container(
                                            // margin: EdgeInsets.all(
                                            //     GlobalVariable.ratioWidth(Get.context) *
                                            //         16),
                                            child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  dividerColor:
                                                      Colors.transparent,
                                                ),
                                                child: ListTileTheme(
                                                  minVerticalPadding: 0,
                                                  child: ExpansionTile(
                                                      initiallyExpanded: true,
                                                      title: CustomText("Group",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color(ListColor
                                                              .colorLightGrey4)),
                                                      trailing: Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color: Colors.black),
                                                      onExpansionChanged:
                                                          (value) {
                                                        controller.isExpandGroup
                                                            .value = value;
                                                      },
                                                      children: [
                                                        ConstrainedBox(
                                                            constraints: BoxConstraints(
                                                                minHeight: 0,
                                                                maxHeight: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    226),
                                                            child: Scrollbar(
                                                              isAlwaysShown:
                                                                  true,
                                                              child:
                                                                  SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                      margin: EdgeInsets.symmetric(
                                                                          horizontal: GlobalVariable.ratioWidth(Get.context) *
                                                                              16),
                                                                      child:
                                                                          _lineSaparator()),
                                                                  for (var index =
                                                                          0;
                                                                      index <
                                                                          controller
                                                                              .selectedGroup
                                                                              .length;
                                                                      index++)
                                                                    childView(
                                                                        controller.selectedGroup[index]
                                                                            [
                                                                            "name"],
                                                                        () {
                                                                      controller
                                                                          .selectedGroup
                                                                          .removeAt(
                                                                              index);
                                                                    })
                                                                ],
                                                              )),
                                                            ))
                                                      ]),
                                                ))),
                                        controller.isExpandGroup.value
                                            ? SizedBox.shrink()
                                            : Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16),
                                                child: _lineSaparator())
                                      ],
                                    ),
                                  ),
                            controller.selectedTransporter.length == 0
                                ? SizedBox.shrink()
                                : Obx(
                                    () => Column(
                                      children: [
                                        Container(
                                            // margin: EdgeInsets.all(
                                            //     GlobalVariable.ratioWidth(Get.context) *
                                            //         16),
                                            child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  dividerColor:
                                                      Colors.transparent,
                                                ),
                                                child: ListTileTheme(
                                                  minVerticalPadding: 0,
                                                  child: ExpansionTile(
                                                      initiallyExpanded: true,
                                                      title: CustomText(
                                                          "Transporter",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color(ListColor
                                                              .colorLightGrey4)),
                                                      trailing: Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color: Colors.black),
                                                      onExpansionChanged:
                                                          (value) {
                                                        controller
                                                            .isExpandTransporter
                                                            .value = value;
                                                      },
                                                      children: [
                                                        ConstrainedBox(
                                                            constraints: BoxConstraints(
                                                                minHeight: 0,
                                                                maxHeight: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    226),
                                                            child: Scrollbar(
                                                              isAlwaysShown:
                                                                  true,
                                                              child:
                                                                  SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                      margin: EdgeInsets.symmetric(
                                                                          horizontal: GlobalVariable.ratioWidth(Get.context) *
                                                                              16),
                                                                      child:
                                                                          _lineSaparator()),
                                                                  for (var index =
                                                                          0;
                                                                      index <
                                                                          controller
                                                                              .selectedTransporter
                                                                              .length;
                                                                      index++)
                                                                    childView(
                                                                        controller.selectedTransporter[index]
                                                                            [
                                                                            "name"],
                                                                        () {
                                                                      controller
                                                                          .selectedTransporter
                                                                          .removeAt(
                                                                              index);
                                                                    })
                                                                ],
                                                              )),
                                                            ))
                                                      ]),
                                                ))),
                                        controller.isExpandTransporter.value
                                            ? SizedBox.shrink()
                                            : Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16),
                                                child: _lineSaparator())
                                      ],
                                    ),
                                  ),
                            controller.selectedInvited.length == 0
                                ? SizedBox.shrink()
                                : Obx(
                                    () => Column(
                                      children: [
                                        Container(
                                            child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  dividerColor:
                                                      Colors.transparent,
                                                ),
                                                child: ListTileTheme(
                                                  minVerticalPadding: 0,
                                                  child: ExpansionTile(
                                                      initiallyExpanded: true,
                                                      title: CustomText(
                                                          "Invited Transporter",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color(ListColor
                                                              .colorLightGrey4)),
                                                      trailing: Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color: Colors.black),
                                                      onExpansionChanged:
                                                          (value) {
                                                        controller
                                                            .isExpandInvited
                                                            .value = value;
                                                      },
                                                      children: [
                                                        ConstrainedBox(
                                                            constraints: BoxConstraints(
                                                                minHeight: 0,
                                                                maxHeight: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    226),
                                                            child: Scrollbar(
                                                              isAlwaysShown:
                                                                  true,
                                                              child:
                                                                  SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                      margin: EdgeInsets.symmetric(
                                                                          horizontal: GlobalVariable.ratioWidth(Get.context) *
                                                                              16),
                                                                      child:
                                                                          _lineSaparator()),
                                                                  for (var index =
                                                                          0;
                                                                      index <
                                                                          controller
                                                                              .selectedJenisMitra
                                                                              .length;
                                                                      index++)
                                                                    childView(
                                                                        controller
                                                                            .selectedInvited
                                                                            .values
                                                                            .toList()[index],
                                                                        () {
                                                                      controller.selectedInvited.removeWhere((key,
                                                                              value) =>
                                                                          value ==
                                                                          controller
                                                                              .selectedInvited
                                                                              .values
                                                                              .toList()[index]);
                                                                    },
                                                                        withImage:
                                                                            false)
                                                                ],
                                                              )),
                                                            ))
                                                      ]),
                                                ))),
                                        controller.isExpandInvited.value
                                            ? SizedBox.shrink()
                                            : Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16),
                                                child: _lineSaparator())
                                      ],
                                    ),
                                  ),
                          ],
                        ))),
                !controller.delete.value
                    ? SizedBox.shrink()
                    : Container(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: MaterialButton(
                                onPressed: () {
                                  GlobalAlertDialog.showAlertDialogCustom(
                                      context: Get.context,
                                      title: "Reset",
                                      message:
                                          "Apakah anda yakin untuk menghapus semua?",
                                      labelButtonPriority1: "Cancel",
                                      labelButtonPriority2: "Hapus",
                                      onTapPriority2: () async {
                                        controller.selectedJenisMitra.clear();
                                        controller.selectedGroup.clear();
                                        controller.selectedTransporter.clear();
                                      });
                                },
                                color: Color(ListColor.color4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: Color(ListColor.color4),
                                        width: 2)),
                                child: CustomText(
                                  "Reset",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(width: 12),
                            Expanded(
                              child: MaterialButton(
                                onPressed: () {
                                  Get.back(result: {
                                    "semua": controller.selectedJenisMitra,
                                    "group": controller.selectedGroup,
                                    "transporter":
                                        controller.selectedTransporter,
                                    "invited": controller.selectedInvited
                                  });
                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: Color(ListColor.color4),
                                        width: 2)),
                                child: CustomText(
                                  "Terapkan",
                                  color: Color(ListColor.color4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          )),
    );
  }

  Widget childView(String text, Function onDelete,
      {String imageURL = "", bool withImage = true}) {
    var initial = _getInitials(text);
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 6,
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        child: Obx(
          () => Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !withImage
                  ? SizedBox.shrink()
                  : Container(
                      margin: EdgeInsets.only(
                          right: GlobalVariable.ratioWidth(Get.context) * 12),
                      child: _circleAvatar(imageURL, initial)),
              Expanded(
                  child: CustomText(text,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(ListColor.colorLightGrey4))),
              !controller.delete.value
                  ? SizedBox.shrink()
                  : GestureDetector(
                      onTap: () {
                        GlobalAlertDialog.showAlertDialogCustom(
                            context: Get.context,
                            title: "Hapus",
                            message: "Apakah anda yakin untuk menghapus $text?",
                            labelButtonPriority1: "Cancel",
                            labelButtonPriority2: "Hapus",
                            onTapPriority2: () async {
                              onDelete();
                            });
                      },
                      child: Icon(Icons.close),
                    )
            ],
          ),
        ));
  }

  String _getInitials(String value) {
    List<String> listWords = value.split(" ");
    String initials = "";
    final int maxInitials = 3;
    int countInitials =
        listWords.length > maxInitials ? maxInitials : listWords.length;
    for (int i = 0; i < countInitials; i++) {
      if (listWords[i].isNotEmpty) initials += '${listWords[i][0]}';
    }
    return initials.toUpperCase();
  }

  Widget _circleAvatar(String urlImage, String initials) {
    return Material(
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: Container(
          width: GlobalVariable.ratioWidth(Get.context) * 32,
          height: GlobalVariable.ratioWidth(Get.context) * 32,
          child: urlImage == ""
              ? _defaultAvatar(initials)
              : CachedNetworkImage(
                  errorWidget: (context, value, err) =>
                      _defaultAvatar(initials),
                  imageUrl: GlobalVariable.urlImage + urlImage,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                ),
        ));
  }

  Widget _defaultAvatar(String initials) {
    return Container(
        width: GlobalVariable.ratioWidth(Get.context) * 32,
        height: GlobalVariable.ratioWidth(Get.context) * 32,
        decoration: BoxDecoration(
            color: Color(ListColor.color4),
            borderRadius: BorderRadius.all(Radius.circular(35))),
        child: Center(
          child: CustomText(initials,
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
        ));
  }

  Widget _lineSaparator() {
    return Container(
        height: GlobalVariable.ratioHeight(Get.context) * 0.5,
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey10));
  }
}
