// To parse this JSON data, do
//
//     final orderExtraModel = orderExtraModelFromJson(jsonString);

import 'dart:convert';

OrderExtraModel orderExtraModelFromJson(String str) =>
    OrderExtraModel.fromJson(json.decode(str));

String orderExtraModelToJson(OrderExtraModel data) =>
    json.encode(data.toJson());

class OrderExtraModel {
  OrderExtraModel({
    required this.extraServiceList,
  });

  List<ExtraServiceList> extraServiceList;

  factory OrderExtraModel.fromJson(Map<String, dynamic> json) =>
      OrderExtraModel(
        extraServiceList: List<ExtraServiceList>.from(json["extra_service_list"]
            .map((x) => ExtraServiceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "extra_service_list":
            List<dynamic>.from(extraServiceList.map((x) => x.toJson())),
      };
}

class ExtraServiceList {
  ExtraServiceList(
      {this.id,
      this.orderId,
      this.title,
      this.quantity,
      this.price,
      this.tax,
      this.subTotal,
      this.total,
      this.status});

  int? id;
  int? orderId;
  String? title;
  int? quantity;
  int? price;
  double? tax;
  int? subTotal;
  double? total;
  var status;

  factory ExtraServiceList.fromJson(Map<String, dynamic> json) =>
      ExtraServiceList(
          id: json["id"],
          orderId: int.parse(json["order_id"].toString()=="null"?"0":json["order_id"].toString()),
          title: json["title"],
          quantity: int.parse(json["quantity"].toString()=="null"?"0":json["quantity"].toString()),
          price: int.parse(json["price"].toString()=="null"?"0":json["price"].toString()),
          tax: int.parse(json["tax"].toString()=="null"?"0":json["tax"].toString()).toDouble(),
          subTotal: int.parse(json["sub_total"].toString()=="null"?"0":json["sub_total"].toString()),
          total: int.parse(json["total"].toString()=="null"?"0":json["total"].toString()).toDouble(),
          status: int.parse(json["status"].toString()=="null"?"0":json["status"].toString()));

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "title": title,
        "quantity": quantity,
        "price": price,
        "tax": tax,
        "sub_total": subTotal,
        "total": total,
        "status": status
      };
}
