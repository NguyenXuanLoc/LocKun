import 'dart:convert';
import 'dart:ui';

import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/eventbus/refresh_event.dart';
import 'package:base_bloc/data/globals.dart' as globals;
import 'package:base_bloc/data/model/category_model.dart';
import 'package:base_bloc/data/model/place.dart';
import 'package:base_bloc/data/model/restaurant_model.dart';
import 'package:base_bloc/data/model/user_model.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:clear_all_notifications/clear_all_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_storage/get_storage.dart';

import '../components/app_bar_widget.dart';
import '../data/model/notify_model.dart';
import '../data/model/status_deal_model.dart';

class StorageUtils {
  static Future<bool> isFirstOpenCamera() async {
    var value = await GetStorage().read(StorageKey.camera) ?? true;
    await GetStorage().write(StorageKey.camera, false);
    return value;
  }

  static Future<void> saveLastTimeQrCodeByProviderId(int providerId) async {
    var date = DateTime.now().millisecondsSinceEpoch;
    var map = GetStorage().read(StorageKey.qr_code) ?? {};
    map['$providerId'] = date;
    await GetStorage().write(StorageKey.qr_code, map);
  }

  static Future<int> getOldTimeQrCodeByProviderId(int providerId) async {
    try {
      var map = await GetStorage().read(StorageKey.qr_code) ?? {};
      return map['$providerId'] ?? 0;
    } catch (ex) {
      return 0;
    }
  }

  static Future<void> saveLogin(UserModel model,
      {bool isRefresh = false}) async {
    await GetStorage().write(StorageKey.userModel, model.toJson());
    globals.isTokenExpired = false;
    globals.userModel = model;
    globals.userId = model.id ?? 0;
    globals.isLogin = true;
    globals.accessToken = model.token ?? '';
    globals.refreshToken = model.refreshToken ?? '';
    if (isRefresh) {
      Utils.fireEvent(RefreshEvent(refreshType: RefreshType.ALL));
    }
    FirebaseMessaging.instance
        .subscribeToTopic(ConstantKey.system_notification);
    clearQrCodeId();
  }

  static Future<void> saveFcmToken(String token) async {
    await GetStorage().write(StorageKey.fcmToken, token);
  }




  static String getFcmToken() {
    var token = GetStorage().read(StorageKey.fcmToken);
    return token ?? "";
  }

  static Future<void> getLogin() async {
    try {
      var userStr = await GetStorage().read(StorageKey.userModel);
      if (userStr != null) {
        globals.isLogin = true;
        globals.userModel = UserModel.fromJson(userStr);
        globals.accessToken = globals.userModel?.token ?? '';
        // globals.accessToken ='eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDExNTQzNDAsImlhdCI6MTcwMDk4MTU0MCwic3ViIjoiOCIsImlzcyI6InVzZXItaXNzdWVyIiwicm9sZSI6InVzZXIiLCJpbnN0YWdyYW0taWQiOiI2OTU1MzQ5MDg0NDg1MTQ5IiwiaW5zdGFncmFtLXVzZXJuYW1lIjoibWFyaTAueHgiLCJ2ZXJpZmllZCI6ZmFsc2UsImF0eXBlIjoic3dheW1lIn0.XRpmxuawUaT6gTll19JyEK0rrQ3XzjrdYqR74iyG7m800M2YbsStJXAW-XR7fD9n3Ux0YJxdNQ2aQZxh6OlnOKjbQfbTxB9sDxNorMkdoXjQx2PHzs86rE7c6TB6wzulTtimAJgWRjNxqxxUMAIHzo2U21i3HXkmc2wdXaFpO6uo8JoX5KWOq2-k4umwMaDR3BIzLh_WTAYMLvZdX913vO5qWTxUXl5hz-UrDpuZpwwbv9ANLE4zkL_7qnAJdNHC_cM8COEo-bk00nQwOrTukP2yhcvZKAdvX6OEakpSw8jRFZ9qlOcMX22kYL3aG-UH5uZSZ-ShecmHdPSbOAwBow';
        globals.refreshToken = globals.userModel?.refreshToken ?? '';
        globals.userId = globals.userModel?.id ?? 0;
        await FirebaseMessaging.instance
            .subscribeToTopic(ConstantKey.system_notification);
      }
    } catch (ex) {}
  }

  static UserProfileModel? getUserProfile() {
    try {
      var userStr = GetStorage().read(StorageKey.userProfile);
      return UserProfileModel.fromJson(userStr);
    } catch (ex) {
      return null;
    }
  }

  static Future<void> saveUserProfile(UserProfileModel userProfileModel) async {
    await GetStorage().write(StorageKey.userProfile, userProfileModel.toJson());
  }

  static UserModel? getUser() {
    try {
      var userStr = GetStorage().read(StorageKey.userModel);
      return UserModel.fromJson(userStr);
    } catch (ex) {
      return null;
    }
  }

  static Future<void> logout() async {
    globals.accessToken = '';
    globals.refreshToken = '';
    globals.isLogin = false;
    globals.userModel = null;
    globals.userId = -1;
    globals.lStatusDealByUserId = [];
    FirebaseMessaging.instance
        .unsubscribeFromTopic(ConstantKey.system_notification);
    ClearAllNotifications.clear();
    await GetStorage().remove(StorageKey.userModel);
    await GetStorage().remove(StorageKey.fcmToken);
    await GetStorage().remove(StorageKey.notify);
    await GetStorage().remove(StorageKey.onGoingDeal);
    await GetStorage().remove(StorageKey.endDeal);
    await GetStorage().remove(StorageKey.userStatus);
    await GetStorage().remove(StorageKey.dealOfUser);
    await GetStorage().remove(StorageKey.userProfile);
    await GetStorage().remove(StorageKey.userAvatar);
    clearQrCodeId();
  }

  static Future<void> clearQrCodeId() async {
    await GetStorage().remove(StorageKey.qr_code);
  }

  static Future<void> saveListRestaurant(RestaurantModel model) async {
    var lRestaurant = getListRestaurant();
    lRestaurant =
        lRestaurant.where((element) => element.id != model.id).toList();
    lRestaurant.add(model);
    await GetStorage().write(StorageKey.restaurant,
        json.encode(lRestaurant.map((e) => e.toJson()).toList()));
  }

  static List<RestaurantModel> getListRestaurant() {
    try {
      var lRestaurantStr = GetStorage().read(StorageKey.restaurant);
      if (lRestaurantStr != null) {
        var lResult = (json.decode(lRestaurantStr) as List<dynamic>)
            .map((e) => RestaurantModel.fromJson(e))
            .toList();
        return lResult;
      }
    } catch (e) {}
    return [];
  }

  static Future<void> saveGuideline() async =>
      await GetStorage().write(StorageKey.isGuideline, true);

  static Future<void> saveRegister() async =>
      await GetStorage().write(StorageKey.isShowRegister, true);

  static Future<bool> isShowRegister() async =>
      await GetStorage().read(StorageKey.isShowRegister) ?? false;

  static Future<bool> isGuideline() async =>
      await GetStorage().read(StorageKey.isGuideline) ?? false;

  static Future<void> saveCategory(dynamic data) async {
    GetStorage().write(StorageKey.category, json.encode(data));
  }

  static List<CategoryModel> getCategories() {
    String categoryStr = GetStorage().read(StorageKey.category) ?? '';
    if (categoryStr.isNotEmpty) {
      var lCategory = categoryModelFromJson(json.decode(categoryStr));
      return lCategory;
    }
    return [];
  }

  static Future<void> savePlaces(dynamic data) async {
    GetStorage().write(StorageKey.places, json.encode(data));
  }

  static List<PlaceModel> getPlaces() {
    String placesStr = GetStorage().read(StorageKey.places) ?? '';
    if (placesStr.isNotEmpty) {
      try {
        var places = (json.decode(placesStr) as List<dynamic>)
            .map((e) => PlaceModel.fromJson(e))
            .toList(growable: true);
        return places;
      } catch (ex) {}
    }
    return [];
  }

  static void saveUserAvatar(String avatar) {
    GetStorage().write(StorageKey.userAvatar, avatar);
  }

  static String getUserAvatar() {
    return GetStorage().read(StorageKey.userAvatar) ?? '';
  }

  static Future<void> saveNotifies(dynamic data) async {
    GetStorage().write(StorageKey.notify, json.encode(data));
  }

  static List<NotifyModel> getNotifies() {
    String notifyStr = GetStorage().read(StorageKey.notify) ?? '';
    if (notifyStr.isNotEmpty) {
      var notifies = notificationModelFromJson(json.decode(notifyStr));
      return notifies;
    }
    return [];
  }

  static void saveOnGoingDeal(dynamic data) {
    GetStorage().write(StorageKey.onGoingDeal, json.encode(data));
  }

  static List<StatusDealModel> getOnGoingDeal() {
    String dataStr = GetStorage().read(StorageKey.onGoingDeal) ?? '';
    if (dataStr.isNotEmpty) {
      return statusDealModelFromJson(json.decode(dataStr));
    }
    return [];
  }

  static void saveEndDeal(dynamic data) {
    GetStorage().write(StorageKey.endDeal, json.encode(data));
  }

  static List<StatusDealModel> getEndDeal() {
    String dataStr = GetStorage().read(StorageKey.endDeal) ?? '';
    if (dataStr.isNotEmpty) {
      return statusDealModelFromJson(json.decode(dataStr));
    }
    return [];
  }

  static void saveUserStatus(int userStatus) {
    GetStorage().write(StorageKey.userStatus, userStatus);
  }

  static UserStatus? getUserStatus() {
    int? userStatus = GetStorage().read(StorageKey.userStatus);
    if (userStatus != null) {
      return userStatusFromString(userStatus);
    }
    return null;
  }

  static void setNewNotify(bool isNewNotify) {
    GetStorage().write(StorageKey.newNotify, isNewNotify);
  }

  static bool isNewNotify() {
    return GetStorage().read(StorageKey.newNotify) ?? false;
  }

  static setClearCacheWebView(bool value) =>
      GetStorage().write(StorageKey.clearCacheWebView, value);

  static isClearCacheWebView() =>
      GetStorage().read(StorageKey.clearCacheWebView) ?? false;

  static void saveDealByUserId(List<StatusDealModel> lDeal) {
    GetStorage().write(StorageKey.dealOfUser,
        json.encode(lDeal.map((e) => e.toJson()).toList()));
  }

  static List<StatusDealModel> getDealOfUser() {
    try {
      var lDealStr = GetStorage().read(StorageKey.dealOfUser);
      if (lDealStr != null && (lDealStr as String).isNotEmpty) {
        var lDeal = (json.decode(lDealStr) as List)
            .map((e) => StatusDealModel.fromJson(e))
            .toList();
        return lDeal;
      }
      // ignore: empty_catches
    } catch (ex) {
      logE("TGAX: ${ex.toString()}");
    }
    return [];
  }

  //App will clear restaurant in cache when open app after 2 day.
  static void checkTimeClearRestaurantCache() {
    var timeOpen = GetStorage().read(StorageKey.timeOpenApp);
    if (timeOpen != null) {
      var differentDate = DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(timeOpen))
          .inDays;
      if (differentDate >= 2) {
        GetStorage().remove(StorageKey.restaurant);
        GetStorage().write(
            StorageKey.timeOpenApp, DateTime.now().millisecondsSinceEpoch);
      }
    } else {
      GetStorage()
          .write(StorageKey.timeOpenApp, DateTime.now().millisecondsSinceEpoch);
    }
  }
}
