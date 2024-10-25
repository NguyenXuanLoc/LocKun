import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class StorageKey {
  StorageKey._();

  static const String camera = 'camera';
  static const String userModel = 'userModel';
  static const String isGuideline = 'isGuideline';
  static const String isShowRegister = 'isShowRegister';
  static const String fcmToken = 'fcmToken';
  static const String category = 'category';
  static const String places = 'places';
  static const String notify = 'notify';
  static const String onGoingDeal = 'onGoingDeal';
  static const String endDeal = 'endDeal';
  static const String userStatus = 'userStatus';
  static const String newNotify = 'newNotify';
  static const String userProfile = 'userProfile';
  static const String clearCacheWebView = 'clearCacheWebView';
  static const String dealOfUser = 'dealOfUser';
  static const String appTheme = 'appTheme';
  static const String restaurant = 'restaurant';
  static const timeOpenApp = "time_open_app";
  static const String userAvatar = 'userAvatar';
  static const String qr_code = 'qr_code';
  static const String data = 'data';
}

class FirebaseRemoteConfigConstant {
  static String FACEBOOK_ERROR_CODE_VALUE =
      "PLATFORM__LOGIN_DISABLED_FROM_WEBVIEW"; //error code when trying login with facebook inside instagram web
  static const FACEBOOK_ERROR_CODE_KEY = "FACEBOOK_ERROR_CODE";
  static const FACEBOOK_ERROR_CODE = "FACEBOOK_ERROR_CODE";
  static const APPLE_ID_KEY = "APPLE_ID_KEY";
  static String APPLE_ID_VALUE = "6479729407";
  static String ANDROID_REVIEW_VERSION_KEY = "Android_review_version";
  static String REVIEW_VERSION = "";
  static String IOS_REVIEW_VERSION_KEY = "Ios_review_version";
  static String INSTAGRAM_REVIEW_MODEL_KEY = "Instagram_review_model";
  static String INSTAGRAM_REVIEW_VERSION_VALUE = "";
  static String ANDROID_STORE_VERSION_KEY = "Android_store_version";
  static String IOS_STORE_VERSION_KEY = "Ios_store_version";
  static String STORE_VERSION = "";
}

class BottomNavigationConstant {
  static const TAB_DEAL = 0;
  static const TAB_Map = 1;
  static const TAB_QR = 2;
  static const TAB_NOTIFY = 3;
  static const TAB_PROFILE = 4;
}

class ConstantKey {
  static const String All = 'all';
  static const int NEW_RESTAURANT_NOTIFY_TYPE = 9;
  static const String PROVIDER_NAME = "PROVIDER_NAME";
  static const String story = "story";
  static const String no_data = "no_data";
  static const String post = "post";
  static const String applicationId = "com.app.swayme";
  static const String all = 'all';
  static const String darkMode = 'darkMode';
  static const String lightMode = 'lightMode';
  static const String dont_allow_permission = 'dont_allow_permission';
  static const NOT_AVAILABLE_DEAL = 'is not available with you';
  static const LINK_IMAGE = "https://prod-swayme-provider.s3.eu-central-1.amazonaws.com/";
  static const DEAL_DONE = 2;
  static const DEAL_ENABLE = 1;
  static const DEAL_REJECT = 3;
  static const ON_GOING_DEAL = 1;
  static const END_DEAL = 2;
  static const MAX_SCOPE = 5; //km
  static const PRECENT = 'percent';
  static const MONEY = 'money';
  static const TIME_RESENT =180; //3minute
  static const String USER = 'user';
  static const String DYNAMIC_LINK = "https://docsify.page.link";
  static const String IOS_APP_STORE_ID = "1634725173";
  static const int WEEK_INDEX_OFFSET = 5200;
  static const String YOUR_ACCOUNT_HAS_BEEN_BLOC = 'Your account has been locked';
  static const String TOKEN_EXPIRED = "token expired";
  static const String CONNECTION_TIMED_OUT = 'Connection timed out';
  static const String INSARGRAM_URL = 'https://api.instagram.com/accounts/login';
  static const String REDIRECT_UTL = 'https://manhterry93.github.io/auth/';
  static const String REDIRECT_DOMAIN='manhterry93.github.io';
  static const String TERRM_URL = 'https://www.swayme.pl/terms-and-conditions';
  static const int DEAL_AVAILABLE = 1;
  static const int DEAL_NOT_AVAILABLE = 0;
  static const int A_DAY = 86400000;
  static const int A_HOUR = 3600000;
  static const int WARNING_TIME = 120; //minutes warning when deal is prepared ends
  static const system_notification = "system_notification_staging";
  static const appName = "Swayme(staging)";
  static var BottonNavHeight = Platform.isIOS ? 99.0 : 63.0;
  static const BLANK_HTML = "<html><head></head><body></body></html>";
  static const the_account_verification_may_take_up_to_12h =
      'the_account_verification_may_take_up_to_12h';
  static const VERIFYING_ACC_CODE = 1429;
  static const RESTAURANT_NOT_FOUND = 0;
  static const DEFAULT_LOCATION =
      LatLng(52.230048384049994, 21.012658228206814);
}

class MessageKey {
  static const String egCodeIsValid = 'Twoja sesja wygasła';
  static const String plCodeIsValid = 'Your code is invalid';
}

class ApiKey {
  static const String lang = 'Accept-language';
  static const String instagram_id = 'instagram_id';
  static const String instagram_username = 'instagram_username';
  static const String image_url = 'image_url';
  static const String is_open = 'is_open';
  static const String is_active = 'is_active';
  static const String latest_warning = 'latest_warning';
  static const String state_id = 'state_id';
  static const String access_code = 'access_code';
  static const String device_id = 'device_id';
  static const String device_name = 'device_name';
  static const String device_model = 'device_model';
  static const String location = 'location';
  static const String fcm_token = 'fcm_token';
  static const String category_ids = 'category_ids';
  static const String username = 'username';
  static const String avatar = 'avatar';
  static const String login_as = 'login_as';
  static const String refresh_token = 'refresh_token';
  static const String user ='user';
  static const String Swayer = 'Swayer';
  static const String Naughty_Swayer = 'Naughty Swayer';
  static const String Not_a_Swayer = 'Not a Swayer';
  static const String Naughty_Swayer_AND_Suspend = 'Naughty Swayer & Suspend';
}

