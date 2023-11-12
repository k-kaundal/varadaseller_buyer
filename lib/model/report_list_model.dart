// To parse this JSON data, do
//
//     final reportListModel = reportListModelFromJson(jsonString);

import 'dart:convert';

ReportListModel reportListModelFromJson(String str) =>
    ReportListModel.fromJson(json.decode(str));

String reportListModelToJson(ReportListModel data) =>
    json.encode(data.toJson());

class ReportListModel {
  ReportListModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory ReportListModel.fromJson(Map<String, dynamic> json) =>
      ReportListModel(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: int.parse(json["from"].toString()=="null"?"0":json["from"].toString()),
        lastPage: int.parse(json["last_page"].toString()=="null"?"0":json["last_page"].toString()),
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: int.parse(json["per_page"].toString()=="null"?"0":json["per_page"].toString()),
        prevPageUrl: json["prev_page_url"],
        to: int.parse(json["to"].toString()=="null"?"0":json["to"].toString()),
        total: int.parse(json["total"].toString()=="null"?"0":json["total"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    required this.id,
    this.orderId,
    this.serviceId,
    this.sellerId,
    this.buyerId,
    this.reportFrom,
    this.reportTo,
    required this.status,
    this.report,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int? orderId;
  int? serviceId;
  int? sellerId;
  int? buyerId;
  String? reportFrom;
  String? reportTo;
  int status;
  String? report;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        orderId: int.parse(json["order_id"].toString()=="null"?"0":json["order_id"].toString()),
        serviceId: int.parse(json["service_id"].toString()=="null"?"0":json["service_id"].toString()),
        sellerId: int.parse(json["seller_id"].toString()=="null"?"0":json["seller_id"].toString()),
        buyerId: int.parse(json["buyer_id"].toString()=="null"?"0":json["buyer_id"].toString()),
        reportFrom: json["report_from"],
        reportTo: json["report_to"],
        status: int.parse(json["status"].toString()=="null"?"0":json["status"].toString()),
        report: json["report"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "service_id": serviceId,
        "seller_id": sellerId,
        "buyer_id": buyerId,
        "report_from": reportFrom,
        "report_to": reportTo,
        "status": status,
        "report": report,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
