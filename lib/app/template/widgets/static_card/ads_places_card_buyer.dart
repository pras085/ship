import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/app/modules/buyer/rules_buyer.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_model.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../global_variable.dart';

class AdsPlacesCardBuyer extends StatefulWidget {

  // use # to replace it with count data
  final String title;
  final SelectLocationBuyerModel location;
  final String layananID;
  final ADS_TYPE adsType;

  const AdsPlacesCardBuyer({ 
    Key key,
    @required this.title,
    @required this.location,
    @required this.layananID,
    @required this.adsType
  }) : super(key: key);

  @override
  State<AdsPlacesCardBuyer> createState() => _AdsPlacesCardBuyerState();
}

class _AdsPlacesCardBuyerState extends State<AdsPlacesCardBuyer> {

  var dataModelResponse = ResponseState<List>();
  int count = 0;

  @override
  void initState() {
    super.initState();
    fetchDataIklan();
  }

  Future<void> fetchDataIklan() async {
    try {
      dataModelResponse = ResponseState.loading();
      setState(() {});
      final response = await ApiBuyer(context: context).getDataLayanan({
        'LayananID': widget.layananID,
        'DistrictID': widget.location.districtID.toString(),
        'CityID': widget.location.cityID.toString(),
        'pageNow': "1",
        'limit': "2",
      });
      if (response != null) {
        if (response['Message']['Code'] == 200 && (response['Data'] is List)) {
          // convert json to object
          count = response['SupportingData']['RealCountData'];
          dataModelResponse = ResponseState.complete((response['Data'] as List).map((e) => e).toList());
          setState(() {});
        } else {
          // error
          if (response['Message'] != null && response['Message']['Text'] != null) {
            throw("${response['Message']['Text']}");
          }
          throw("failed to fetch data!");
        }
      } else {
        // error
        throw("failed to fetch data!");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      dataModelResponse = ResponseState.error("$error");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (c) {
        if (dataModelResponse.state == ResponseStates.COMPLETE) {
          final dataList = dataModelResponse.data;
          return dataList.isEmpty ? SizedBox.shrink() : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(widget.title.replaceAll("#", "${Utils.delimeter("$count")}") ?? "",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 14.4/12,
                withoutExtraPadding: true,
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 12,
              ),
              StaggeredGrid.count(
                crossAxisCount: widget.adsType == ADS_TYPE.product ? 2 : 1,
                mainAxisSpacing: GlobalVariable.ratioWidth(context) * 10,
                crossAxisSpacing: GlobalVariable.ratioWidth(context) * 16,
                children: [
                  for (int i=0;i<dataList.length;i++)
                    RulesBuyer.getCardDataKey(
                      kategoriId: "${dataList[i]['KategoriID']}",
                      subKategoriId: "${dataList[i]['SubKategoriID']}",
                      data: dataList[i],
                      layanan: "${dataList[i]['Kategori']['nama']}",
                      onFavorited: () {
                        // addToWishlist(i);
                      }
                    ),
                ],
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 10,
              ),
            ],
          );
        } else if (dataModelResponse.state == ResponseStates.ERROR) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(context) * 150,
            ),
            child: ErrorDisplayComponent("${dataModelResponse.exception}",
              onRefresh: () => fetchDataIklan(),
            ),
          );
        }
        return _loadingWidget(widget.adsType == ADS_TYPE.product);
      },
    );
  }

  Widget _loadingWidget(bool isProduct) {
    final int length = 2;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: GlobalVariable.ratioWidth(context) * 12,
            color: Colors.white,
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 12,
          ),
          StaggeredGrid.count(
            crossAxisCount: isProduct ? 2 : 1,
            mainAxisSpacing: GlobalVariable.ratioWidth(context) * 10,
            crossAxisSpacing: GlobalVariable.ratioWidth(context) * 16,
            children: [
              for (int i=0;i<length;i++)
                Material(
                  borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(context) * 8,
                  ),
                  color: Colors.white54,
                  child: Padding(
                    padding: EdgeInsets.all(
                      GlobalVariable.ratioWidth(context) * 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: GlobalVariable.ratioWidth(context) * 52,
                              height: GlobalVariable.ratioWidth(context) * 12,
                              color: Colors.white,
                            ),
                            SvgPicture.asset(
                              GlobalVariable.urlImageTemplateBuyer + 'ic_favorite_template.svg',
                              height: GlobalVariable.ratioWidth(context) * 20,
                              width: GlobalVariable.ratioWidth(context) * 20
                            ),
                          ],
                        ),
                        if (isProduct)
                          Container(
                            width: GlobalVariable.ratioWidth(context) * 140,
                            height: GlobalVariable.ratioWidth(context) * 82,
                            color: Colors.white,
                          )
                        else
                          Row(
                            children: [
                              Container(
                                width: GlobalVariable.ratioWidth(context) * 89,
                                height: GlobalVariable.ratioWidth(context) * 50,
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: GlobalVariable.ratioWidth(context) * 120,
                                      height: GlobalVariable.ratioWidth(context) * 14,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 8,
                        ),
                        Container(
                          width: double.infinity,
                          height: GlobalVariable.ratioWidth(context) * 28,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 8,
                        ),
                        Container(
                          width: double.infinity,
                          height: GlobalVariable.ratioWidth(context) * 28,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

}
