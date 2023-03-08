import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:muatmuat/app/network/api_helper.dart';

class ApiSubscription {
  final BuildContext context;
  final bool isShowDialogLoading;
  final bool isShowDialogError;
  final bool isDebugGetResponse;

  ApiSubscription(
      {this.context,
      this.isShowDialogLoading = true,
      this.isShowDialogError = true,
      this.isDebugGetResponse = false});

  Future getDetailOrderByShipper(Map<String, dynamic> body) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_detail_order_by_shipper", body);
  }

  Future getDetailOrderSubusersByShipper(Map<String, dynamic> body) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_detail_order_subusers_by_shipper",
            body);
  }

  Future fetchPaketLangganan() async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_paket_langganan",
            {"Role": "2", "SuperMenuID": "1"});
  }

  Future getCheckSegmented(
      {@required String role, @required String roleUserId}) async {
    var body = {
      "Role": role,
      "RoleUserID": roleUserId,
    };
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/check_segmented_user_bf", body);
  }

  Future fetchPaketLanggananSubuser(
      int paketLanggananID, String usedPaketSubuser,
      {bool nextLangganan = false,
      bool fromBigfleet = true,
      int detailPaketSubuser}) async {
    var body = {
      "PaketLanggananID": paketLanggananID.toString(),
      "UsePaketID": usedPaketSubuser,
      "LimitMode": fromBigfleet.toString(),
      "Role": "2",
      "SuperMenuID": "1",
      "IsNext": nextLangganan ? "1" : "0"
    };
    if (detailPaketSubuser != null) {
      body["PaketID"] = detailPaketSubuser.toString();
    }
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_paket_sub_users", body);
  }

  Future getTimelineSubscription(Map<String, dynamic> body) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_timeline_subscription", body);
  }

  Future getDashboardSubscriptionShipper() async {
    var body = Map<String, dynamic>();
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_dashboard_subscription_shipper", body);
  }

  Future getRiwayatLangganan(Map<String, dynamic> body) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_riwayat_langganan", body);
  }

  Future getRiwayatSubUsers(Map<String, dynamic> body) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_riwayat_sub_users", body);
  }

  Future fetchListSubscriptionVoucher(int isFirst, String paketID,
      {String search = ""}) async {
    var body = {"IsFirst": isFirst.toString(), "PaketID": paketID, "q": search};
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_voucher", body);
  }

  Future checkSubscriptionVoucher(
    List paketID,
    String voucherID,
  ) async {
    var body = {
      "Role": "2",
      "VoucherID": voucherID,
      "trans": jsonEncode(paketID)
    };
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/check_voucher", body);
  }

  Future doAddSubscription(List paketSubuser, String paketID, String voucherID,
      String paymentID) async {
    var body = {
      "PaketLanggananID": paketID,
      "VoucherID": voucherID.isEmpty ? "0" : voucherID,
      "PaymentID": paymentID
    };
    if (paketSubuser.length > 0) body["trans"] = jsonEncode(paketSubuser);
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/doAddOrderSubscriptionBFByShipper", body);
  }

  Future getPeriodePaketSubuser(String subscriptionID, String paketID) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_periode_paket_subusers", {
      "Role": "2",
      "SubscriptionID": subscriptionID,
      "PaketID": paketID
    });
  }

  Future cekPeriodePaketSubuser(
      String subscriptionID, String paketID, String tanggal) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_periode_subscription", {
      "Role": "2",
      "SubscriptionID": subscriptionID,
      "PaketID": paketID,
      "Tanggal": tanggal
    });
  }

  Future doAddSubuser(List paketSubuser, String subscriptionID,
      String voucherID, String paymentID, int isNext) async {
    var body = {
      "trans": jsonEncode(paketSubuser),
      "VoucherID": voucherID.isEmpty ? "0" : voucherID,
      "PaymentID": paymentID,
      "SubscriptionID": subscriptionID,
      "IsNext": isNext.toString()
    };
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/doAddOrderSubscriptionSubUsersByShipper",
            body);
  }

  Future getPacketSubscriptionActiveByShipper(Map<String, dynamic> body) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_packet_subscription_active_by_shipper",
            body);
  }

  Future getPacketSubscriptionHistoryByShipper(
      Map<String, dynamic> body) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url +
                "backend/get_packet_subscription_history_by_shipper",
            body);
  }

  Future getListPaymentMethod() async {
    print('Debug: ' + 'before getListMetodePembayaran');
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_payment_method", null);
  }

  Future getListStepPayment() async {
    print('Debug: ' + 'before getListMetodePembayaran');
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "base/get_step_payment", null);
  }

  Future doUpdatePaymentSubscription(
      String orderID, String type, String paymentID) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/doUpdatePaymentMethodForShipper",
            {"OrderID": orderID, "Type": type, "PaymentID": paymentID});
  }

  Future doUpdateStatusOrderSubscription(String orderID) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/doPaymentSubscriptionBFByShipper",
            {"OrderID": orderID});
  }

  Future doUpdateStatusOrderSubuser(String orderID, String isNext) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/doPaymentSubscriptionSubUsersByShipper",
            {"OrderID": orderID, "IsNext": isNext});
  }

  Future doCancelOrderSubscription(String orderID, String notes) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/doCancelOrderSubscriptionBFByShipper",
            {"OrderID": orderID, "Notes": notes});
  }

  Future doCancelOrderSubuser(String orderID, String notes) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url +
                "backend/doCancelOrderSubscriptionSubUsersByShipper",
            {"OrderID": orderID, "Notes": notes});
  }

  Future fetchPDFLink(String url) async {
    var response = await http
        .get(url)
        .timeout(Duration(seconds: ApiHelper.requestTimeOutSecond));
    return ApiHelper(context: context, isShowDialogLoading: false)
        .getResponseFromURLMuatMuat(response, true);
  }

  Future fetchTermCondition({String type = "general"}) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuat(
            ApiHelper.url + "api/terms_condition", {'App': "1", 'Type': type});
  }
}
