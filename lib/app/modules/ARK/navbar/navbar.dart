import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
// import 'package:muatmuat/app/style/list_colors.dart';
// import 'package:muatmuat/app/widgets/custom_text.dart';
// import 'package:muatmuat/global_variable.dart';

/// Widget Bottom Navigation Bar.
/// Total menu yang dimiliki adalah 4, yaitu Home, Inbox, Pasang Iklan, dan Profile.
/// Navbar ini dipakai dengan berpindah halaman **bukan menggunakan PageView**.
class Navbar extends StatelessWidget {
  List<Function()> _onTaps = [];
  List<Map> _menus = [];

  /// Index menu yang dipilih saat ini.
  final int selectedIndex;

  /// Event ketika menu Home ditekan.
  final Function() onTap1;

  /// Event ketika menu Inbox ditekan
  final Function() onTap2;

  /// Event ketika menu Pasang Iklan ditekan
  final Function() onTap3;

  /// Event ketika menu Profile ditekan
  final Function() onTap4;

  Navbar(
      {this.selectedIndex = -1,
      this.onTap1,
      this.onTap2,
      this.onTap3,
      this.onTap4});

  @override
  Widget build(BuildContext context) {
    _onTaps = [onTap1, onTap2, onTap3, onTap4];

    _menus = [
      {'icon': 'assets/ic_navbar_home.svg', 'title': 'Home'},
      {'icon': 'assets/ic_navbar_message.svg', 'title': 'Inbox'},
      {'icon': 'assets/ic_navbar_shop.svg', 'title': 'Pasang Iklan'},
      {'icon': 'assets/ic_navbar_user.svg', 'title': 'Profile'},
    ];

    if (selectedIndex != -1) {
      if (selectedIndex == 0)
        _menus[selectedIndex]['icon'] = 'assets/ic_navbar_home_active.svg';
      if (selectedIndex == 1)
        _menus[selectedIndex]['icon'] = 'assets/ic_navbar_message_active.svg';
      if (selectedIndex == 2)
        _menus[selectedIndex]['icon'] = 'assets/ic_navbar_shop_active.svg';
      if (selectedIndex == 3)
        _menus[selectedIndex]['icon'] = 'assets/ic_navbar_user_active.svg';
    }

    return Container(
      height: GlobalVariable.ratioWidth(context) * 66,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 12),
            topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 12),
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, GlobalVariable.ratioWidth(context) * -1),
                blurRadius: GlobalVariable.ratioWidth(context) * 24,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.15))
          ]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _menus.map((e) {
            int index = _menus.indexOf(e);

            return GestureDetector(
              onTap: _onTaps[index],
              child: Container(
                width: GlobalVariable.ratioWidth(context) * 70,
                height: GlobalVariable.ratioWidth(context) * 66,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      e['icon'],
                      width: GlobalVariable.ratioWidth(context) * 24,
                      height: GlobalVariable.ratioWidth(context) * 24,
                    ),
                    SizedBox(height: GlobalVariable.ratioWidth(context) * 4),
                    CustomText(e['title'],
                        fontSize: 12,
                        height: 1.2,
                        color: Color(selectedIndex == index
                            ? ListColor.colorBlueTemplate
                            : ListColor.colorGreyTemplate1))
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}
