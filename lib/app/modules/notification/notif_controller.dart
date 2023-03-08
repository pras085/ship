import 'dart:developer';

import 'package:get/get.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'notif_model.dart';
import 'notif_category.dart';
import 'final_list.dart';
import 'menu_model.dart';

class NotifControllerNew extends GetxController {

  var listNotif = List<NotifModel>().obs;
  var listMenu =  List<MenuModel>().obs;
  var chosenmenu = 0.obs;
  var status = 1.obs;
  var notifList = <NotifCategory>[].obs;
  var contentList = <FinalList>[].obs;
  var subcontentList = <SupportingData>[].obs;
  var loading = true.obs;
  var loading2 = true.obs;
  var choosensub = "".obs;
  var currentlength = 0.obs;
  var totalall = 0.obs;
  var doneloading = true.obs;
  var unread = new List(20).obs;
  var unreadid = new List(20).obs;
  var unreadsubs = new List(100).obs;  
  var unreadsub = 0.obs;

  var notifarray = List.generate(100, (index) => List(100), growable: false).obs;
  var listarray = [].obs;
  var subarray = [].obs;
  var choosesub = false.obs;
  var i = 0.obs;
  RxString indo = 'true'.obs;
  RxString eng = 'false'.obs;
  RxString selectedLang = 'true'.obs;

  @override
  void onInit() async {
    var listres = List<NotifCategory>();
    listres.add(NotifCategory(identifier: 0, categoryName: 'Semua', countCategory: 0, subCategory: [{"Identifier" : 4, "SubCategoryName" : "", "CountSubCategory" : 3}]));
    Future.delayed(Duration.zero, () async {
  notifList.addAll(listres);
});
    var result = await ApiHelper(context: Get.context, isShowDialogLoading: false).getAllNotif();
    if(result!=null){
    // log(result.toString() + '');
    totalall.value = result['CountAllNotif'];
    var list = await result['Data'] as List;
    var newdata = list.map((i) => NotifCategory.fromJson(i)).toList();
    notifList.addAll(newdata);
    }
    var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).getListNotifAll();
    // print(result['Data']);
    if(resultx!=null){
    var listx = await resultx['Data'] as List;
    
    var newdatax = listx.map((i) => FinalList.fromJson(i)).toList();
    
    contentList.addAll(newdatax);
    // log(result['Data'].toString());
    for(var i = 0 ; i < notifList.length ; i ++){
      log(result['Data'][i]['Identifier'].toString() + ' minji');
      log(result['Data'][i]['CountKategori'].toString() + 'refo');
      unread[i] = result['Data'][i]['CountKategori'];
      unreadid[i] = result['Data'][i]['Identifier'];
      log(unread.toString() + 'huhu');
      // unread[i] = notifList[i].
    }
    loading.value = false;
    }
    log(contentList.toString());
    log(subcontentList.toString());
    // print(notifList);
    var list = List<NotifModel>();
    list.add(NotifModel(title : "[Penting] Pembaruan pada Syarat dan Ketentuan Pengguna", subTitle : "Pada tanggal 20 Desember 2022 kami memperbarui Syarat dan Ketentuan Pengguna muatmuat untuk membantu memperjelas dan mempermudah Anda dalam menggunakan layanan di muatmuat. Anda dapat melihat Syarat dan Ketentuan terbaru di sini.", desc : "12 Des 2022 07:00 WIB", image : "https://picsum.photos/250?image=9"));
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

    var listmenu = List<MenuModel>();
    listmenu.add(MenuModel(id:0 ,title: "Semua", submenu: [""]));
    listmenu.add(MenuModel(id:1 ,title: "Umum", submenu: ["Semua", "Tender", "Lainnya"]));
    listmenu.add(MenuModel(id:2 ,title: "Big Fleets", submenu: ["Semua", "Mitra", "Tender", "Lainnya"]));
    listmenu.add(MenuModel(id:3 ,title: "Transport Market", submenu: ["Semua", "Mitra", "Tender"]));
    listMenu.assignAll(listmenu);
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  updateToReaded(int index){
    var notif = contentList[index];
    notif.statusread = 1;
    contentList[index] = notif;
  }

  updateToReadedAll(num index){
    log('masuk');
    for(var i = 0 ; i < index ; i++){
    var notif = contentList[i];
    notif.statusread = 1;
    contentList[i] = notif;
    log('masuk' + i.toString());
    }
  }

  changemenu(num kategori) async{
    loading.value  = true;
    var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).getListNotifKategori(kategori.toString());
    log(resultx['SupportingData']['NotReadCount'].toString());
    if(resultx!=null){
    var listx = await resultx['Data'] as List;
    var newdatax = listx.map((i) => FinalList.fromJson(i)).toList();
    contentList.addAll(newdatax);
    loading.value  = false;
    }
  }

  changemenusub(num kategori, num subkategori) async{
    loading.value  = true;
    var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).getCount(kategori.toString(), subkategori.toString());
    print(resultx);
    if(resultx!=null){
    var listx = await resultx['Data'] as List;
    var newdatax = listx.map((i) => FinalList.fromJson(i)).toList();
    contentList.addAll(newdatax);
    loading.value  = false;
    }
  }

  changemenusubunread(num kategori, num subkategori) async{
    loading.value  = true;
    var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).getCountUnread(kategori.toString(), subkategori.toString());
    print(resultx);
    if(resultx!=null){
    var listx = await resultx['Data'] as List;
    var newdatax = listx.map((i) => FinalList.fromJson(i)).toList();
    contentList.addAll(newdatax);
    loading.value  = false;
    }
  }

  // getcountdata(num kategori, num subkategori) async{
  //   log('refo');
  //   var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).getCount(kategori.toString(), subkategori.toString());
  //   // log(resultx);
  //   log('Zehaha mugiwara');
  //   if(resultx!=null){
  //     log('Zehaha mugiwara');
  //   // var listx = await resultx['Data'] as List;
  //   // var newdatax = listx.map((i) => FinalList.fromJson(i)).toList();
  //   // contentList.addAll(newdatax);
  //   }
  //   }

  changemenuall() async{
    loading.value  = true;
    var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).getListNotifAll();
    // print(result['Data']);
    if(resultx!=null){
    var listx = await resultx['Data'] as List;
    var newdatax = listx.map((i) => FinalList.fromJson(i)).toList();
    contentList.addAll(newdatax);
    loading.value  = false;
    }
  }

   changemenukategori(String id) async{
    loading.value  = true;
    var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).getListNotifKategori(id);
    // print(result['Data']);
    if(resultx!=null){
    var listx = await resultx['Data'] as List;
    var newdatax = listx.map((i) => FinalList.fromJson(i)).toList();
    contentList.addAll(newdatax);
    loading.value  = false;
    }
  }

  changemenuallunread() async{
    loading.value  = true;
    var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).getListNotifAllUnread();
    // print(result['Data']);
    if(resultx!=null){
    var listx = await resultx['Data'] as List;
    var newdatax = listx.map((i) => FinalList.fromJson(i)).toList();
    contentList.addAll(newdatax);
    loading.value  = false;
    }
  }

  changemenuallunreadkategori(String id) async{
    loading.value  = true;
    var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).getListNotifAllUnreadKategori(id);
    // print(result['Data']);
    if(resultx!=null){
    var listx = await resultx['Data'] as List;
    var newdatax = listx.map((i) => FinalList.fromJson(i)).toList();
    contentList.addAll(newdatax);
    loading.value  = false;
    }
  }

  changemenuallonlyread() async{
    loading.value  = true;
    var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).getListNotifAll();
    // print(result['Data']);
    if(resultx!=null){
    var listx = await resultx['Data'] as List;
    var newdatax = listx.map((i) => FinalList.fromJson(i)).toList();
    contentList.addAll(newdatax);
    loading.value  = false;
    }
  }

  awaw() async{
    return 1 + 1;
  }

  Future<String> gettotal(String kategori, String subkategori) async{
    log('masuk sini');
    log('masuk sini 2');
    return notifarray[int.parse(kategori)][int.parse(subkategori)];
    // var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).getCount(kategori, subkategori);
    // if(resultx != null){
    // print('masuk sini 3');
    // // var listx = resultx[3] as List;
    // // print(listx);
    // // print('refo');
    // // var newdatax = listx.map((i) => FinalList.fromJson(i)).toList();
    // // contentList.addAll(newdatax);
    // }

  }
}