import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/bottom_navbar/notif_chat_controller.dart';
import 'package:muatmuat/app/modules/bottom_navbar/notif_chat_view.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/modules/home/home/home_new/afterLoginSubUser_controller.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ScaffoldWithBottomNavbar extends StatelessWidget {
  final Widget body;
  final bool newNotif;
  final bool beforeLogin;
  var isChange = false.obs;

  ScaffoldWithBottomNavbar({@required this.body, this.newNotif = false, this.beforeLogin = false});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Color(ListColor.color4),
      extendBody: true,
      body: body,
      bottomNavigationBar: BottomAppBarMuat(
        centerItemText: '',
        color: Colors.grey,
        backgroundColor: Colors.white,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (index) {
          switch (index) {
            case 0:
              beforeLogin
                ? GetToPage.offAllNamed<RegisterUserController>(Routes.REGISTER_USER)
                : GetToPage.toNamed<NotifChatView>(Routes.NOTIF_CHAT_SCREEN);
              break;
            case 1:
              beforeLogin
                ? GetToPage.offAllNamed<RegisterUserController>(Routes.REGISTER_USER)
                : Get.toNamed(Routes.PROFIL);
              break;
          }
        },
        items: [
          BottomAppBarItemModel(iconName: newNotif ? 'ic_message_notif.svg' : 'message_menu_icon.svg', text: ''),
          BottomAppBarItemModel(iconName: 'user_menu_icon.svg', text: ''),
        ],
        iconSize: GlobalVariable.ratioWidth(context) * 76,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: GlobalVariable.ratioWidth(context) * 76,
        height: GlobalVariable.ratioWidth(context) * 76,
        child: FloatingActionButton(
          onPressed: () async {
            print("clicked!");
          },
          child: SvgPicture.asset(
            GlobalVariable.imagePath + "ic_muatmuat_navbar.svg",
            width: GlobalVariable.ratioWidth(context) * 76,
          ),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(context) * 90.0)),
            side: BorderSide(
              color: Colors.white,
              width: GlobalVariable.ratioWidth(context) * 4.0
            )
          ),
        ),
      ),
    );
  }
}
