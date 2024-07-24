// To parse this JSON data, do
//
//     final instagramInfoModel = instagramInfoModelFromJson(jsonString);

import 'dart:convert';

InstagramInfoModel instagramInfoModelFromJson(String str) => InstagramInfoModel.fromJson(json.decode(str));

String instagramInfoModelToJson(InstagramInfoModel data) => json.encode(data.toJson());

class InstagramInfoModel {
  final String? biography;
  final dynamic businessContactMethod;
  final bool? canFollowHashtag;
  final bool? canSeeOrganicInsights;
  final dynamic categoryName;
  final String? externalUrl;
  final String? fbid;
  final String? fullName;
  final bool? hasPhoneNumber;
  final bool? hasProfilePic;
  final bool? hideLikeAndViewCounts;
  final String? id;
  final bool? isBusinessAccount;
  final bool? isJoinedRecently;
  final bool? isUserInCanada;
  final bool? isPrivate;
  final bool? isProfessionalAccount;
  final String? profilePicUrl;
  final String? profilePicUrlHd;
  final dynamic shouldShowCategory;
  final dynamic shouldShowPublicContacts;
  final String? username;
  final bool? isSupervisedUser;
  final dynamic guardianId;
  final bool? isSupervisionEnabled;
  final bool? isBasicAdsOptedIn;
  final int? basicAdsTier;
  final bool? probablyHasApp;

  InstagramInfoModel({
    this.biography,
    this.businessContactMethod,
    this.canFollowHashtag,
    this.canSeeOrganicInsights,
    this.categoryName,
    this.externalUrl,
    this.fbid,
    this.fullName,
    this.hasPhoneNumber,
    this.hasProfilePic,
    this.hideLikeAndViewCounts,
    this.id,
    this.isBusinessAccount,
    this.isJoinedRecently,
    this.isUserInCanada,
    this.isPrivate,
    this.isProfessionalAccount,
    this.profilePicUrl,
    this.profilePicUrlHd,
    this.shouldShowCategory,
    this.shouldShowPublicContacts,
    this.username,
    this.isSupervisedUser,
    this.guardianId,
    this.isSupervisionEnabled,
    this.isBasicAdsOptedIn,
    this.basicAdsTier,
    this.probablyHasApp,
  });

  factory InstagramInfoModel.fromJson(Map<String, dynamic> json) => InstagramInfoModel(
    biography: json["biography"],
    businessContactMethod: json["business_contact_method"],
    canFollowHashtag: json["can_follow_hashtag"],
    canSeeOrganicInsights: json["can_see_organic_insights"],
    categoryName: json["category_name"],
    externalUrl: json["external_url"],
    fbid: json["fbid"],
    fullName: json["full_name"],
    hasPhoneNumber: json["has_phone_number"],
    hasProfilePic: json["has_profile_pic"],
    hideLikeAndViewCounts: json["hide_like_and_view_counts"],
    id: json["id"],
    isBusinessAccount: json["is_business_account"],
    isJoinedRecently: json["is_joined_recently"],
    isUserInCanada: json["is_user_in_canada"],
    isPrivate: json["is_private"],
    isProfessionalAccount: json["is_professional_account"],
    profilePicUrl: json["profile_pic_url"],
    profilePicUrlHd: json["profile_pic_url_hd"],
    shouldShowCategory: json["should_show_category"],
    shouldShowPublicContacts: json["should_show_public_contacts"],
    username: json["username"],
    isSupervisedUser: json["is_supervised_user"],
    guardianId: json["guardian_id"],
    isSupervisionEnabled: json["is_supervision_enabled"],
    isBasicAdsOptedIn: json["is_basic_ads_opted_in"],
    basicAdsTier: json["basic_ads_tier"],
    probablyHasApp: json["probably_has_app"],
  );

  Map<String, dynamic> toJson() => {
    "biography": biography,
    "business_contact_method": businessContactMethod,
    "can_follow_hashtag": canFollowHashtag,
    "can_see_organic_insights": canSeeOrganicInsights,
    "category_name": categoryName,
    "external_url": externalUrl,
    "fbid": fbid,
    "full_name": fullName,
    "has_phone_number": hasPhoneNumber,
    "has_profile_pic": hasProfilePic,
    "hide_like_and_view_counts": hideLikeAndViewCounts,
    "id": id,
    "is_business_account": isBusinessAccount,
    "is_joined_recently": isJoinedRecently,
    "is_user_in_canada": isUserInCanada,
    "is_private": isPrivate,
    "is_professional_account": isProfessionalAccount,
    "profile_pic_url": profilePicUrl,
    "profile_pic_url_hd": profilePicUrlHd,
    "should_show_category": shouldShowCategory,
    "should_show_public_contacts": shouldShowPublicContacts,
    "username": username,
    "is_supervised_user": isSupervisedUser,
    "guardian_id": guardianId,
    "is_supervision_enabled": isSupervisionEnabled,
    "is_basic_ads_opted_in": isBasicAdsOptedIn,
    "basic_ads_tier": basicAdsTier,
    "probably_has_app": probablyHasApp,
  };
}
