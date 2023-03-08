import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

///Appbar ini digunakan untuk list dari modul buyer
///[title] untuk mengisi title
///[subTitle] untuk mengisi sub title
///[onClickBack] untuk aksi back button
///[onClickFavorite] untuk aksi icon favorite
///[onClickSort] untuk aksi icon sorting
///[onClickFilter] untuk aksi icon filter
///[isActiveFavorite] di isi [true] untuk icon aktif, [false] untuk tidak aktif, dan [null] untuk disable
///[isActiveSort] di isi [true] untuk icon aktif, [false] untuk tidak aktif, dan [null] untuk disable
///[isActiveFilter] di isi [true] untuk icon aktif, [false] untuk tidak aktif, dan [null] untuk disable
///[jumlahFilter] di isi jumlah filter ketika filter aktif
class AppBarListBuyer extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subTitle;
  final VoidCallback onClickBack;
  final Function onClickFavorite;
  final Function onClickSort;
  final Function onClickFilter;
  final bool isActiveFavorite;
  final bool isActiveSort;
  final bool isActiveFilter;
  final String jumlahFilter;

  AppBarListBuyer({
    Key key,
    this.title = '',
    this.subTitle = '',
    @required this.onClickBack,
    @required this.onClickFavorite,
    @required this.onClickSort,
    @required this.onClickFilter,
    this.isActiveFavorite = false,
    this.isActiveSort = false,
    this.isActiveFilter = false,
    this.jumlahFilter = "",
  });

  @override
  final Size preferredSize = Size(double.infinity, GlobalVariable.ratioWidth(Get.context) * 60);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Container(
      decoration: BoxDecoration(
        color: Color(ListColor.colorBlueTemplate), 
        boxShadow: [
          BoxShadow(
            offset: Offset(
              GlobalVariable.ratioWidth(context) * 0,
              GlobalVariable.ratioWidth(context) * 4,
            ),
            blurRadius: GlobalVariable.ratioWidth(context) * 15,
            color: Colors.black.withOpacity(0.15),
          ),
        ],
      ),
      height: GlobalVariable.ratioWidth(context) * 60,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16,),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomBackButton(
                  context: context,
                  iconColor: Color(ListColor.colorBlueTemplate),
                  backgroundColor: Color(ListColor.colorWhite),
                  onTap: onClickBack,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomText(
                          title,
                          fontWeight: FontWeight.w700,
                          color: Color(ListColor.colorWhite),
                          fontSize: 16,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 4),
                          child: CustomText(
                            subTitle,
                            fontWeight: FontWeight.w700,
                            color: Color(ListColor.colorBlueTemplate2),
                            fontSize: 12,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _icon(
                  isActiveFavorite == null 
                  ? GlobalVariable.urlImageTemplateBuyer + "ic_wishlist_temp.svg"
                  : isActiveFavorite 
                    ? GlobalVariable.urlImageTemplateBuyer + "ic_wishlist_active_temp.svg"
                    : GlobalVariable.urlImageTemplateBuyer + "ic_wishlist_temp.svg", 
                  (){onClickFavorite();}, isActiveFavorite),
                Container(  
                  margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                  child: _icon(
                    isActiveSort == null 
                    ? GlobalVariable.urlImageTemplateBuyer + "ic_sort_temp.svg"
                    : isActiveSort 
                      ? GlobalVariable.urlImageTemplateBuyer + "ic_sort_active_temp.svg"
                      : GlobalVariable.urlImageTemplateBuyer + "ic_sort_temp.svg", 
                    (){onClickSort();}, isActiveSort)
                ),
                _icon(
                  GlobalVariable.urlImageTemplateBuyer + "ic_filter_temp.svg", 
                  (){onClickFilter();}, isActiveFilter),
              ],
            ),
          ),
          Positioned(
            top: GlobalVariable.ratioWidth(Get.context) * 14,
            right: GlobalVariable.ratioWidth(Get.context) * 12.5,
            child: isActiveFilter != null
            ? isActiveFilter 
              ? Container(
                  decoration: BoxDecoration(
                    color: Color(ListColor.colorRedTemplate),
                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 50)
                  ),
                  alignment: Alignment.center,
                  width: GlobalVariable.ratioWidth(Get.context) * 13.5,
                  height: GlobalVariable.ratioWidth(Get.context) * 13.5,
                  child: CustomText(
                    int.parse(jumlahFilter) > 99 ? "99" : jumlahFilter,
                    fontSize: 8,
                    color: Color(ListColor.colorWhite),
                  ),
                )
              : SizedBox.shrink()
            : SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  Widget _icon(String icon, Function onTap, bool active) {
    return GestureDetector(
      onTap: active == null 
      ? null
      : (){onTap();},
      child: SvgPicture.asset(
        icon,
        color: active == null 
        ? Color(ListColor.colorGreyTemplate6)
        : null,
        width: GlobalVariable.ratioWidth(Get.context) * 24,
        height: GlobalVariable.ratioWidth(Get.context) * 24,
      ),
    );
  }
}

