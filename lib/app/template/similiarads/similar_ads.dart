import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';


class SimilarAds extends StatelessWidget {
  final List<dynamic> numbers = [[1, 'aw'], [2, 'www'], [3, 'awawa']];
  // final String urlimg;
  // final String headertext;
  // final List carrier;

  // const SimilarAds({
  //   @required this.urlimg,
  //   @required this.headertext,
  //   @required this.carrier
  // });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: GlobalVariable.ratioWidth(context) * 16,
            ),
            Padding(
              padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(context) * 16),
              child: CustomText('Iklan Serupa', fontSize: 16, fontWeight: FontWeight.w600,),
            ),
            Container(
              height: GlobalVariable.ratioWidth(context) * 283,
              width: GlobalVariable.ratioWidth(context) * 360,
              // color: Colors.amberAccent,
              child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              height: MediaQuery.of(context).size.height * 0.35,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: numbers.length, itemBuilder: (context, index) {
                    return Container(
                      width: GlobalVariable.ratioWidth(context) * 156,
                      child: Card(
                        color: Colors.blue,
                        child: Container(
                          child: Center(child: Text(numbers[index][0].toString(), style: TextStyle(color: Colors.white, fontSize: 36.0),)),
                        ),
                      ),
                    );
              }),
            ),
            ),
          ],
        ),
      ),
    );
  }
}