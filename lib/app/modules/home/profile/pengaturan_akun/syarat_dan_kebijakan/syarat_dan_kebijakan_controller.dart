import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_syarat_profil.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/pengaturan_akun/pengaturan_akun_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class SyaratDanKebijakanController extends GetxController {
  final isSuccess = false.obs;
  var tipe = "";

  var atBottom = false.obs;
  PengaturanAkunController controllerAkun;
  ModelSyaratProfil data = ModelSyaratProfil();

  @override
  void onInit() async {
    getInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void getInit () async{
    tipe = await Get.arguments;
    try{
      controllerAkun = Get.find();
      if(tipe == "register_tm") {
        //Transport Market Subscription
        data = controllerAkun.listSyarat["register_tm"];
      } else if(tipe == "register_bf") {
        //Big Fleets Subscription
        data = controllerAkun.listSyarat["register_bf"];
      } else if(tipe == "tm") {
        //Transport Market
        data = controllerAkun.listSyarat["tm"];
      } else if(tipe == "general") {
        //Pengguna MuatMuat
        data = controllerAkun.listSyarat["general"];
      } else if(tipe == "bf") {
        //Big Fleets
        data = controllerAkun.listSyarat["bf"];
      } else {
        data = controllerAkun.listSyarat["kebijakan"];
      }
    } catch (e) {
      print(e);
    }
    isSuccess.value = true;
  }
  
  void urlLauncher(String url) async {
    if (await canLaunch(url)) {
      Get.toNamed(Routes.WEBVIEW_TAC_PAP, arguments: url);
    }
  }
}
