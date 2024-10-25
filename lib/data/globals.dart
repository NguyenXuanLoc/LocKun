library app.globals;

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/category_model.dart';
import 'model/status_deal_model.dart';

String accessToken = '';
String refreshToken = '';
String lang = '';
String deviceId = '';
String deviceName = '';
int userId = 0;
String deviceModel = '';
BuildContext? homeContext;
bool popWithNewAnimation = false;
bool isQrCode = false;
bool isLogin = false;
bool isTokenExpired = false;
int timeOut = 30;
bool isFAQ = false;
bool isYourStatus = false;
double contentPadding = 14;
bool isFirstOpenApp = true;
LatLng? currentLocation;
List<CategoryModel> lCategory = [];
List<StatusDealModel> lStatusDealByUserId = [];
