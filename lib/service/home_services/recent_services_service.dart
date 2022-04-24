import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qixer/model/recent_service_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/db/db_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;

class RecentServicesService with ChangeNotifier {
  var recentServiceMap = [];
  bool alreadySaved = false;

  fetchRecentService() async {
    if (recentServiceMap.isEmpty) {
      var connection = await checkConnection();
      if (connection) {
        //if connection is ok
        var response = await http.get(Uri.parse('$baseApi/latest-services'));

        if (response.statusCode == 201) {
          var data = RecentServiceModel.fromJson(jsonDecode(response.body));

          for (int i = 0; i < data.latestServices.length; i++) {
            var serviceImage;
            if (data.serviceImage.length > i) {
              serviceImage = data.serviceImage[i].imgUrl;
            } else {
              serviceImage = null;
            }

            int totalRating = 0;
            for (int j = 0;
                j < data.latestServices[i].reviewsForMobile.length;
                j++) {
              totalRating = totalRating +
                  data.latestServices[i].reviewsForMobile[j].rating!.toInt();
            }

            double averageRate = 0;

            if (data.latestServices[i].reviewsForMobile.isNotEmpty) {
              averageRate = (totalRating /
                  data.latestServices[i].reviewsForMobile.length);
            }

            setServiceList(
                data.latestServices[i].id,
                data.latestServices[i].title,
                data.latestServices[i].sellerForMobile.name,
                data.latestServices[i].price,
                averageRate,
                serviceImage,
                i);

            // print(averageRate);
          }
          notifyListeners();
        } else {
          //Something went wrong
          recentServiceMap.add('error');
          notifyListeners();
        }
      }
    } else {
      //already loaded from api
    }
  }

  setServiceList(serviceId, title, sellerName, price, rating, image, index) {
    recentServiceMap.add({
      'serviceId': serviceId,
      'title': title,
      'sellerName': sellerName,
      'price': price,
      'rating': rating,
      'image': image,
      'isSaved': false,
    });

    checkIfAlreadySaved(serviceId, title, sellerName, index);
  }

  checkIfAlreadySaved(serviceId, title, sellerName, index) async {
    var newListMap = recentServiceMap;
    alreadySaved = await DbService().checkIfSaved(serviceId, title, sellerName);
    newListMap[index]['isSaved'] = alreadySaved;
    recentServiceMap = newListMap;
    notifyListeners();
  }

  saveOrUnsave(int serviceId, String title, String image, int price,
      String sellerName, double rating, int index, BuildContext context) async {
    var newListMap = recentServiceMap;
    alreadySaved = await DbService().saveOrUnsave(
        serviceId, title, image, price, sellerName, rating, context);
    newListMap[index]['isSaved'] = alreadySaved;
    recentServiceMap = newListMap;
    notifyListeners();
  }
}
