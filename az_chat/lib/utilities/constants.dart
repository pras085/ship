import 'package:azlogistik_chat/utilities/config.dart';
import 'package:azlogistik_chat/utilities/theme_helper.dart';
import 'package:flutter/material.dart';

class AColors{
  static const Color primary = Color(0xFF176CF7);
  static const Color primary50 = Color(0xFFD1E2FD);
  
  static const Color secondary = Color(0xFFF47621);
  static const Color secondary50 = Color(0xFFFFE8C6);

  static const Color black = Color(0xFF000000);
  static const Color black10 = AColors.gray3;
  static const Color black28 = AColors.gray2;
  static const Color black50 = AColors.gray1;
  static const Color black90 = Color(0xFF171D16);

  static const Color gray1 = Color(0xFF676767);
  static const Color gray2 = Color(0xFF868686);
  static const Color gray3 = Color(0xFFDDDDDD);
  static const Color gray3A = Color(0xFFE5E5E5);
  static const Color gray4 = Color(0xFFF7F8FA);
  static const Color gray5 = Color(0xFFFAFBFC);
  
  static const Color white = Color(0xFFFFFFFF);
  
  static const Color facebook = Color(0xFF1877F2);
  
  static const Color warning = Color(0xFFF5CE00);
  static const Color warning50 = Color(0xFFFFFDC6);
  
  static const Color danger = Color(0xFFD21946);
  static const Color danger50 = Color(0xFFF9D0D7);
  
  static const Color info = Color(0xFF6F2CFF);
  static const Color info50 = Color(0xFFECE7FF);

  static const Color whatsapp = Color(0xFF25D366);
  static const Color appBarBackground = Color(0xFFFFFFFF);
}

class ATheme{
  static ThemeData defaultTheme = ThemeData(
    fontFamily: 'WorkSans',
    primarySwatch: ThemeHelper.createMaterialColor(AColors.primary),
    // accentColor: ThemeHelper.createMaterialColor(AColors.primary50),
    backgroundColor: AColors.white,
    scaffoldBackgroundColor: AColors.white,
    canvasColor: AColors.white,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AColors.black10,
          width: 0.6,
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AColors.black10,
          width: 0.6,
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AColors.black50,
          width: 0.6,
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AColors.danger,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty
        .resolveWith((states) {
          if(states.contains(MaterialState.selected)){
            return AColors.primary;
          }
          return AColors.gray2;
        }),
    ),
    tabBarTheme: const TabBarTheme(
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AColors.primary,
            width: 4,
          )
        )
      ),
      labelStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.normal,
      ),
      labelPadding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 16,
      ),
    )
  );

  static const TextStyle textHeader2 = TextStyle(fontWeight: FontWeight.w700, fontSize: AFont.sizeHeader2, fontFamily: 'Rubik');
  static const TextStyle textHeader2Green = TextStyle(fontWeight: FontWeight.w700, fontSize: AFont.sizeHeader2, color: AColors.primary, fontFamily: 'Rubik');
  static final BoxDecoration boxShadow = BoxDecoration(
      color: Colors.white,
      boxShadow: [
        boxShadowOnly
      ]
  );
  static final BoxShadow boxShadowOnly = BoxShadow(
    color: const Color(0xFF00255C).withOpacity(0.1),
    //spreadRadius: 2,
    blurRadius: 12,
    offset: const Offset(0, 2),
  );
  static final BoxShadow boxShadowOnlyProductThumbnail = BoxShadow(
    color: const Color(0xFFA3AEC1).withOpacity(0.14),
    //spreadRadius: 2,
    blurRadius: 8,
    offset: const Offset(0, 2),
  );
  static const EdgeInsets boxEdgeInsets = EdgeInsets.only(left: ASize.spaceBox, right: ASize.spaceBox, top: ASize.spaceMedium, bottom: ASize.spaceMedium);
  //static final TextStyle textNormalBold = TextStyle(fontWeight: FontWeight.w600);
}

class AFont{
  static const double sizeSmall = 11;
  static const double sizeBody = 14;
  static const double sizeHeader1 = 20;
  static const double sizeHeader2 = 16;
}

class ASize{
  static const double icon = 24;
  static const double iconVerySmall = 12;
  static const double iconSmall = 16;
  static const double iconBig = 32;
  static const double spaceSmall = 4;
  static const double spaceNormal = 8;
  static const double spaceText = 12;
  static const double spaceMedium = 15;
  static const double spaceBox = 20;
  static const double spaceLarge = 36;
  static const double productThumbSmall = 48;
  static const double chatBubbleMinWidth = 20;
  static const double chatBubbleLinkMaxWidth = 200;
}

class Urls{
  // static const String BASE_URL = 'https://azlogistikchat.loca.lt/azlogistik-chat';
  // static const String BASE_URL = 'http://apichat.assetlogistik.com';
  static String URL_CHAT_GET_ROOM = Config.baseUrl + "/api-chat/chatroom";
  static String URL_CHAT_GET_ROOM_DETAIL = Config.baseUrl + "/api-chat/chatroomdetail";
  static String URL_CHAT_GET_CHAT = Config.baseUrl + "/api-chat/chatget";
  static String URL_CHAT_ADD_CHAT = Config.baseUrl + "/api-chat/chatadd";
  static String URL_CHAT_PREVIEW = Config.baseUrl + "/api-chat/chatpreview";
  static String URL_CHAT_READ_CHAT = Config.baseUrl + "/api-chat/chatread";
  static String URL_UPLOAD_FILE = Config.baseUrl + "/api/uploadfile";
  static String URL_REGISTER_DEVICE_ID = Config.baseUrl + "/api/registerdeviceid";
  static String URL_GET_TOKEN = Config.baseUrl + "/api/gettoken";
}

class Params{
  static const String PARAM_META = 'Meta';
  static const String PARAM_CODE = 'Code';
  static const String PARAM_DATA = 'Data';
  static const String PARAM_MESSAGE = 'Message';
  static const String PARAM_LINK = 'Link';
}