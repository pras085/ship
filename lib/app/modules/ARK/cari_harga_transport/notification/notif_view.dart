import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/notification/notif_controller.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/notification/notif_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class NotifView extends GetView<NotifController> {
  // NotifController controller = Get.put(NotifController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('notif'.tr, style: TextStyle(color: Colors.white))),
        body: SafeArea(
            child: Container(
          color: Colors.white,
          child: Obx(() => controller.listNotif.isEmpty
              ? Center(
                  child: Text('Empty',
                      style: TextStyle(
                          color: Color(
                            ListColor.color4,
                          ),
                          fontWeight: FontWeight.bold,
                          fontSize: 30)))
              : ListView.builder(
                  itemCount: controller.listNotif.length,
                  itemBuilder: (context, index) {
                    return notifTile(controller.listNotif.value[index], index);
                  },
                )),
        )));
  }

  Widget notifTile(NotifModel notif, int index) {
    return AnimatedContainer(
      color: notif.open ? Colors.white : Colors.blue[100],
      margin: EdgeInsets.only(bottom: 1),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          controller.updateToReaded(index);
        },
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                width: 60,
                height: 60,
                decoration: notif.image.isNotEmpty
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 40)),
                        color: Colors.white,
                        border: Border.all(
                            color: Color(ListColor.color4), width: 1)),
                padding: EdgeInsets.all(notif.image.isEmpty ? 10 : 0),
                child: notif.image.isEmpty
                    ? Icon(
                        Icons.notifications,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(notif.image),
                      ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notif.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    Text(notif.subTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                    Text(notif.desc),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
