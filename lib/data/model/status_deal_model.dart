// To parse this JSON data, do
//
//     final statusDealModel = statusDealModelFromJson(jsonString);

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';

List<StatusDealModel> statusDealModelFromJson(List<dynamic> str) =>
    List<StatusDealModel>.from(str.map((x) => StatusDealModel.fromJson(x)));

String statusDealModelToJson(List<StatusDealModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatusDealModel {
  DateTime? createdAt;
  DateTime? updatedAt;
  int? id;
  int? providerId;
  int? productionId;
  int? dealId;
  int? userId;
  String? restaurantName;
  int? discountNumber;
  String? discountType;
  int? userDealState;
  int? rulesExpireTime;
  int? rulesExtendTime;
  DateTime? rulesExtendTimeUpdateAt;

  StatusDealModel({
    this.rulesExtendTimeUpdateAt,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.providerId,
    this.productionId,
    this.dealId,
    this.userId,
    this.restaurantName,
    this.discountNumber,
    this.discountType,
    this.userDealState,
    this.rulesExpireTime,
    this.rulesExtendTime,
  });

  factory StatusDealModel.fromJson(Map<String, dynamic> json) =>
      StatusDealModel(
        rulesExtendTimeUpdateAt: json["rules_extend_time_updated_at"] == null
            ? null
            : DateFormat('yyyy-MM-ddThh:mm:ss')
            .parse(json["rules_extend_time_updated_at"] + "Z", true)
            .toLocal(),
        createdAt: json["createdAt"] == null
            ? null
            : DateFormat('yyyy-MM-ddThh:mm:ss')
            .parse(json["createdAt"] + "Z", true)
            .toLocal(),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateFormat('yyyy-MM-ddThh:mm:SS')
            .parse(json["updatedAt"],true)
            .toLocal(),
        id: json["id"],
        providerId: json["provider_id"],
        productionId: json["production_id"],
        dealId: json["deal_id"],
        userId: json["user_id"],
        restaurantName: json["restaurant_name"],
        discountNumber: json["discount_number"] != null
            ? double.parse(json["discount_number"].toString()).round()
            : null,
        discountType: json["discount_type"],
        userDealState: json["user_deal_state"],
        rulesExpireTime: json["rules_expire_time"],
        rulesExtendTime: json["rules_extend_time"],
      );

  Map<String, dynamic> toJson() => {
    "rulesExtendTimeUpdateAt": rulesExtendTimeUpdateAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "id": id,
    "provider_id": providerId,
    "production_id": productionId,
    "deal_id": dealId,
    "user_id": userId,
    "restaurant_name": restaurantName,
    "discount_number": discountNumber,
    "discount_type": discountType,
    "user_deal_state": userDealState,
    "rules_expire_time": rulesExpireTime,
    "rules_extend_time": rulesExtendTime,
  };
}
