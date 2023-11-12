// To parse this JSON data, do
//
//     final topServiceModel = topServiceModelFromJson(jsonString);

import 'dart:convert';

TopServiceModel topServiceModelFromJson(String str) =>
    TopServiceModel.fromJson(json.decode(str));

String topServiceModelToJson(TopServiceModel data) =>
    json.encode(data.toJson());

class TopServiceModel {
  TopServiceModel({
    required this.topServices,
    required this.serviceImage,
    required this.reviewerImage,
  });

  List<TopService> topServices;
  List<Image?> serviceImage;
  List<dynamic> reviewerImage;

  factory TopServiceModel.fromJson(Map<String, dynamic> json) =>
      TopServiceModel(
        topServices: List<TopService>.from(
            json["top_services"].map((x) => TopService.fromJson(x))),
        serviceImage: List<Image?>.from(json["service_image"].map((x) {
          if (x is List) {
            return null;
          } else {
            return Image.fromJson(x);
          }
        })),
        reviewerImage: List<dynamic>.from(json["reviewer_image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "top_services": List<dynamic>.from(topServices.map((x) => x.toJson())),
        "service_image":
            List<dynamic>.from(serviceImage.map((x) => x?.toJson())),
        "reviewer_image": List<dynamic>.from(reviewerImage.map((x) => x)),
      };
}

class Image {
  Image({
    this.imageId,
    this.path,
    this.imgUrl,
    this.imgAlt,
  });

  int? imageId;
  String? path;
  String? imgUrl;
  dynamic imgAlt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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

class TopService {
  TopService({
    this.id,
    this.title,
    this.image,
    this.price,
    this.sellerId,
    required this.reviewsForMobile,
    required this.sellerForMobile,
  });

  int? id;
  String? title;
  String? image;
  var price;
  int? sellerId;
  List<ReviewsForMobile> reviewsForMobile;
  SellerForMobile sellerForMobile;

  factory TopService.fromJson(Map<String, dynamic> json) => TopService(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        price: json["price"],
        sellerId: int.parse(json["seller_id"].toString() == "null"
            ? "0"
            : json["seller_id"].toString()),
        reviewsForMobile: List<ReviewsForMobile>.from(json["reviews_for_mobile"]
            .map((x) => ReviewsForMobile.fromJson(x))),
        sellerForMobile: SellerForMobile.fromJson(json["seller_for_mobile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "price": price,
        "seller_id": sellerId,
        "reviews_for_mobile":
            List<dynamic>.from(reviewsForMobile.map((x) => x.toJson())),
        "seller_for_mobile": sellerForMobile.toJson(),
      };
}

class ReviewsForMobile {
  ReviewsForMobile({
    this.id,
    this.serviceId,
    this.rating,
    this.message,
    this.buyerId,
    required this.buyerForMobile,
  });

  int? id;
  int? serviceId;
  int? rating;
  String? message;
  int? buyerId;
  BuyerForMobile? buyerForMobile;

  factory ReviewsForMobile.fromJson(Map<String, dynamic> json) =>
      ReviewsForMobile(
        id: json["id"],
        serviceId: int.parse(json["service_id"].toString() == "null"
            ? "0"
            : json["service_id"].toString()),
        rating: int.parse(json["rating"].toString() == "null"
            ? "0"
            : json["rating"].toString()),
        message: json["message"],
        buyerId: int.parse(json["buyer_id"].toString() == "null"
            ? "0"
            : json["buyer_id"].toString()),
        buyerForMobile: BuyerForMobile.fromJson(json["buyer_for_mobile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "rating": rating,
        "message": message,
        "buyer_id": buyerId,
        "buyer_for_mobile": buyerForMobile?.toJson(),
      };
}

class BuyerForMobile {
  BuyerForMobile({
    this.id,
    this.image,
  });

  int? id;
  String? image;

  factory BuyerForMobile.fromJson(Map<String, dynamic>? json) => BuyerForMobile(
        id: json?["id"],
        image: json?["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
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
        countryId: int.parse(json["country_id"].toString() == "null"
            ? "0"
            : json["country_id"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "country_id": countryId,
      };
}
