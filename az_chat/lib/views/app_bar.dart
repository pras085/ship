import 'package:azlogistik_chat/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AAppBar extends AppBar {
  AAppBar({
    String? title,
    Widget? customTitle,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    double? elevation,
    double? titleSpacing,
    Color? backgroundColor,
    Color? titleColor,
  }) : super(
    title: customTitle ?? Text(
      title ?? '',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: titleColor ?? AColors.white,
        fontFamily: 'Rubik'
      ),
    ),
    centerTitle: false,
    actions: (actions ?? []) + [
      Container(
        width: 16,
      ),
    ],
    flexibleSpace: SafeArea(
      child: Image.asset(
        'assets/images/appbar-bg.png',
        package: 'azlogistik_chat',
        fit: BoxFit.fitHeight,
        height: kToolbarHeight,
        alignment: Alignment.topRight,
      ),
    ),
    backgroundColor: backgroundColor ?? AColors.primary,
    bottom: bottom,
    elevation: elevation,
    titleSpacing: titleSpacing ?? 0,
    leading: Builder(
      builder: (context) {
        return IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          color: backgroundColor != null ? AColors.white : AColors.primary,
          icon: Center(
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: backgroundColor != null ? AColors.primary : AColors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              // child: const Icon(
              //   Icons.chevron_left,
              //   size: 16,
              //   // color: backgroundColor != null ? AColors.white : AColors.primary,
              // ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/chevron-left.svg',
                  package: 'azlogistik_chat',
                  color: backgroundColor != null ? AColors.white : AColors.primary,
                  // height: 10
                ),
              ),
            ),
          )
        );
      }
    )
  );

  static Widget actionButton({
    Key? key,
    String? iconSvg,
    Color? iconColor,
    Function()? onPressed,
    int notifCount = 0,
    bool showNotifCount = true,
  }){
    return GestureDetector(
      onTap: onPressed, 
      child: Center(
        child: Container(
          key: key,
          width: 36,
          height: 36,
          child: Stack(
            children: [
              Positioned.fill(
                child: iconSvg != null 
                ? Center(
                  child: SvgPicture.asset(
                    iconSvg,
                    package: 'azlogistik_chat',
                    // size: 20,
                    color: iconColor ?? AColors.gray1,
                  ),
                )
                : Container(),
              ),

              if(notifCount > 0)
                Positioned(
                  top: showNotifCount ? 0 : 4,
                  right: showNotifCount ? 0 : 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AColors.danger,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    width: showNotifCount ? 16 : 8,
                    height: showNotifCount ? 16 : 8,
                    child: showNotifCount ? Text(
                      notifCount > 9 ? '9+' : notifCount.toString(),
                      style: TextStyle(
                        fontSize: 8,
                        color: AColors.white,
                      ),
                    ) : null,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

}