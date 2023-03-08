import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/group_mitra_model.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/detail_tambah_anggota/detail_manajemen_group_tambah_anggota_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import 'package:muatmuat/global_variable.dart';

class DetailManajemenGroupMitraController extends GetxController {
  var listAllMitra = <MitraModel>[].obs;
  var tempListAllMitra = <MitraModel>[].obs;
  var selectedMitra = <MitraModel>[].obs;
  final textEditingController = TextEditingController();
  var loading = true.obs;

  final scaffoldKey = GlobalKey<ScaffoldState>().obs;

  final count = 0.obs;
  var listMitra = <MitraModel>[].obs;
  var tempListMitra = <MitraModel>[].obs;
  var group = GroupMitraModel().obs;
  var groupID = "";
  var change = false;
  var groupStatus = true.obs;

  @override
  void onInit() async {
    // listMitra.value = null;
    groupID = Get.arguments[0].toString();
    // group.value = Get.arguments[1];
    // groupStatus.value = group.value.status;
    // if (group != null) {
    //   print("ID: ${group.value.id}");
    //   print("Name: ${group.value.name}");
    //   print("Description: ${group.value.description}");
    // }
    await getListMitraOnGroup();
    updateFilter();
    loading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getListMitraOnGroup() async {
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .fetchListPartnerInGroup(groupID);

    groupStatus.value = response["SupportingData"]["StatusInt"] == 1;
    group.value.id = response["SupportingData"]["GroupID"].toString();
    group.value.name = response["SupportingData"]["GroupMitraName"];
    group.value.description = response["SupportingData"]["Description"];
    group.value.status = response["SupportingData"]["StatusInt"] == 1;
    group.value.totalPartner =
        response["SupportingData"]["RealCountData"].toString();
    group.value.avatar = response["SupportingData"]["AvatarGroup"];
    group.value.isDelete = response["SupportingData"]["IsDelete"] == 1;
    List<dynamic> getListMitra = response["Data"];
    if (listMitra.value != null) {
      listMitra.clear();
    } else {
      listMitra.value = [];
    }
    getListMitra.forEach((element) {
      listMitra.add(MitraModel.fromJson(element));
    });
  }

  Future<void> getListAllMitra() async {
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: true)
            .fetchNonFilteredMitra(shipperID.toString());
    // var response =
    //     await ApiHelper(context: Get.context, isShowDialogLoading: false)
    //         .fetchNonFilteredMitra("42");
    List<dynamic> getListMitra = response["Data"];
    List<MitraModel> filteredMitra = [];
    getListMitra.forEach((element) {
      filteredMitra.add(MitraModel.fromJson(element));
    });
    filteredMitra.removeWhere((element) =>
        listMitra.value.any((alreadyMitra) => alreadyMitra.id == element.id));
    filteredMitra.forEach((element) {
      print(element.name);
    });
    // listAllMitra.value =  filteredMitra;
    listAllMitra.value.clear();
    listAllMitra.value.addAll(filteredMitra);
    // listAllMitra.value.forEach((element) {
    //   print("all mitra ${element.name}");
    // });
    // tempListAllMitra.value = List.from(listAllMitra.value);
    // listAllMitra.value.forEach((element) {
    //   print("temp all mitra ${element.name}");
    // });
  }
  // Future<void> getListAllMitra() async {
  //   var shipperID = await SharedPreferencesHelper.getUserShipperID();
  //   var response =
  //       await ApiHelper(context: Get.context, isShowDialogLoading: true)
  //           .fetchNonFilteredMitra(shipperID.toString());
  //   // var response =
  //   //     await ApiHelper(context: Get.context, isShowDialogLoading: false)
  //   //         .fetchNonFilteredMitra("42");
  //   List<dynamic> getListMitra = response["Data"];
  //   var filteredMitra = [];
  //   getListMitra.forEach((element) {
  //     filteredMitra.add(MitraModel.fromJson(element));
  //   });
  //   filteredMitra.removeWhere((element) =>
  //       listMitra.value.any((alreadyMitra) => alreadyMitra.id == element.id));
  //   filteredMitra.forEach((element) {
  //     print(element.name);
  //   });
  //   listAllMitra.value =  filteredMitra;
  //   listAllMitra.value.forEach((element) {
  //     print("all mitra ${element.name}");
  //   });
  //   tempListAllMitra.value = List.from(listAllMitra.value);
  //   listAllMitra.value.forEach((element) {
  //     print("temp all mitra ${element.name}");
  //   });
  // }

  void hapusMitra(MitraModel mitra) {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "PartnerManagementLabelTitleRemovePartner".tr,
      message: "PartnerManagementRemoveQuestion".tr,
      context: Get.context,
      labelButtonPriority1: "PartnerManagementLabelCancel".tr,
      onTapPriority2: () async {
        var shipperID = await SharedPreferencesHelper.getUserShipperID();
        loading.value = true;
        var response =
            await ApiHelper(context: Get.context, isShowDialogLoading: false)
                .removeMitraFromGroup(mitra.docID);
        var message = MessageFromUrlModel.fromJson(response['Message']);
        if (message.code == 200) {
          await getListMitraOnGroup();
          updateFilter();
          change = true;
          loading.value = false;
          CustomToast.show(
              context: Get.context,
              message: "PartnerManagementHasBeenRemoved".tr);
        } else {
          loading.value = false;
          CustomToast.show(
              context: Get.context, message: response["Data"]["Message"]);
        }
      },
      labelButtonPriority2: "PartnerManagementLabelRemove".tr,
    );
  }

  // void showMitraOption(MitraModel mitra) {
  //   showModalBottomSheet(
  //       context: Get.context,
  //       backgroundColor: Colors.transparent,
  //       enableDrag: true,
  //       builder: (context) {
  //         return Container(
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(13),
  //                   topRight: Radius.circular(13))),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.all(20),
  //                 child: Stack(
  //                   alignment: Alignment.center,
  //                   children: [
  //                     Align(
  //                       alignment: Alignment.centerLeft,
  //                       child: IconButton(
  //                         icon: Icon(Icons.close),
  //                         onPressed: () {
  //                           Navigator.of(context).pop();
  //                         },
  //                       ),
  //                     ),
  //                     Text("Options",
  //                         style: TextStyle(
  //                             fontSize: 22,
  //                             fontWeight: FontWeight.bold,
  //                             color: Color(ListColor.colorBlue)))
  //                   ],
  //                 ),
  //               ),
  //               mitraOptionView("Remove from group", () async {
  //                 var name = mitra.name;
  //                 GlobalAlertDialog.showDialogError(.showAlertDialogConfirmButton(
  //                     "Do you want remove $name from group?",
  //                     "Remove",
  //                     "Cancel", () async {
  //                   Navigator.of(context).pop();
  //                   var shipperID =
  //                       await SharedPreferencesHelper.getUserShipperID();
  //                   loading.value = true;
  //                   var response = await ApiHelper(
  //                           context: Get.context, isShowDialogLoading: false)
  //                       .removeMitraFromGroup(mitra.docID);
  //                   var message =
  //                       MessageFromUrlModel.fromJson(response['Message']);
  //                   if (message.code == 200) {
  //                     await getListMitraOnGroup();
  //                     updateFilter();
  //                     change = true;
  //                     loading.value = false;
  //                     CustomToast.show(
  //                         context: Get.context,
  //                         message: "$name has been removed.",
  //                         buttonText: "Close",
  //                         onTap: null);
  //                   } else {
  //                     loading.value = false;
  //                     CustomToast.show(
  //                         context: Get.context,
  //                         message: response["Data"]["Message"],
  //                         buttonText: "Close",
  //                         onTap: null);
  //                   }
  //                 });
  //               }),
  //               Container(height: 20),
  //             ],
  //           ),
  //         );
  //       });
  // }

  Widget mitraOptionView(String text, Function onTap) {
    return Container(
      child: MaterialButton(
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          color: Colors.white,
          onPressed: onTap,
          child: Container(
            width: Get.context.mediaQuery.size.width,
            child: CustomText(text,
                textAlign: TextAlign.start,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          )),
    );
  }

  void showListMitra() async {
    await getListAllMitra();
    if (listAllMitra.value.length == 0) {
      GlobalAlertDialog.showDialogError(
          message: "Tidak ada anggota untuk ditambahkan", context: Get.context);
      return;
    }
    var result =
        await GetToPage.toNamed<DetailManajemenGroupTambahAnggotaController>(
            Routes.DETAIL_MANAJEMEN_GROUP_TAMBAH_ANGGOTA,
            arguments: [listAllMitra.value, groupID]);
    if (result != null) {
      if (result) {
        loading.value = true;
        change = true;
        await getListMitraOnGroup();
        updateFilter();
        loading.value = false;
      }
      // selectedMitra.clear();
      // selectedMitra.addAll(result[0]);
    }
  }

  // void showListMitra() async {
  //   loading.value = true;
  //   await getListAllMitra();
  //   selectedMitra.clear();
  //   loading.value = false;
  //   showDialog(
  //       context: Get.context,
  //       builder: (context) {
  //         return Dialog(
  //           insetPadding: EdgeInsets.zero,
  //           backgroundColor: Colors.transparent,
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.all(Radius.circular(13))),
  //             width: Get.context.mediaQuery.size.width,
  //             height: Get.context.mediaQuery.size.height,
  //             margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
  //             padding: EdgeInsets.symmetric(horizontal: 13),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.max,
  //               children: [
  //                 Container(
  //                   margin: EdgeInsets.only(top: 15),
  //                   child: CustomText("PartnerManagementLabelAddMember".tr,
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.blue),
  //                 ),
  //                 Container(
  //                     height: 1,
  //                     color: Colors.grey[300],
  //                     margin: EdgeInsets.symmetric(vertical: 15)),
  //                 Container(
  //                     margin: EdgeInsets.only(bottom: 10),
  //                     padding: EdgeInsets.symmetric(horizontal: 13),
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.all(Radius.circular(13)),
  //                         border: Border.all(color: Colors.grey[300])),
  //                     child: Stack(
  //                       alignment: Alignment.centerLeft,
  //                       children: [
  //                         CustomTextField(
  //                           context: Get.context,
  //                           textAlign: TextAlign.left,
  //                           newInputDecoration: InputDecoration(
  //                               hintText: "Search",
  //                               focusedBorder: InputBorder.none,
  //                               enabledBorder: InputBorder.none,
  //                               errorBorder: InputBorder.none,
  //                               disabledBorder: InputBorder.none,
  //                               contentPadding:
  //                                   EdgeInsets.only(left: 40, right: 10)),
  //                           onChanged: (str) {
  //                             tempListAllMitra.value =
  //                                 List<MitraModel>.from(listAllMitra.value)
  //                                     .where((element) => element.name
  //                                         .toString()
  //                                         .toLowerCase()
  //                                         .contains(str.toLowerCase()))
  //                                     .toList();
  //                           },
  //                         ),
  //                         Icon(Icons.search, color: Colors.grey)
  //                       ],
  //                     )),
  //                 Expanded(
  //                     child: SingleChildScrollView(
  //                   child: Obx(
  //                     () => Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children:
  //                             List.generate(tempListAllMitra.length, (index) {
  //                           var mitra = tempListAllMitra[index];
  //                           return Container(
  //                             padding: EdgeInsets.symmetric(vertical: 8),
  //                             child: Theme(
  //                               data: Theme.of(Get.context).copyWith(
  //                                   unselectedWidgetColor:
  //                                       Color(ListColor.color4)),
  //                               child: Obx(
  //                                 () => CheckboxListTile(
  //                                   activeColor: Color(ListColor.color4),
  //                                   shape: RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.circular(2)),
  //                                   onChanged: (checked) {
  //                                     if (checked) {
  //                                       selectedMitra.add(mitra);
  //                                     } else {
  //                                       selectedMitra.remove(mitra);
  //                                     }
  //                                   },
  //                                   value: selectedMitra.contains(mitra),
  //                                   title: CustomText(mitra.name),
  //                                   secondary:
  //                                       // ClipRRect(
  //                                       //     borderRadius:
  //                                       //         BorderRadius.all(Radius.circular(25)),
  //                                       //     child: Image.asset(
  //                                       //         "assets/gambar_example.jpeg",
  //                                       //         fit: BoxFit.cover,
  //                                       //         width: 50,
  //                                       //         height: 50)),
  //                                       CircleAvatar(
  //                                     radius: 25.0,
  //                                     backgroundImage: NetworkImage(
  //                                         GlobalVariable.urlImage +
  //                                             mitra.avatar),
  //                                     backgroundColor: Colors.transparent,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           );
  //                         })),
  //                   ),
  //                 )),
  //                 Container(
  //                   margin: EdgeInsets.only(top: 10, bottom: 15),
  //                   padding: EdgeInsets.symmetric(horizontal: 20),
  //                   child: Row(
  //                     mainAxisSize: MainAxisSize.max,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Expanded(
  //                         child: MaterialButton(
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius:
  //                                   BorderRadius.all(Radius.circular(20)),
  //                               side: BorderSide(width: 1, color: Colors.blue)),
  //                           onPressed: () {
  //                             Navigator.of(Get.context).pop();
  //                           },
  //                           child: CustomText("PartnerManagementLabelCancel".tr,
  //                               color: Colors.blue),
  //                         ),
  //                       ),
  //                       Container(width: 13),
  //                       Expanded(
  //                         child: MaterialButton(
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius:
  //                                   BorderRadius.all(Radius.circular(20))),
  //                           color: Colors.blue,
  //                           onPressed: () {
  //                             GlobalAlertDialog.showAlertDialogCustom(
  //                               title: "PartnerManagementLabelAddMember".tr,
  //                               message:
  //                                   "PartnerManagementAddMemberQuestion".tr,
  //                               context: Get.context,
  //                               labelButtonPriority1:
  //                                   "PartnerManagementLabelAdd".tr,
  //                               onTapPriority1: () {
  //                                 addMitraIntoGroup();
  //                               },
  //                               labelButtonPriority2:
  //                                   "PartnerManagementLabelCancel".tr,
  //                             );
  //                           },
  //                           child: CustomText("PartnerManagementLabelSubmit".tr,
  //                               color: Colors.white),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  void addMitraIntoGroup() async {
    var error = "";
    loading.value = true;
    for (var mitra in selectedMitra.value) {
      var response =
          await ApiHelper(context: Get.context, isShowDialogLoading: false)
              .addMitraIntoGroup(groupID, mitra.docID);
      var message = MessageFromUrlModel.fromJson(response['Message']);
      if (message.code != 200) {
        if (error.isNotEmpty) {
          error += "\n";
        }
        error += "Error input ${mitra.name}: ${response["Data"]["Message"]}";
      }
    }
    if (error.isEmpty) {
      await getListMitraOnGroup();
      updateFilter();
      change = true;
      loading.value = false;
      CustomToast.show(context: Get.context, message: "Mitra has been added");
    } else {
      loading.value = false;
      GlobalAlertDialog.showDialogError(message: error, context: Get.context);
    }
  }

  void updateFilter() {
    var filteredMitra = List<MitraModel>.from(listMitra.value).where(
        (element) => element.name
            .toLowerCase()
            .contains(textEditingController.text.toLowerCase()));
    tempListMitra.value = filteredMitra.toList();
  }

  void checkEnableGroupToggle(bool toggle) {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: toggle
            ? "PartnerManagementLabelTitleEnableGroup".tr
            : "PartnerManagementLabelTitleDisableGroup".tr,
        message: toggle
            ? "PartnerManagementEnableQuestion".tr
            : "PartnerManagementDisableQuestion".tr,
        labelButtonPriority1: "PartnerManagementLabelCancel".tr,
        labelButtonPriority2: toggle
            ? "PartnerManagementLabelActivate".tr
            : "PartnerManagementLabelDeactivate".tr,
        onTapPriority2: () async {
          var response =
              await ApiHelper(context: Get.context, isShowDialogLoading: true)
                  .fetchSetGroupMitraStatus(group.value.id, toggle ? "1" : "0");
          var message = MessageFromUrlModel.fromJson(response['Message']);
          if (message.code == 200) {
            CustomToast.show(
                context: Get.context,
                message: toggle
                    ? "PartnerManagemenHasBeenActivate".tr
                    : "PartnerManagementHasBeenDeactivate".tr);
            change = true;
          } else {
            GlobalAlertDialog.showDialogError(
                message: response["Data"]["Message"], context: Get.context);
          }
        });
  }

  void removeGroup() async {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "Hapus Mitra".tr,
        message: "PartnerManagementRemoveGroupQuestion".tr,
        labelButtonPriority1: "PartnerManagementLabelCancel".tr,
        labelButtonPriority2: "PartnerManagementLabelRemove".tr,
        onTapPriority2: () async {
          loading.value = true;
          var response =
              await ApiHelper(context: Get.context, isShowDialogLoading: true)
                  .fetchDeleteGroupMitra(groupID);
          var message = MessageFromUrlModel.fromJson(response['Message']);
          if (message.code == 200) {
            CustomToast.show(
                context: Get.context,
                message: "PartnerManagementGroupHasBeenRemoved".tr);
            change = true;
            loading.value = false;
            Get.back();
          } else {
            GlobalAlertDialog.showDialogError(
                message: response["Data"]["Message"], context: Get.context);
          }
        });
  }

  void onWillPop() {
    Get.back(result: change);
  }
}
