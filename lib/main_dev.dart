import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/translate/translate.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/appbar_custom1.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterStatusbarManager.setColor(Colors.transparent);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await FlutterDownloader.initialize();
  await SharedPreferencesHelper.getLanguage();
  GlobalVariable.isDebugMode = false;
  if (GlobalVariable.languageCode == "") {
    // await SharedPreferencesHelper.setLanguage(Get.deviceLocale.languageCode);
    await SharedPreferencesHelper.setLanguage("id", "id_ID", "Indonesia");
  }
  runApp(OKToast(
    child: RefreshConfiguration(
      headerBuilder: () => WaterDropMaterialHeader(),
      footerBuilder: () => CustomFooter(
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = null;
          } else if (mode == LoadStatus.loading) {
            body = CircularProgressIndicator();
          } else if (mode == LoadStatus.failed) {
            body = null;
          } else if (mode == LoadStatus.canLoading) {
            body = null;
          } else
            body = null;
          return body == null
              ? SizedBox.shrink()
              : Container(
                  height: 50,
                  child: Center(child: body),
                );
        },
      ),
      headerTriggerDistance: 80,
      child: GetMaterialApp(
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],
        translations: Translate(),
        locale: (Locale(GlobalVariable.languageCode)),
        title: "Muatmuat",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Color(ListColor.color4),
                brightness: Brightness.dark),
            primaryColor: Color(ListColor.color4),
            fontFamily: 'AvenirNext'),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
              child: child,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0));
        },
      ),
    ),
  ));
}
