import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/create_group_tambah_anggota/create_group_tambah_anggota_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class CreateGroupController extends GetxController {
  var namaController = TextEditingController();
  var deskripsiController = TextEditingController();
  var errorName = "".obs;
  var errorDescription = "".obs;
  var errorListMitra = "".obs;
  var loading = true.obs;

  var listMitra = <MitraModel>[].obs;
  var tempListMitra = <MitraModel>[].obs;

  var selectedMitra = <MitraModel>[].obs;
  var tempSelectedMitra = <MitraModel>[].obs;

  var selectedImage = File("").obs;

  @override
  void onInit() async {
    selectedImage.value = null;
    await getListMitra();
    loading.value = false;
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  Future<void> getListMitra() async {
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .fetchNonFilteredMitra(shipperID.toString());
    // var response =
    //     await ApiHelper(context: Get.context, isShowDialogLoading: false)
    //         .fetchNonFilteredMitra("42");
    List<dynamic> getListMitra = response["Data"];
    listMitra.clear();
    getListMitra.forEach((element) {
      listMitra.add(MitraModel.fromJson(element));
    });
  }

  void chooseImage() {
    showDialog(
        context: Get.context,
        builder: (context) {
          return AlertDialog(
            // content: Text("HI"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await getFromCamera();
                    },
                    padding: EdgeInsets.all(11),
                    child: CustomText("PartnerManagementPhoto".tr),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await getFromGallery();
                    },
                    padding: EdgeInsets.all(11),
                    child: CustomText("PartnerManagementGallery".tr),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        maxHeight: 900,
        imageQuality: 50);
    _cropImage(pickedFile.path);
  }

  void getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 1080,
        maxHeight: 720,
        imageQuality: 50);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void _cropImage(filePath) async {
    File croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage != null) {
      selectedImage.value = croppedImage;
    }
  }

  void showListMitra() async {
    var result = await GetToPage.toNamed<CreateGroupTambahAnggotaController>(
        Routes.CREATE_GROUP_MITRA_TAMBAH_ANGGOTA,
        arguments: [listMitra.value, selectedMitra.value]);
    if (result != null) {
      selectedMitra.clear();
      selectedMitra.addAll(result[0]);
    }
  }

  // void showListMitra() {
  //   tempSelectedMitra.clear();
  //   tempListMitra.clear();
  //   tempListMitra.addAll(listMitra.value);
  //   tempSelectedMitra.addAll(selectedMitra.value);
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
  //                   child: CustomText("PartnerManagementAddMember".tr,
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
  //                               hintText:
  //                                   "PartnerManagementLabelHintSearchMitra".tr,
  //                               focusedBorder: InputBorder.none,
  //                               enabledBorder: InputBorder.none,
  //                               errorBorder: InputBorder.none,
  //                               disabledBorder: InputBorder.none,
  //                               contentPadding:
  //                                   EdgeInsets.only(left: 40, right: 10)),
  //                           onChanged: (str) {
  //                             tempListMitra.clear();
  //                             tempListMitra.addAll(
  //                                 List<MitraModel>.from(listMitra.value).where(
  //                                     (element) => element.name
  //                                         .toString()
  //                                         .toLowerCase()
  //                                         .contains(str.toLowerCase())));
  //                             print(tempListMitra.toString());
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
  //                             List.generate(tempListMitra.length, (index) {
  //                           var mitra = tempListMitra[index];
  //                           return Container(
  //                             padding: EdgeInsets.symmetric(vertical: 8),
  //                             child: Theme(
  //                               data: Theme.of(Get.context).copyWith(
  //                                   unselectedWidgetColor:
  //                                       Color(ListColor.color4)),
  //                               child: Obx(
  //                                 () => CheckboxListTile(
  //                                   onChanged: (checked) {
  //                                     if (checked) {
  //                                       tempSelectedMitra.add(mitra);
  //                                     } else {
  //                                       tempSelectedMitra.remove(mitra);
  //                                     }
  //                                   },
  //                                   value: tempSelectedMitra.contains(mitra),
  //                                   title: InkWell(
  //                                     onLongPress: () {
  //                                       CustomToast.show(
  //                                         context: Get.context,
  //                                         message: mitra.name,
  //                                       );
  //                                     },
  //                                     child: CustomText(mitra.name,
  //                                         maxLines: 1,
  //                                         overflow: TextOverflow.ellipsis),
  //                                   ),
  //                                   secondary: CircleAvatar(
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
  //                             Navigator.of(Get.context).pop();
  //                             selectedMitra.clear();
  //                             selectedMitra.addAll(tempSelectedMitra);
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

  void checkCreateGroup() {
    errorName.value = namaController.text.isEmpty ? "Name cannot be empty" : "";
    errorDescription.value =
        deskripsiController.text.isEmpty ? "Description cannot be empty" : "";
    errorListMitra.value =
        listMitra.length == 0 ? "List of partner cannot be empty" : "";
    if (errorName.value.isEmpty &&
        errorDescription.value.isEmpty &&
        errorListMitra.value.isEmpty) {
      createGroupMitra();
    }
  }

  void createGroupMitra() async {
    loading.value = true;
    var daftarMitra = "";
    selectedMitra.forEach((element) {
      if (selectedMitra.first != element) {
        daftarMitra += ",";
      }
      daftarMitra += element.docID;
    });
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .createGroupMitra(namaController.text, deskripsiController.text,
                shipperID, daftarMitra, selectedImage.value);
    var message = MessageFromUrlModel.fromJson(response['Message']);
    loading.value = false;
    if (message.code == 200) {
      Get.back(result: "create");
    } else {
      GlobalAlertDialog.showDialogError(
          message: response["Data"]["Message"], context: Get.context);
    }
  }

  // OCTA
  var searchBar = TextEditingController();
  var search = "";
  var isShowClearSearch = false.obs;

  void searchOnChange(String value) {
    search = value;
    isShowClearSearch.value = search.isNotEmpty;

    if (search != "") {
      _searchMitra();
    } else {
      _showAllMitra();
    }
  }

  void onClearSearch() {
    searchBar.text = "";
    searchOnChange("");
  }

  void _searchMitra() {
    selectedMitra.clear();
    for (int i = 0; i < tempSelectedMitra.length; i++) {
      if (tempSelectedMitra[i]
          .name
          .toString()
          .toLowerCase()
          .contains(search.toLowerCase())) {
        selectedMitra.add(tempSelectedMitra[i]);
      }
    }
  }

  void _showAllMitra() {
    selectedMitra.clear();
    selectedMitra.addAll(tempSelectedMitra);
  }
}
