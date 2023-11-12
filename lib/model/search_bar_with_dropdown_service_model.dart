// To parse this JSON data, do
//
//     final searchBarWithDropdownServiceModel = searchBarWithDropdownServiceModelFromJson(jsonString);

import 'dart:convert';

SearchBarWithDropdownServiceModel searchBarWithDropdownServiceModelFromJson(
        String str) =>
    SearchBarWithDropdownServiceModel.fromJson(json.decode(str));

String searchBarWithDropdownServiceModelToJson(
        SearchBarWithDropdownServiceModel data) =>
    json.encode(data.toJson());

class SearchBarWithDropdownServiceModel {
  SearchBarWithDropdownServiceModel({
    required this.services,
    required this.serviceImage,
  });

  List<Service> services;
  List<ServiceImage?> serviceImage;

  factory SearchBarWithDropdownServiceModel.fromJson(
          Map<String, dynamic> json) =>
      SearchBarWithDropdownServiceModel(
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
        serviceImage: List<ServiceImage?>.from(json["service_image"].map((x) {
          if (x is List) {
            return null;
          } else {
            return ServiceImage.fromJson(x);
          }
        })),
      );

  Map<String, dynamic> toJson() => {
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "service_image":
            List<dynamic>.from(serviceImage.map((x) => x?.toJson())),
      };
}

class ServiceImage {
  ServiceImage({
    this.imageId,
    this.path,
    this.imgUrl,
    this.imgAlt,
  });

  int? imageId;
  String? path;
  String? imgUrl;
  dynamic imgAlt;

  factory ServiceImage.fromJson(Map<String, dynamic> json) => ServiceImage(
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

class Service {
  Service({
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.sellerId,
    this.serviceCityId,
    this.title,
    this.slug,
    this.description,
    this.image,
    this.imageGallery,
    this.video,
    this.status,
    this.isServiceOn,
    this.price,
    this.onlineServicePrice,
    this.deliveryDays,
    this.revision,
    this.isServiceOnline,
    this.tax,
    this.view,
    this.soldCount,
    this.featured,
    required this.sellerForMobile,
    required this.reviewsForMobile,
    required this.serviceCity,
  });

  int? id;
  int? categoryId;
  int? subcategoryId;
  int? sellerId;
  int? serviceCityId;
  String? title;
  String? slug;
  String? description;
  String? image;
  String? imageGallery;
  String? video;
  int? status;
  int? isServiceOn;
  double? price;
  int? onlineServicePrice;
  int? deliveryDays;
  int? revision;
  int? isServiceOnline;
  double? tax;
  int? view;
  int? soldCount;
  int? featured;

  SellerForMobile sellerForMobile;
  List<ReviewsForMobile> reviewsForMobile;
  ServiceCityClass? serviceCity;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        categoryId: int.parse(json["category_id"].toString()=="null"?"0":json["category_id"].toString()),
        subcategoryId: int.parse(json["subcategory_id"].toString()=="null"?"0":json["subcategory_id"].toString()),
        sellerId: int.parse(json["seller_id"].toString()=="null"?"0":json["seller_id"].toString()),
        serviceCityId: int.parse(json["service_city_id"].toString()=="null"?"0":json["service_city_id"].toString()),
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        imageGallery: json["image_gallery"],
        video: json["video"],
        status: int.parse(json["status"].toString()=="null"?"0":json["status"].toString()),
        isServiceOn: int.parse(json["is_service_on"].toString()=="null"?"0":json["is_service_on"].toString()),
        price: int.parse(json["price"].toString()=="null"?"0":json["price"].toString()).toDouble(),
        onlineServicePrice: int.parse(json["online_service_price"].toString()=="null"?"0":json["online_service_price"].toString()),
        deliveryDays: int.parse(json["delivery_days"].toString()=="null"?"0":json["delivery_days"].toString()),
        revision: int.parse(json["revision"].toString()=="null"?"0":json["revision"].toString()),
        isServiceOnline: int.parse(json["is_service_online"].toString()=="null"?"0":json["is_service_online"].toString()),
        tax: int.parse(json["tax"].toString()=="null"?"0":json["tax"].toString()).toDouble(),
        view: int.parse(json["view"].toString()=="null"?"0":json["view"].toString()),
        soldCount: int.parse(json["sold_count"].toString()=="null"?"0":json["sold_count"].toString()),
        featured: int.parse(json["featured"].toString()=="null"?"0":json["featured"].toString()),
        sellerForMobile: SellerForMobile.fromJson(json["seller_for_mobile"]),
        reviewsForMobile: List<ReviewsForMobile>.from(json["reviews_for_mobile"]
            .map((x) => ReviewsForMobile.fromJson(x))),
        serviceCity: json["service_city"] == null
            ? null
            : ServiceCityClass.fromJson(json["service_city"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "seller_id": sellerId,
        "service_city_id": serviceCityId,
        "title": title,
        "slug": slug,
        "description": description,
        "image": image,
        "image_gallery": imageGallery,
        "video": video,
        "status": status,
        "is_service_on": isServiceOn,
        "price": price,
        "online_service_price": onlineServicePrice,
        "delivery_days": deliveryDays,
        "revision": revision,
        "is_service_online": isServiceOnline,
        "tax": tax,
        "view": view,
        "sold_count": soldCount,
        "featured": featured,
        "seller_for_mobile": sellerForMobile.toJson(),
        "reviews_for_mobile":
            List<dynamic>.from(reviewsForMobile.map((x) => x.toJson())),
        "service_city": serviceCity!.toJson(),
      };
}

class ReviewsForMobile {
  ReviewsForMobile({
    this.id,
    this.serviceId,
    this.rating,
    this.message,
    this.buyerId,
  });

  int? id;
  int? serviceId;
  int? rating;
  String? message;
  int? buyerId;

  factory ReviewsForMobile.fromJson(Map<String, dynamic> json) =>
      ReviewsForMobile(
        id: json["id"],
        serviceId: int.parse(json["service_id"].toString()=="null"?"0":json["service_id"].toString()),
        rating: int.parse(json["rating"].toString()=="null"?"0":json["rating"].toString()),
        message: json["message"],
        buyerId: int.parse(json["buyer_id"].toString()=="null"?"0":json["buyer_id"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "rating": rating,
        "message": message,
        "buyer_id": buyerId,
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

class ServiceCityClass {
  ServiceCityClass({
    this.id,
    this.serviceCity,
    this.countryId,
    this.status,
  });

  int? id;
  String? serviceCity;
  int? countryId;
  int? status;

  factory ServiceCityClass.fromJson(Map<String, dynamic> json) =>
      ServiceCityClass(
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
