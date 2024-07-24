// To parse this JSON data, do
//
//     final redeemModel = redeemModelFromJson(jsonString);

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';

RedeemModel redeemModelFromJson(String str) =>
    RedeemModel.fromJson(json.decode(str));

String redeemModelToJson(RedeemModel data) => json.encode(data.toJson());

class RedeemModel {
  int? id;
  int? productId;
  int? state;
  String? type;
  int? discountNumber;
  String? discountType;
  int? count;
  int? expiredTime;
  String? voucherImage;
  DateTime? createdAt;
  DateTime? rulesExtendTimeUpdateAt;
  List<Rule>? rules;
  int? rulesExtendTime;
  Provider? provider;
  String? restaurantName;
  String? instagramName;

  RedeemModel(
      {this.id,
        this.rulesExtendTimeUpdateAt,
        this.restaurantName,
        this.instagramName,
        this.productId,
        this.state,
        this.type,
        this.discountNumber,
        this.discountType,
        this.count,
        this.expiredTime,
        this.voucherImage,
        this.createdAt,
        this.rules,
        this.rulesExtendTime,
        this.provider});

  factory RedeemModel.fromJson(Map<String, dynamic> json) => RedeemModel(
      rulesExtendTimeUpdateAt: json["rules_extend_time_updated_at"] == null
          ? null
          : DateFormat('yyyy-MM-ddThh:mm:ss')
          .parse(json["rules_extend_time_updated_at"] + "Z", true)
          .toLocal(),
      instagramName: json['instagram_name'],
      restaurantName: json['restaurant_name'],
      rulesExtendTime: json['rules_extend_time'],
      id: json["id"],
      productId: json["product_id"] ?? json["production_id"],
      state: json["state"],
      type: json["type"],
      discountNumber: json["discount_number"] != null
          ? double.parse(json["discount_number"].toString()).round()
          : null,
      discountType: json["discount_type"],
      count: json["count"],
      expiredTime: json["expired_time"],
      voucherImage: json["voucher_image"],
      createdAt: json["created_at"] == null
          ? (json["createdAt"] == null
          ? null
          : DateFormat('yyyy-MM-ddThh:mm:SS')
          .parse(json["createdAt"] + "Z", true)
          .toLocal())
          : DateFormat('yyyy-MM-ddThh:mm:SS')
          .parse(json["created_at"] + "Z", true)
          .toLocal(),
      rules: json["rules"] == null
          ? []
          : List<Rule>.from(json["rules"]!.map((x) => Rule.fromJson(x))),
      provider: json["provider"] == null ? null : Provider.fromJson(json["provider"])) ;

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "state": state,
    "type": type,
    "discount_number": discountNumber,
    "discount_type": discountType,
    "count": count,
    "expired_time": expiredTime,
    "voucher_image": voucherImage,
    "created_at": createdAt?.toIso8601String(),
    "rules": rules == null
        ? []
        : List<dynamic>.from(rules!.map((x) => x.toJson())),
    "provider": provider?.toJson(),
  };
}

class Provider {
  int? id;
  int? categoryId;
  String? name;
  String? instagramName;
  String? otherMedia;

  Provider({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.instagramName,
    required this.otherMedia,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    instagramName: json["instagram_name"],
    otherMedia: json["other_media"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "instagram_name": instagramName,
    "other_media": otherMedia,
  };
}

class Rule {
  int? id;
  int? providerId;
  String? name;
  String? description;
  String? socialType;
  int? stepNumber;
  DateTime? createdAt;
  DateTime? updatedAtAt;

  Rule({
    this.id,
    this.providerId,
    this.name,
    this.description,
    this.socialType,
    this.stepNumber,
    this.createdAt,
    this.updatedAtAt,
  });

  factory Rule.fromJson(Map<String, dynamic> json) => Rule(
    id: json["id"],
    providerId: json["provider_id"],
    name: json["name"],
    description: json["description"],
    socialType: json["social_type"],
    stepNumber: json["step_number"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAtAt: json["updated_at_at"] == null
        ? null
        : DateTime.parse(json["updated_at_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provider_id": providerId,
    "name": name,
    "description": description,
    "social_type": socialType,
    "step_number": stepNumber,
    "created_at": createdAt?.toIso8601String(),
    "updated_at_at": updatedAtAt?.toIso8601String(),
  };
}
