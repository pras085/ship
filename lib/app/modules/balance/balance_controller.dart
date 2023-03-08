import 'package:get/get.dart';
import 'package:muatmuat/app/modules/balance/transaction_model.dart';

class BalanceController extends GetxController {

  var listTransaction = List<TransactionModel>().obs;  
  
  @override
  void onInit() {
    listTransaction.clear();
    listTransaction.add(TransactionModel(title: "Apel 100kg", date: DateTime.now(), cost: 2000, description: "WOW", status: "Paid"));
    listTransaction.add(TransactionModel(title: "Tomat 200kg", date: DateTime.now(), cost: 2000, description: "WOW", status: "Paid"));
    listTransaction.add(TransactionModel(title: "Aqua 250mL 10 box", date: DateTime.now(), cost: 2000, description: "WOW", status: "Paid"));
    listTransaction.add(TransactionModel(title: "Oronamin C 20 crate", date: DateTime.now(), cost: 2000, description: "WOW", status: "Paid"));
    listTransaction.add(TransactionModel(title: "Pocari Sweat 1L 50 box", date: DateTime.now(), cost: 2000000, description: "WOW", status: "Paid"));
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

}