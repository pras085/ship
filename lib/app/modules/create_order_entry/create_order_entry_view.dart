import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/create_order_entry/create_order_entry_controller.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';

class CreateOrderEntryView extends GetView<CreateOrderEntryController> {
  var mitraController = TextEditingController();
  var lokasiPickupController = TextEditingController();
  var lokasiDestinasiController = TextEditingController();
  var jenisTrukController = TextEditingController();
  var beratMuatanController = TextEditingController();
  var volumeMuatanController = TextEditingController();
  var isiMuatanController = TextEditingController();

  var tanggalOrder = DateTime.now().obs;
  var waktuPengiriman = DateTime.now().obs;
  var ekspetasi = DateTime.now().obs;
  var status = "Active".obs;

  var dateFormat = DateFormat('dd MMMM yyyy');
  var dateTimeFormat = DateFormat('dd MMMM yyyy / HH:mm');

  @override
  Widget build(BuildContext context) {
    tanggalOrder.value = null;
    waktuPengiriman.value = null;
    ekspetasi.value = null;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Create Order Entry"),
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
                    child: CustomText('No Order',
                        color: Colors.black, fontSize: 18)),
                Container(
                    margin: EdgeInsets.only(bottom: 10, left: 15),
                    child: CustomText("OE-012",
                        color: Colors.black, fontSize: 16)),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: CustomText('Tanggal Order',
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
                          var selectedDate = await datePicker();
                          if (selectedDate != null) {
                            tanggalOrder.value = selectedDate;
                          }
                        },
                        child: Obx(() => CustomText(
                            (waktuPengiriman.value == null)
                                ? "Choose a date"
                                : dateTimeFormat.format(waktuPengiriman.value),
                            color: Colors.blue)))),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'Mitra',
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: mitraController,
                ),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'Lokasi Pickup',
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: lokasiPickupController,
                ),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'Lokasi Destinasi',
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: lokasiDestinasiController,
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: CustomText('Waktu Pengiriman',
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
                          var selectedDate = await dateTimePicker();
                          if (selectedDate != null) {
                            if (ekspetasi.value == null ||
                                ekspetasi.value.isAfter(selectedDate)) {
                              waktuPengiriman.value = selectedDate;
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Waktu pengiriman harus lebih awal dari waktu kedatangan");
                            }
                          }
                        },
                        child: Obx(() => CustomText(
                            (waktuPengiriman.value == null)
                                ? "Choose a date"
                                : dateTimeFormat.format(waktuPengiriman.value),
                            color: Colors.blue)))),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: CustomText('Ekspetasi Kedatangan',
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
                          var selectedDate = await dateTimePicker();
                          if (selectedDate != null) {
                            if (waktuPengiriman.value == null ||
                                selectedDate.isAfter(waktuPengiriman.value)) {
                              ekspetasi.value = selectedDate;
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Waktu kedatangan harus lebih besar dari waktu pengiriman");
                            }
                          }
                        },
                        child: Obx(() => CustomText(
                            (ekspetasi.value == null)
                                ? "Choose a date"
                                : dateTimeFormat.format(ekspetasi.value),
                            color: Colors.blue)))),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'Jenis Truk',
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: jenisTrukController,
                ),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'Berat Muatan',
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: beratMuatanController,
                ),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'Volume Muatan',
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: volumeMuatanController,
                ),
                TextFormFieldWidget(
                  titleColor: Colors.black,
                  title: 'Isi Muatan',
                  width: double.infinity,
                  validator: (String value) {
                    return null;
                  },
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: isiMuatanController,
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: CustomText('Status Order',
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
                              groupValue: status.value,
                              onChanged: (value) {
                                status.value = value;
                              },
                            ),
                          ),
                          ListTile(
                            title: CustomText("Cancelled"),
                            leading: Radio(
                              value: "Cancelled",
                              groupValue: status.value,
                              onChanged: (value) {
                                status.value = value;
                              },
                            ),
                          ),
                          ListTile(
                            title: CustomText("Finished"),
                            leading: Radio(
                              value: "Finished",
                              groupValue: status.value,
                              onChanged: (value) {
                                status.value = value;
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
                        child: CustomText('Submit', color: Colors.white))),
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

  Future<DateTime> dateTimePicker() async {
    var hasil;
    await DatePicker.showDateTimePicker(Get.context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime.now().add(Duration(days: 365)),
        onChanged: (changedDate) {
      print(changedDate);
    }, onConfirm: (confirmedDate) {
      print(confirmedDate);
      hasil = confirmedDate;
    });
    return hasil;
  }
}
