import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';

enum NotifyType { Remind, Update_about_deal, Block_Account, Finish, Cancel }

List<NotifyModel> notificationModelFromJson(List<dynamic> str) =>
    List<NotifyModel>.from(str.map((x) => NotifyModel.fromJson(x)));

String notificationModelToJson(List<NotifyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotifyModel {
  NotifyType? type;
  String? content;
  int? dealId;
  String? iconUrl;
  int? notificationId;
  int? notificationTypeId;
  int? providerId;
  DateTime? createdAt;
  String? providerAvatarUrl;
  int? redeemId;
  bool? sent;
  String? title;
  int? userId;
  String? restaurantName;
  final int? snId;
  String? updated;

  NotifyModel(
      {this.snId,
      this.updated,
      this.type,
      this.content,
      this.dealId,
      this.iconUrl,
      this.notificationId,
      this.notificationTypeId,
      this.providerAvatarUrl,
      this.redeemId,
      this.providerId,
      this.sent,
      this.title,
      this.userId,
      this.createdAt, // Create at = updated
      this.restaurantName});

  factory NotifyModel.fromJson(Map<String, dynamic> json) => NotifyModel(
      snId: json["snId"],
      updated: json["updated"],
      providerId: json['providerId'] != null && json['providerId'] is String
          ? int.parse(json['providerId'])
          : json['providerId'],
      createdAt: json["updated"] == null
          ? null
          : DateTime.parse(json["updated"] + "Z").toUtc().toLocal(),
      content: json["content"],
        dealId: int.parse((json["dealId"] ?? json["deal_id"] ?? 0).toString()),
        iconUrl: json["iconUrl"],
        notificationId: int.parse(
            (json["notificationId"] ?? json['notification_id'] ?? 0)
                .toString()),
        notificationTypeId: int.parse(
            (json["notificationTypeId"] ?? json["notification_type_id"] ?? 0)
                .toString()),
      providerAvatarUrl: json["providerAvatarUrl"] ?? json['provider_avatar'],
      redeemId: int.parse((json["redeemId"] ?? 0).toString()),
      sent: json["sent"],
      title: json["title"],
      userId: int.parse((json["userId"] ?? json["user_id"] ?? 0).toString()),
      restaurantName: json['restaurantName']);

  Map<String, dynamic> toJson() => {
        "updated": updated,
        "snId": snId,
        "restaurantName": restaurantName,
        "providerId": providerId,
        "content": content,
        "dealId": dealId,
        "iconUrl": iconUrl,
        "notificationId": notificationId,
        "notificationTypeId": notificationTypeId,
        "providerAvatarUrl": providerAvatarUrl,
        "redeemId": redeemId,
        "sent": sent,
        "title": title,
        "userId": userId,
      };
}
