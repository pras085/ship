import 'package:get/get.dart';
import 'notif_model.dart';

class NotifController extends GetxController {

  var listNotif = List<NotifModel>().obs;

  @override
  void onInit() {
    
    var list = List<NotifModel>();
    list.add(NotifModel(title : "Title 1", subTitle : "Subtitle", desc : "ini adalah deskripsi 1", image : "https://picsum.photos/250?image=9"));
    list.add(NotifModel(title : "Title 2", subTitle : "Subtitle", desc : "ini adalah deskripsi 1", image : ""));
    list.add(NotifModel(title : "Title 3", subTitle : "Subtitle", desc : "ini adalah deskripsi 1", image : ""));
    list.add(NotifModel(title : "Title 4", subTitle : "Subtitle", desc : "ini adalah deskripsi 1", image : ""));
    list.add(NotifModel(title : "Title 5", subTitle : "Subtitle", desc : "ini adalah deskripsi 1", image : ""));
    list.add(NotifModel(title : "Title 6", subTitle : "Subtitle", desc : "ini adalah deskripsi 1", image : ""));
    list.add(NotifModel(title : "Title 7", subTitle : "Subtitle", desc : "ini adalah deskripsi 1", image : ""));
    list.add(NotifModel(title : "Title 8", subTitle : "Subtitle", desc : "ini adalah deskripsi 1", image : ""));
    list.add(NotifModel(title : "Title 9", subTitle : "Subtitle", desc : "ini adalah deskripsi 1", image : ""));
    list.add(NotifModel(title : "Title 10", subTitle : "Subtitle", desc : "ini adalah deskripsi 1", image : ""));
    list.add(NotifModel(title : "Title 11", subTitle : "Subtitle", desc : "ini adalah deskripsi 1", image : ""));
    listNotif.assignAll(list);
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  updateToReaded(int index){
    var notif = listNotif[index];
    notif.open = true;
    listNotif[index] = notif;
  }
}