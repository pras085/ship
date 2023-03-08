import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';

import '../../../../global_variable.dart';
import 'dealer_brand_buyer_controller.dart';

class DealerBrandBuyer extends StatefulWidget {

  final DealerBrandModelBuyer data;
  final Function(DealerBrandModelBuyer data) onSelectedData;

  const DealerBrandBuyer({
    Key key,
    this.data,
    @required this.onSelectedData,
  }) : super(key: key);

  @override
  _DealerBrandBuyerState createState() => _DealerBrandBuyerState();
}

class _DealerBrandBuyerState extends State<DealerBrandBuyer> {

  DealerBrandModelBuyer _selectedData;
  // you have to 'put' the controller before use this component!
  final controller = Get.find<DealerBrandBuyerController>();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      _selectedData = widget.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: GlobalVariable.ratioWidth(context) * 16,
      ),
      margin: EdgeInsets.only(
        top: GlobalVariable.ratioWidth(context) * 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText("Cari Truk berdasarkan Merk",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
            height: 16.8/14,
            withoutExtraPadding: true,
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 16,
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 55,
            child: Obx(()
              {
                if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
                  final dataList = controller.dataModelResponse.value.data;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: dataList.length,
                    padding: EdgeInsets.only(
                      right: GlobalVariable.ratioWidth(context) * 16,
                    ),
                    separatorBuilder: (_, __) => SizedBox(
                      width: GlobalVariable.ratioWidth(context) * 10,
                    ),
                    itemBuilder: (c, i) {
                      final isSelected = _selectedData != null && _selectedData.brandID == dataList[i].brandID;
                      return Material(
                        color: isSelected
                        ? Color(0xFFD1E2FD)
                        : Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: isSelected ? Color(0xFF176CF7) : Color(0xFFA8A8A8),
                            width: GlobalVariable.ratioWidth(context) * 1,
                          ),
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedData = dataList[i];
                            });
                            widget.onSelectedData(dataList[i]);
                          },
                          child: CachedNetworkImage(
                            imageUrl: "${dataList[i].image}",
                            width: GlobalVariable.ratioWidth(context) * 53,
                            height: GlobalVariable.ratioWidth(context) * 53,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  );
                }
                else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
                  return ErrorDisplayComponent("${controller.dataModelResponse.value.exception}",
                    onRefresh: () => controller.fetchDataListBrand(),
                    isOnlyButton: true,
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DealerBrandModelBuyer {
  int brandID;
  String name;
  String image;

  DealerBrandModelBuyer({this.brandID, this.name, this.image});

  DealerBrandModelBuyer.fromJson(Map<String, dynamic> json) {
    brandID = json['BrandID'];
    name = json['Name'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BrandID'] = this.brandID;
    data['Name'] = this.name;
    data['Image'] = this.image;
    return data;
  }
}