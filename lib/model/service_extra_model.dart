// To parse this JSON data, do
//
//     final serviceExtraModel = serviceExtraModelFromJson(jsonString);

import 'dart:convert';

ServiceExtraModel serviceExtraModelFromJson(String str) =>
    ServiceExtraModel.fromJson(json.decode(str));

String serviceExtraModelToJson(ServiceExtraModel data) =>
    json.encode(data.toJson());

class ServiceExtraModel {
  ServiceExtraModel({
    required this.service,
    required this.serviceImage,
  });

  Service service;
  List<dynamic> serviceImage;

  factory ServiceExtraModel.fromJson(Map<String, dynamic> json) =>
      ServiceExtraModel(
        service: Service.fromJson(json["service"]),
        serviceImage: List<dynamic>.from(json["service_image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "service": service.toJson(),
        "service_image": List<dynamic>.from(serviceImage.map((x) => x)),
      };
}

class Service {
  Service({
    this.id,
    this.sellerId,
    this.title,
    this.price,
    this.tax,
    this.image,
    this.isServiceOnline,
    this.serviceCityId,
    required this.serviceAdditional,
    required this.serviceInclude,
    required this.serviceBenifit,
    required this.sellerForMobile,
    required this.serviceCity,
  });

  int? id;
  int? sellerId;
  String? title;
  var price;
  var tax;
  String? image;
  int? isServiceOnline;
  int? serviceCityId;
  List<ServiceAdditional> serviceAdditional;
  List<ServiceInclude> serviceInclude;
  List<ServiceBenifit> serviceBenifit;
  SellerForMobile sellerForMobile;
  ServiceCity? serviceCity;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        sellerId: int.parse(json["seller_id"].toString()=="null"?'0':json["seller_id"].toString()),
        title: json["title"],
        price: int.parse(json["price"].toString()=="null"?"0":json["price"].toString()),
        tax: int.parse(json["tax"].toString()=="null"?"0":json["tax"].toString()),
        image: json["image"],
        isServiceOnline: int.parse(json["is_service_online"].toString()=="null"?"0":json["is_service_online"].toString()),
        serviceCityId: int.parse(json["service_city_id"].toString()=="null"?"0":json["service_city_id"].toString()),
        serviceAdditional: List<ServiceAdditional>.from(
            json["service_additional"]
                .map((x) => ServiceAdditional.fromJson(x))),
        serviceInclude: List<ServiceInclude>.from(
            json["service_include"].map((x) => ServiceInclude.fromJson(x))),
        serviceBenifit: List<ServiceBenifit>.from(
            json["service_benifit"].map((x) => ServiceBenifit.fromJson(x))),
        sellerForMobile: SellerForMobile.fromJson(json["seller_for_mobile"]),
        serviceCity: json["service_city"] == null
            ? null
            : ServiceCity.fromJson(json["service_city"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "title": title,
        "price": price,
        "tax": tax,
        "image": image,
        "is_service_online": isServiceOnline,
        "service_city_id": serviceCityId,
        "service_additional":
            List<dynamic>.from(serviceAdditional.map((x) => x.toJson())),
        "service_include":
            List<dynamic>.from(serviceInclude.map((x) => x.toJson())),
        "service_benifit":
            List<dynamic>.from(serviceBenifit.map((x) => x.toJson())),
        "seller_for_mobile": sellerForMobile.toJson(),
        "service_city": serviceCity?.toJson(),
      };
}

class SellerForMobile {
  SellerForMobile({
    this.id,
    this.name,
    this.image,
    this.countryId,
  });

  int? id;
  String? name;
  String? image;
  int? countryId;

  factory SellerForMobile.fromJson(Map<String, dynamic> json) =>
      SellerForMobile(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        countryId: int.parse(json["country_id"].toString()=="null"?"0":json["country_id"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "country_id": countryId,
      };
}

class ServiceAdditional {
  ServiceAdditional({
    this.id,
    this.serviceId,
    this.sellerId,
    this.additionalServiceTitle,
    this.additionalServicePrice,
    this.additionalServiceQuantity,
    this.additionalServiceImage,
  });

  int? id;
  int? serviceId;
  int? sellerId;
  String? additionalServiceTitle;
  int? additionalServicePrice;
  int? additionalServiceQuantity;
  String? additionalServiceImage;

  factory ServiceAdditional.fromJson(Map<String, dynamic> json) =>
      ServiceAdditional(
        id: json["id"],
        serviceId: int.parse(json["service_id"].toString()=="null"?"0":json["service_id"].toString()),
        sellerId: int.parse(json["seller_id"].toString()=="null"?"0":json["seller_id"].toString()),
        additionalServiceTitle: json["additional_service_title"],
        additionalServicePrice: int.parse(json["additional_service_price"].toString()=="null"?"0":json["additional_service_price"].toString()),
        additionalServiceQuantity: int.parse(json["additional_service_quantity"].toString()=="null"?"0":json["additional_service_quantity"].toString()),
        additionalServiceImage: json["additional_service_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "seller_id": sellerId,
        "additional_service_title": additionalServiceTitle,
        "additional_service_price": additionalServicePrice,
        "additional_service_quantity": additionalServiceQuantity,
        "additional_service_image": additionalServiceImage,
      };
}

class ServiceBenifit {
  ServiceBenifit({
    this.id,
    this.serviceId,
    this.sellerId,
    this.benifits,
  });

  int? id;
  int? serviceId;
  int? sellerId;
  String? benifits;

  factory ServiceBenifit.fromJson(Map<String, dynamic> json) => ServiceBenifit(
        id: json["id"],
        serviceId: int.parse(json["service_id"].toString()=="null"?"0":json["service_id"].toString()),
        sellerId: int.parse(json["seller_id"].toString()=="null"?"0":json["seller_id"].toString()),
        benifits: json["benifits"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "seller_id": sellerId,
        "benifits": benifits,
      };
}

class ServiceCity {
  ServiceCity({
    this.id,
    this.serviceCity,
    this.countryId,
    this.status,
  });

  int? id;
  String? serviceCity;
  int? countryId;
  int? status;

  factory ServiceCity.fromJson(Map<String, dynamic> json) => ServiceCity(
        id: json["id"],
        serviceCity: json["service_city"],
        countryId: int.parse(json["country_id"].toString()=="null"?"0":json["country_id"].toString()),
        status: int.parse(json["status"].toString()=="null"?"0":json["status"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_city": serviceCity,
        "country_id": countryId,
        "status": status,
      };
}

class ServiceInclude {
  ServiceInclude({
    this.id,
    this.serviceId,
    this.sellerId,
    this.includeServiceTitle,
    this.includeServicePrice,
    this.includeServiceQuantity,
  });

  int? id;
  int? serviceId;
  int? sellerId;
  String? includeServiceTitle;
  var includeServicePrice;
  var includeServiceQuantity;

  factory ServiceInclude.fromJson(Map<String, dynamic> json) => ServiceInclude(
        id: json["id"],
        serviceId: int.parse(json["service_id"].toString()=="null"?"0":json["service_id"].toString()),
        sellerId: int.parse(json["seller_id"].toString()=="null"?"0":json["seller_id"].toString()),
        includeServiceTitle: json["include_service_title"],
        includeServicePrice: json["include_service_price"],
        includeServiceQuantity: json["include_service_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "seller_id": sellerId,
        "include_service_title": includeServiceTitle,
        "include_service_price": includeServicePrice,
        "include_service_quantity": includeServiceQuantity,
      };
}

class ServiceImageClass {
  ServiceImageClass({
    this.imageId,
    this.path,
    this.imgUrl,
    this.imgAlt,
  });

  int? imageId;
  String? path;
  String? imgUrl;
  dynamic imgAlt;

  factory ServiceImageClass.fromJson(Map<String, dynamic> json) =>
      ServiceImageClass(
        imageId: json["image_id"],
        path: json["path"],
        imgUrl: json["img_url"],
        imgAlt: json["img_alt"],
      );

  Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "path": path,
        "img_url": imgUrl,
        "img_alt": imgAlt,
      };
}
