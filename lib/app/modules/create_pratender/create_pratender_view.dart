import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/create_pratender/create_pratender_controller.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:path/path.dart' as path;

class CreatePratenderView extends GetView<CreatePratenderController> {
  var dateFormat = DateFormat('dd MMMM yyyy');
  var dateTimeFormat = DateFormat('dd MMMM yyyy / HH:mm');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Create Pratender"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 11),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: CustomText('PratenderCreateLabelKode'.tr,
                        color: Colors.black, fontSize: 18)),
                Container(
                    margin: EdgeInsets.only(bottom: 10, left: 15),
                    child: CustomText("TD-012",
                        color: Colors.black, fontSize: 16)),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'PratenderCreateLabelNama'.tr,
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: controller.namaController,
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: CustomText('PratenderCreateLabelTanggalBuat'.tr,
                        color: Colors.black, fontSize: 18)),
                Container(
                    margin: EdgeInsets.only(bottom: 10, left: 15),
                    child: CustomText(dateTimeFormat.format(DateTime.now()),
                        color: Colors.black, fontSize: 16)),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: CustomText(
                        'PratenderCreateLabelPeriodePengunguman'.tr,
                        color: Colors.black,
                        fontSize: 18)),
                Container(
                    margin: EdgeInsets.only(bottom: 10, left: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                side: BorderSide(color: Colors.blue, width: 2)),
                            onPressed: () async {
                              var selectedDate = await datePicker();
                              if (selectedDate != null) {
                                controller.periodeStartDate.value =
                                    selectedDate;
                              }
                            },
                            child: Obx(() => CustomText(
                                (controller.periodeStartDate.value == null)
                                    ? 'Start Date'
                                    : dateFormat.format(
                                        controller.periodeStartDate.value),
                                color: Colors.blue)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CustomText('-', fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                side: BorderSide(color: Colors.blue, width: 2)),
                            onPressed: () async {
                              var selectedDate = await datePicker();
                              if (selectedDate != null) {
                                controller.periodeEndDate.value = selectedDate;
                              }
                            },
                            child: Obx(() => CustomText(
                                (controller.periodeEndDate.value == null)
                                    ? 'End Date'
                                    : dateFormat.format(
                                        controller.periodeEndDate.value),
                                color: Colors.blue)),
                          ),
                        )
                      ],
                    )),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'PratenderCreateLabelJenisPickup'.tr,
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: controller.tipePickupController,
                ),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'PratenderCreateLabelJenisDestinasi'.tr,
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: controller.tipePickupController,
                ),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'PratenderCreateLabelLokasiPickup'.tr,
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: controller.lokasiPickupController,
                ),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'PratenderCreateLabelLokasiDestinasi'.tr,
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: controller.lokasiDestinasiController,
                ),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'PratenderCreateLabelJenisTruk'.tr,
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: controller.jenisTrukController,
                ),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'PratenderCreateLabelJenisCarrier'.tr,
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: controller.jenisKurirController,
                ),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'PratenderCreateLabelJumlahTruk'.tr,
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: controller.jumlahTrukController,
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: CustomText('PratenderCreateLabelTanggalPekerjaan'.tr,
                        color: Colors.black, fontSize: 18)),
                Container(
                    margin: EdgeInsets.only(bottom: 10, left: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                side: BorderSide(color: Colors.blue, width: 2)),
                            onPressed: () async {
                              var selectedDate = await datePicker();
                              if (selectedDate != null) {
                                controller.pekerjaanStartDate.value =
                                    selectedDate;
                              }
                            },
                            child: Obx(() => CustomText(
                                (controller.pekerjaanStartDate.value == null)
                                    ? 'Start Date'
                                    : dateFormat.format(
                                        controller.pekerjaanStartDate.value),
                                color: Colors.blue)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CustomText('-', fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                side: BorderSide(color: Colors.blue, width: 2)),
                            onPressed: () async {
                              var selectedDate = await datePicker();
                              if (selectedDate != null) {
                                controller.pekerjaanEndDate.value =
                                    selectedDate;
                              }
                            },
                            child: Obx(() => CustomText(
                                (controller.pekerjaanEndDate.value == null)
                                    ? 'End Date'
                                    : dateFormat.format(
                                        controller.pekerjaanEndDate.value),
                                color: Colors.blue)),
                          ),
                        )
                      ],
                    )),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'PratenderCreateLabelDeskripsi'.tr,
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: controller.deskripsiController,
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: CustomText('PratenderCreateLabelDokumen'.tr,
                        color: Colors.black, fontSize: 18)),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    child: MaterialButton(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            side: BorderSide(color: Colors.blue, width: 2)),
                        onPressed: () async {
                          await controller.chooseFile();
                        },
                        child: Obx(() => CustomText(
                            (controller.uploadFile.value == null)
                                ? "Choose a file"
                                : path
                                    .basename(controller.uploadFile.value.path),
                            color: Colors.blue)))),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'PratenderCreateLabelPeserta'.tr,
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: controller.pesertaController,
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: CustomText('PratenderCreateLabelStatus'.tr,
                        color: Colors.black, fontSize: 18)),
                Container(
                    margin: EdgeInsets.only(bottom: 10, left: 10),
                    width: double.infinity,
                    child: Obx(
                      () => Column(
                        children: [
                          ListTile(
                            title: CustomText("Active"),
                            leading: Radio(
                              value: "Active",
                              groupValue: controller.status.value,
                              onChanged: (value) {
                                controller.status.value = value;
                              },
                            ),
                          ),
                          ListTile(
                            title: CustomText("Cancelled"),
                            leading: Radio(
                              value: "Cancelled",
                              groupValue: controller.status.value,
                              onChanged: (value) {
                                controller.status.value = value;
                              },
                            ),
                          ),
                          ListTile(
                            title: CustomText("Finished"),
                            leading: Radio(
                              value: "Finished",
                              groupValue: controller.status.value,
                              onChanged: (value) {
                                controller.status.value = value;
                              },
                            ),
                          )
                        ],
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    child: MaterialButton(
                        color: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            side: BorderSide(color: Colors.blue, width: 2)),
                        onPressed: () {},
                        child: CustomText('PratenderCreateLabelSubmit'.tr,
                            color: Colors.white))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime> datePicker() async {
    var selectedDate = await showDatePicker(
        context: Get.context,
        firstDate: DateTime.now(),
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter date in valid range',
        lastDate: DateTime(DateTime.now().year + 1),
        initialDate: DateTime.now());
    print(selectedDate);
    return selectedDate;
  }
}
