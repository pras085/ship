import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/balance/balance_controller.dart';
import 'package:muatmuat/app/modules/balance/transaction_model.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class BalanceView extends GetView<BalanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText('Balance'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: CustomText(
                  'Balance',
                  fontSize: 18,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CustomText(
                  'RP 250.000,00',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 20),
                child: CustomText(
                  'Transaction History',
                  fontSize: 18,
                ),
              ),
              // Obx(()=>
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.listTransaction.length,
                    itemBuilder: (context, index) {
                      var transaction = controller.listTransaction.value[index];
                      return transactionView(transaction, index);
                      // return Text('1');
                    }),
              )
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionView(TransactionModel transaction, int index) {
    final numberFormat = new NumberFormat("#,##0.00", "en_US");
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(ListColor.color4)),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.all(20),
      margin: index == (controller.listTransaction.length - 1)
          ? null
          : EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                      child: CustomText(transaction.title,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: CustomText(
                        "Rp ${numberFormat.format(transaction.cost)}",
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText("Status: ${transaction.status}",
                        fontSize: 17, fontWeight: FontWeight.w600)),
              )
            ]),
          ),
          Container(
              margin: EdgeInsets.only(left: 20),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Color(ListColor.color4),
              ))
        ],
      ),
    );
  }
}
