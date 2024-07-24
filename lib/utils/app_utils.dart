import 'dart:io' show Platform;
import 'dart:io';

import 'package:base_bloc/data/repository/base_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static var METHOD_CHANNEL = "METHOD_CALL_NATIVE";
  static var eventBus = EventBus();
  static const platform = MethodChannel('plugins.flutter.io/navigator');
  static var A_DAY = 24 * 60;
  static var repository = BaseRepository();

  static fireEvent(dynamic model) => eventBus.fire(model);

  static bool validatePassword(String value) {
    String pattern = r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static void hideKeyboard(BuildContext? context) {
    if (context != null) FocusScope.of(context).requestFocus(FocusNode());
  }

  static void openGoogleMap(String location, String googleMapUrl) async {
    if (location.isEmpty) return;
    var defaultUrl =
        "https://www.google.com/maps/search/?api=1&query=$location";
    if (Platform.isAndroid) {
      var isCanLaunch =
          await platform.invokeMethod<bool>('openMap', googleMapUrl);
      if (!(isCanLaunch ?? false)) {
        openUrl(googleMapUrl.isNotEmpty ? googleMapUrl : defaultUrl,
            launchMode: LaunchMode.platformDefault);
      }
    } else {
      googleMapUrl =
          googleMapUrl.replaceAll("https://", "").replaceAll("http://", "");
      var url = googleMapUrl.isNotEmpty
          ? "comgooglemapsurl://$googleMapUrl"
          : "comgooglemaps://?q=$location&zoom=20&hl=en";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        await launchUrl(
            Uri.parse(googleMapUrl.isNotEmpty ? googleMapUrl : defaultUrl),
            mode: LaunchMode.externalApplication);
      }
    }
  }

  static void openInstagram(String instagramName) async {
    var defaultUrl = "https://www.instagram.com/$instagramName/";
    if (instagramName.isEmpty) return;
    if (Platform.isAndroid) {
      var isCanLaunch =
          await platform.invokeMethod<bool>('openInstagram', instagramName);
      if (!(isCanLaunch ?? false)) {
        openUrl(defaultUrl, launchMode: LaunchMode.platformDefault);
      }
    } else {
      final url = 'instagram://user?username=$instagramName';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        await launchUrl(Uri.parse(defaultUrl),
            mode: LaunchMode.externalApplication);
      }
    }
  }

  static void openUrl(String url,
      {LaunchMode launchMode = LaunchMode.platformDefault}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: launchMode);
    }
  }

  static String formatMoney(int? money) =>
      NumberFormat('#,###,###,#,###,###,###', 'vi').format(money ?? 0);

  static Future<bool> isPermissionLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  static String convertMinutesToHHMM(int minutes) {
    return "${minutes ~/ 60 == 0 ? '00' : "${minutes ~/ 60}h"} "
        "${(minutes % 60).toString().length == 1 ? "0${minutes % 60}" : "${minutes % 60}"}m";
  }

  static String convertDateTimeTOMMDDYYYYHHMM(DateTime dateTime) {
    return DateFormat("MM.dd.yyy HH:mm").format(dateTime);
  }

  static String convertDateToddMM(DateTime dateTime) =>
      DateFormat("dd.MM").format(dateTime);

  static String convertSecondToMMSS(int second) {
    return "${second ~/ 60 == 0 ? '00' : (second ~/ 60).toString().length == 1 ? "0${second ~/ 60}" : "${second ~/ 60}"}:"
        "${(second % 60).toString().length == 1 ? "0${second % 60}" : "${second % 60}"}";
  }

  static Future<String> calculateDistance(LatLng location,
      {LatLng? currentLocation, bool isGetLocation = true}) async {
    if (isGetLocation) {
      currentLocation = await getCurrentLocation();
    }
    if (currentLocation == null) return '';
    final double distance = Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      location.latitude,
      location.longitude,
    );
    if ((distance / 1000) >= 1) {
      return "${(distance / 1000).round()}km";
    } else {
      return "${distance.round()}m";
    }
  }

  static String calculateDistanceWithCurrentLocation(
      LatLng location, LatLng? currentLocation,
      {bool isDouble = false, bool isKm = true}) {
    if (currentLocation == null) {
      return '';
    }
    final double distance = Geolocator.distanceBetween(
      currentLocation.latitude ?? 0,
      currentLocation.longitude ?? 0,
      location.latitude,
      location.longitude,
    ).roundToDouble();
    if (isDouble) {
      return isKm
          ? (distance / 1000).toStringAsFixed(2)
          : distance.toStringAsFixed(2); // Convert to kilometers
    }
    if ((distance / 1000) >= 1) {
      return "${(distance / 1000).round()}km";
    } else {
      return "${distance.round()}m";
    }
  }

  static Future<LatLng?> getCurrentLocation() async {
    var isPermission = await Utils.isPermissionLocation();
    if (!isPermission) return null;
    var currentLocation =
        await Geolocator.getCurrentPosition(timeLimit: Duration(minutes: 1));
    return LatLng(currentLocation.latitude, currentLocation.longitude);
  }
}
