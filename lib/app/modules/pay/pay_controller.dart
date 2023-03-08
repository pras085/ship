import 'dart:io';
import 'package:contacts_service/contacts_service.dart';
// import 'package:flutrans/flutrans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PayController extends GetxController {
  var listUser = List<String>().obs;
  var listUserFilter = List<String>().obs;
  var loadContacts = true.obs;
  var contacts = List<Contact>().obs;
  var contactsFilter = List<Contact>().obs;
  // final flutrans = Flutrans();
  final FirebaseMessaging fcm = FirebaseMessaging();

  @override
  Future<void> onInit() async {
    listUser.clear();
    listUser.add("Croix");
    listUser.add("Gild");
    listUser.add("Isflugel");
    listUser.add("Xigmund");
    listUserFilter.value = listUser.value;
    var getList = await ContactsService.getContacts();
    contacts.value = getList.toList();
    contactsFilter.value = getList.toList();
    loadContacts.value = false;
    // flutrans.init("", "");
    // flutrans.setFinishCallback((finished) {
    //   //finished is TransactionFinished
    // });
  }

  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  Future firebaseInit() async {
    if (Platform.isIOS) {
      fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // showDialog(context: context, builder: (context){
        //   return AlertDialog(content: Text('Hei, ada pesan $message'),);
        // });
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  void doTransaction() {
    // flutrans
    //     .makePayment(
    //       MidtransTransaction(
    //           7500,
    //           MidtransCustomer(
    //               "Apin", "Prastya", "apin.klas@gmail.com", "08123456789"),
    //           [
    //             MidtransItem(
    //               "5c18ea1256f67560cb6a00cdde3c3c7a81026c29",
    //               7500,
    //               2,
    //               "USB FlashDisk",
    //             )
    //           ],
    //           skipCustomer: true,
    //           customField1: "Test beli ini"),
    //     )
    //     .catchError((err) => print("ERROR $err"));
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
