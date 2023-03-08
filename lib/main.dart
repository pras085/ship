import 'dart:io';

import 'package:azlogistik_chat/bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'dart:developer';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/modules/buyer/detail/detail_iklan_product_view.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/translate/translate.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  FlutterStatusbarManager.setColor(Colors.transparent);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initializeDateFormatting();
  await FlutterDownloader.initialize();
  await SharedPreferencesHelper.getLanguage();
  await Utils.initDynamicLinks();
  GlobalVariable.isDebugMode = false;
  if (GlobalVariable.languageCode == "") {
    // await SharedPreferencesHelper.setLanguage(Get.deviceLocale.languageCode);
    await SharedPreferencesHelper.setLanguage("id", "id_ID", "Indonesia");
  }
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp(
    OKToast(
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
        child: MyAppWithChat(),
        // child: GetMaterialApp(
        //   navigatorObservers: [
        //     FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        //   ],
        //   translations: Translate(),
        //   locale: (Locale(GlobalVariable.languageCode)),
        //   title: "Muatmuat",
        //   initialRoute: AppPages.INITIAL,
        //   getPages: AppPages.routes,
        //   theme: ThemeData(
        //       appBarTheme: AppBarTheme(
        //           backgroundColor: Color(ListColor.color4),
        //           brightness: Brightness.dark),
        //       primaryColor: Color(ListColor.color4),
        //       fontFamily: 'AvenirNext'),
        //   debugShowCheckedModeBanner: false,
        //   builder: (context, child) {
        //     return MediaQuery(
        //         child: child,
        //         data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0));
        //   },
        // ),
      ),
    ),
  );
}

class MyAppWithChat extends StatelessWidget {
  final botToastBuilder = BotToastInit(); 

  @override
  Widget build(BuildContext context) {

    ChatCubit.newInstance(navigatorKey, chatPageController, 
    'ee070a623cda451367e56a1f218215a3',
    baseUrl: 'https://apichat.assetlogistik.com',
    onTncClicked: () {
      // on TnC Clicked
    },
    //blockedMessage: controller.blockedMessage
    );
    return GetMaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        BotToastNavigatorObserver()
      ],
      navigatorKey: navigatorKey,
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
        child = botToastBuilder(context, child);
        return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0));
      },
    );
  
  }
}