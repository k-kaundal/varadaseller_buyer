import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersService with ChangeNotifier {
  bool markLoading = false;

  setMarkLoadingStatus(bool status) {
    markLoading = status;
    notifyListeners();
  }

//==========>
//=======>
  completeOrder(BuildContext context, {required orderId}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (!connection) return;

    setMarkLoadingStatus(true);

    var data = jsonEncode({'order_id': orderId});

    var response = await http.post(
        Uri.parse('$baseApi/user/order/request/status/complete/approve'),
        headers: header,
        body: data);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      OthersHelper().showToast(decodedData['msg'], Colors.black);

      await Provider.of<OrderDetailsService>(context, listen: false)
          .fetchOrderDetails(orderId, context, isFromOrderComplete: true);

      setMarkLoadingStatus(false);
    } else {
      setMarkLoadingStatus(false);
      if (decodedData.containsKey('msg')) {
        OthersHelper().showToast(decodedData['msg'], Colors.black);
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }

  //Decline order
  //===========>

  declineOrder(BuildContext context,
      {required orderId, required sellerId, required declineReason}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (!connection) return;

    setMarkLoadingStatus(true);

    var data = jsonEncode({
      'order_id': orderId,
      'seller_id': sellerId,
      'decline_reason': declineReason
    });

    var response = await http.post(
        Uri.parse('$baseApi/user/order/request/status/complete/decline'),
        headers: header,
        body: data);

    final decodedData = jsonDecode(response.body);

    print(response.body);

    print(response.statusCode);

    if (response.statusCode == 404) {
      OthersHelper().showToast(decodedData['msg'], Colors.black);

      await Provider.of<OrderDetailsService>(context, listen: false)
          .fetchOrderDetails(orderId, context, isFromOrderComplete: true);

      setMarkLoadingStatus(false);

      Navigator.pop(context);
    } else {
      setMarkLoadingStatus(false);

      if (decodedData.containsKey('errors')) {
        OthersHelper().showToast(
            decodedData['errors']['decline_reason'][0], Colors.black);
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }

  // decline history
  // =====================>

  var declineHistory;

  bool loadingDeclineHistory = false;

  setLoadingDeclineHistoryStatus(bool status) {
    loadingDeclineHistory = status;
    notifyListeners();
  }

  fetchDeclineHistory(BuildContext context, {required orderId}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      // "Accept": "application/json",
      // "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (!connection) return;

    setLoadingDeclineHistoryStatus(true);

    var response = await http.get(
      Uri.parse(
          '$baseApi/user/order/request/complete/decline/history?order_id=$orderId'),
      headers: header,
    );

    print(response.body);
    print(response.statusCode);

    setLoadingDeclineHistoryStatus(false);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      declineHistory = decodedData;
      notifyListeners();
    } else {
      //error

      declineHistory = null;
      notifyListeners();
    }
  }
}
