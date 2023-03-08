import 'package:azlogistik_chat/utilities/constants.dart';
import 'package:flutter/material.dart';

class ThemeHelper {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static ThemeData azTheme = ThemeData(
    fontFamily: 'AvenirNextLTPro',
    primarySwatch: ThemeHelper.createMaterialColor(AColors.primary),
    accentColor: ThemeHelper.createMaterialColor(AColors.secondary),
    backgroundColor: AColors.white,
    scaffoldBackgroundColor: AColors.white,
    canvasColor: AColors.white,
    // inputDecorationTheme: InputDecorationTheme(
    //   border: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: AColors.black10,
    //       width: 0.6,
    //     ),
    //     borderRadius: BorderRadius.circular(8)
    //   ),
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: AColors.black10,
    //       width: 0.6,
    //     ),
    //     borderRadius: BorderRadius.circular(8)
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: AColors.black50,
    //       width: 0.6,
    //     ),
    //     borderRadius: BorderRadius.circular(8)
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: AColors.danger,
    //       width: 2,
    //     ),
    //     borderRadius: BorderRadius.circular(8)
    //   ),
    //   contentPadding: EdgeInsets.symmetric(
    //     horizontal: 16,
    //     vertical: 8,
    //   ),
    // ),
    // radioTheme: RadioThemeData(
    //   fillColor: MaterialStateProperty
    //     .resolveWith((states) {
    //       if(states.contains(MaterialState.selected)){
    //         return AColors.primary;
    //       }
    //       return AColors.gray2;
    //     }),
    // ),
    // tabBarTheme: TabBarTheme(
    //   indicator: BoxDecoration(
    //     border: Border(
    //       bottom: BorderSide(
    //         color: AColors.primary500,
    //         width: 4,
    //       )
    //     )
    //   ),
    //   labelStyle: TextStyle(
    //     fontSize: 13,
    //     fontWeight: FontWeight.w600,
    //   ),
    //   unselectedLabelStyle: TextStyle(
    //     fontSize: 13,
    //     fontWeight: FontWeight.normal,
    //   ),
    //   labelPadding: EdgeInsets.symmetric(
    //     vertical: 0,
    //     horizontal: 16,
    //   ),
    // )
  );
}