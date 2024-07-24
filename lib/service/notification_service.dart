import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/eventbus/notify_event.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/device_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../data/eventbus/notification_event.dart';

class NotificationService {
  // Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = "1";

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    channelId,
    "notifications",
    channelDescription: "notifications",
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  static const DarwinNotificationDetails _iOSNotificationDetails =
  DarwinNotificationDetails();

  final NotificationDetails notificationDetails = const NotificationDetails(
    android: _androidNotificationDetails,
    iOS: _iOSNotificationDetails,
  );

  Future<void> init() async {
    configFcm();
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iOSInitializationSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) =>
          onSelectNotification(response.payload),
    );
  }

  static Future<String> getNotificationAppLaunchDetail() async {
    try {
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      if (initialMessage?.contentAvailable == null) {
        // showAlert(context, "Delay 5s", "5...4...3...");
        await Future.delayed(const Duration(seconds: 5));

        initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      }

      // showAlert(context, "Content-Available",
      //     initialMessage?.contentAvailable.toString());
      return json.encode(initialMessage?.data).toString();
    } catch (ex) {
      // showAlert(context, "Content-Available-Error", ex.toString());
      return '';
    }
  }

  /*
      if (initialMessage == null) {
      showAlert(context, "Delay 5s", "Plz wait...");
      await Future.delayed(const Duration(seconds: 5));
      initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
    }
   */

  static void showAlert(BuildContext context, String title, String? content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content ?? "Nothing"),
      ),
    );
  }

  void configFcm() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getToken().then((value) async {
      print("TAG TOKEN: $value");
      await DeviceUtils.getDeviceId();
      // Clipboard.setData(ClipboardData(text: "${value ?? ''} ___ $deviceId"));
    });
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message !');
      print('onMessage : Message data: ${message.data}');
      StorageUtils.setNewNotify(true);
      handleNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('Got a message after open!');
      print('onMessageOpenedApp : Message data: ${message.data}');
      if (message.notification != null) {
        Timer(
            const Duration(seconds: 1),
            () => Utils.fireEvent(
                NotificationEvent(jsonData: json.encode(message.data))));
      }
    });
  }

  void handleNotification(RemoteMessage message) async {
    if (message.notification?.title == null ||
        message.notification?.body == null) return;
    print('Got a message !');
    print('onMessage : Message data: ${message.data}');
    Utils.fireEvent(NotifyEvent(message: message));
    showNotification(message);
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotification(
    RemoteMessage message,
  ) async {
    if (Platform.isIOS) return;
    await flutterLocalNotificationsPlugin.show(
        message.messageId.hashCode,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        notificationDetails,
        payload: json.encode(message.data).toString());
  }

  Future<void> cancelNotification(int id) async =>
      await flutterLocalNotificationsPlugin.cancel(id);

  Future<void> cancelAllNotifications() async =>
      await flutterLocalNotificationsPlugin.cancelAll();
}

Future<void> onSelectNotification(String? payload) async {
  logE("TAG ONSELECT NOTIFICATION: $payload");
  Timer(const Duration(seconds: 1),
      () => Utils.fireEvent(NotificationEvent(jsonData: payload)));
}

Future<dynamic> fakeData() async {
  String str =
      await rootBundle.loadString('assets/json/push_notification.json');
  return json.decode(str);
}
