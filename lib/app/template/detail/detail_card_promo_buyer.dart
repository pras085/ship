import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class DetailCardPromoBuyer extends StatelessWidget {
  final Function(int i) onCardTap;
  final Function onShowAllTap;
  final List cardList;

  DetailCardPromoBuyer({
    Key key,
    @required this.cardList,
    @required this.onCardTap,
    @required this.onShowAllTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: GlobalVariable.ratioWidth(context) * 217,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(context) * 16,
            ),
            child: Row(
              children: [
                CustomText(
                  "Pilihan Promo Hari Ini",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  withoutExtraPadding: true,
                ),
                Spacer(),
                GestureDetector(
                  onTap: onShowAllTap,
                  child: CustomText(
                    "Lihat Semua",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    withoutExtraPadding: true,
                    color: Color(ListColor.colorBlueTemplate1),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(context) * 16,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cardList.length,
                padding: EdgeInsets.only(
                  right: GlobalVariable.ratioWidth(context) * 16,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onCardTap(index),
                    child: Container(
                      width: GlobalVariable.ratioWidth(context) * 156,
                      height: GlobalVariable.ratioWidth(context) * 182,
                      margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(context) * 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(context) * 10,
                        vertical: GlobalVariable.ratioWidth(context) * 14,
                      ),
                      decoration: BoxDecoration(
                        color: Color(ListColor.colorWhiteTemplate),
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 9),
                        border: Border.all(
                          width: GlobalVariable.ratioWidth(context) * 1,
                          color: Color(ListColor.colorGreyTemplate2),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            offset: Offset(GlobalVariable.ratioWidth(context) * 0, GlobalVariable.ratioWidth(context) * 10),
                            blurRadius: GlobalVariable.ratioWidth(context) * 13,
                            spreadRadius: GlobalVariable.ratioWidth(context) * 0,
                            color: Color(ListColor.colorShadowTemplate1).withOpacity(0.15),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: GlobalVariable.ratioWidth(context) * 118,
                            width: GlobalVariable.ratioWidth(context) * 136,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 5),
                              child: CachedNetworkImage(
                                imageUrl: cardList[index]['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                          CustomText(
                            cardList[index]['name'],
                            withoutExtraPadding: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DetailCardBrosurBuyer extends StatelessWidget {
  final Function(int i) onCardTap;
  final Function onShowAllTap;
  final List cardList;

  DetailCardBrosurBuyer({
    Key key,
    @required this.cardList,
    @required this.onCardTap,
    @required this.onShowAllTap,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: GlobalVariable.ratioWidth(context) * 187,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(context) * 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  "Brosur",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  withoutExtraPadding: true,
                ),
                Spacer(),
                GestureDetector(
                  onTap: onShowAllTap,
                  child: CustomText(
                    "Lihat Semua",
                    fontWeight: FontWeight.w600,
                    withoutExtraPadding: true,
                    color: Color(ListColor.colorBlueTemplate1),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(context) * 16,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  right: GlobalVariable.ratioWidth(context) * 16,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: cardList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onCardTap(index),
                    child: Container(
                      width: GlobalVariable.ratioWidth(context) * 156,
                      height: GlobalVariable.ratioWidth(context) * 152,
                      margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(context) * 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(context) * 10,
                        vertical: GlobalVariable.ratioWidth(context) * 14,
                      ),
                      decoration: BoxDecoration(
                        color: Color(ListColor.colorWhiteTemplate),
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 10),
                        border: Border.all(
                          width: GlobalVariable.ratioWidth(context) * 1,
                          color: Color(ListColor.colorGreyTemplate2),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            offset: Offset(GlobalVariable.ratioWidth(context) * 0, GlobalVariable.ratioWidth(context) * 10),
                            blurRadius: GlobalVariable.ratioWidth(context) * 13,
                            spreadRadius: GlobalVariable.ratioWidth(context) * 0,
                            color: Color(ListColor.colorShadowTemplate1).withOpacity(0.15),
                          ),
                        ],
                      ),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        padding: EdgeInsets.zero,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: GlobalVariable.ratioWidth(context) * 136,
                              height: GlobalVariable.ratioWidth(context) * 82,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 5),
                                child: CachedNetworkImage(
                                  imageUrl: cardList[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                            CustomText(
                              cardList[index]['name'],
                              withoutExtraPadding: true,
                              fontWeight: FontWeight.w600,
                              maxLines: 2,
                              height: 16.8/14,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
