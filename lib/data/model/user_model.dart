// To parse this JSON data, do
//
//     final UserModel = UserModelFromJson(jsonString);

import 'dart:convert';

import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/utils/storage_utils.dart';

enum UserStatus { SWAYER,NAUGHTY_SWAYER,NOT_A_SWAYER,NAUGHTY_SWAYER_AND_SUSPEND}

extension UserStatusString on UserStatus {
  String get type {
    switch (this) {
      case UserStatus.SWAYER:
        return ApiKey.Swayer;
      case UserStatus.NOT_A_SWAYER:
         return ApiKey.Not_a_Swayer;
      case UserStatus.NAUGHTY_SWAYER:
        return ApiKey.Naughty_Swayer;
      case UserStatus.NAUGHTY_SWAYER_AND_SUSPEND:
        return ApiKey.Naughty_Swayer_AND_Suspend;
    }
  }
}

const valueMap = {
  UserStatus.SWAYER: 1/*ApiKey.Swayer*/,
  UserStatus.NAUGHTY_SWAYER: 2/*ApiKey.Naughty_Swayer*/,
  UserStatus.NOT_A_SWAYER: 3/*ApiKey.Not_a_Swayer*/,
  UserStatus.NAUGHTY_SWAYER_AND_SUSPEND: 4/*ApiKey.Naughty_Swayer_AND_Suspend*/,
};

UserStatus userStatusFromString(int input) {
  StorageUtils.saveUserStatus(input);
  final reverseValueMap =
      valueMap.map<int, UserStatus>((key, value) => MapEntry(value, key));
  UserStatus? output = reverseValueMap[input];
  if (output == null) {
    return UserStatus.SWAYER;
  }
  return output;
}

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel(
      {this.id,
      this.userProfileModel,
      this.token,
      this.refreshToken,
      this.instagramName,
      this.avatar,
      this.instagramId,
      this.status = UserStatus.SWAYER});

  String? instagramName;
  String? avatar;
  int? id;
  String? instagramId;
  UserStatus status;
  String? token;
  String? refreshToken;
  UserProfileModel? userProfileModel;

  UserModel copyOf({UserProfileModel? user, String? token}) => UserModel(
      instagramId: instagramId,
      status: status,
      instagramName: instagramName,
      avatar: avatar,
      id: id,
      refreshToken: refreshToken,
      token: token ?? this.token,
      userProfileModel: user ?? userProfileModel);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      refreshToken: json["refresh_token"],
      id: json["user_id"],
      token: json["token"],
      avatar: json['avatar'],
      instagramName: json["instagram_username"],
      instagramId: json["instagram_id"],
      status: UserStatus.SWAYER);

  Map<String, dynamic> toJson() => {
        "user_id": id,
        "instagram_username": instagramName,
        "avatar": avatar,
        "status": status.type,
        "token": token,
        "refresh_token": refreshToken
      };
}

class UserProfileModel {
  int? id;
  int? accountId;
  String? instagramId;
  String? instagramUsername;
  String? username;
  String? avatar;
  String? description;
  DateTime? updatedAt;
  DateTime? createdAt;

  UserProfileModel({
    this.id,
    this.accountId,
    this.instagramId,
    this.instagramUsername,
    this.username,
    this.avatar,
    this.description,
    this.updatedAt,
    this.createdAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"],
        accountId: json["account_id"],
        instagramId: json["instagram_id"],
        instagramUsername: json["instagram_username"],
        username: json["username"],
        avatar: json["avatar"],
        description: json["description"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "account_id": accountId,
        "instagram_id": instagramId,
        "instagram_username": instagramUsername,
        "username": username,
        "avatar": avatar,
        "description": description,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
      };
}
