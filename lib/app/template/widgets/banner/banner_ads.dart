import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerAds extends StatefulWidget {
  final String layananID;
  final String formMasterID;
  final String penempatanID;
  final double marginTop;
  final double marginBottom;

  const BannerAds({ this.layananID, this.formMasterID, this.penempatanID, this.marginTop = 0, this.marginBottom = 24 });

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  String bannerAds = "";
  String bannerTargetUrl;
  String userBannerId;

  @override
  void initState() {
    super.initState();
    getBannerAds();
  }

  Future getBannerAds() async {
    final response = await ApiBuyer(
      context: Get.context,
      isShowDialogError: false,
      isShowDialogLoading: false
    ).getBuyerBannerAds({
      'LayananID': widget.layananID,
      'FormMasterID': widget.formMasterID,
      'PenempatanID': widget.penempatanID,
      'isApp': "1"
    });

    if (response != null) {
      bannerAds = response['Data']['Gambar'] ?? "";
      bannerTargetUrl = response['Data']['TargetUrl'] ?? "-";
      userBannerId = response['Data']['UserBannerID'].toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = GlobalVariable.ratioWidth(context) * (widget.penempatanID == "4" ? 184 : 82);
    
    return bannerAds.isEmpty ? SizedBox.shrink() : GestureDetector(
      onTap: bannerTargetUrl == null || bannerTargetUrl == "-" ? null : () async {
        if (await canLaunch(bannerTargetUrl)) {
          await ApiBuyer(
            context: context,
            isShowDialogError: false,
            isShowDialogLoading: false
          ).updateCountDiaksesBannerAds({
            'UserBannerID': userBannerId
          });
          await launch(bannerTargetUrl, enableJavaScript: true);
        }
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.only(
            top: GlobalVariable.ratioWidth(context) * widget.marginTop,
            bottom: GlobalVariable.ratioWidth(context) * widget.marginBottom
          ),
          width: GlobalVariable.ratioWidth(context) * 328,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey, 
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 5),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            bannerAds,
            fit: BoxFit.fitWidth, 
            width: GlobalVariable.ratioWidth(context) * 328,
            height: height, 
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Image.asset(
                widget.penempatanID == "4" ? 'assets/mini_banner_ads.png' : 'assets/banner_ads.png',
                width: GlobalVariable.ratioWidth(context) * 328,
                height: height, 
                fit: BoxFit.cover,
              );
            },
            errorBuilder: (context, child, stackTrace) {
              return Image.asset(
                widget.penempatanID == "4" ? 'assets/mini_banner_ads.png' : 'assets/banner_ads.png',
                width: GlobalVariable.ratioWidth(context) * 328,
                height: height, 
                fit: BoxFit.cover,
              );
            },
          )
        ),
      ),
    );
  }
}