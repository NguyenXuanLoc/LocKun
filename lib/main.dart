import 'dart:async';
import 'dart:io';

import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/gen/fonts.gen.dart';
import 'package:base_bloc/router/application.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/service/firebase_service.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/device_utils.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'localization/codegen_loader.g.dart';

void main() async {
  await configApp();
  runApp(
    EasyLocalization(
        assetLoader: const Applocalizations(),
        supportedLocales: Applocalizations.supportedLocales,
        saveLocale: true,
        path: 'assets/translations',
        child: const MyApp()),
  );
}

Future<void> configApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await EasyLocalization.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  configOrientation();
  await DeviceUtils.getDeviceId();
  await GetStorage.init();
  await StorageUtils.getLogin();
  StorageUtils.checkTimeClearRestaurantCache();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
    initializeMapRenderer();
  }
  // Utils.remoteConfig();
/*  try {
    var notificationService = NotificationService();
    await notificationService.init();
    await notificationService.requestIOSPermissions();
  } catch (ex) {}*/
}

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer =
      Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  WidgetsFlutterBinding.ensureInitialized();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    unawaited(mapsImplementation
        .initializeWithRenderer(AndroidMapRenderer.latest)
        .then((AndroidMapRenderer initializedRenderer) =>
            completer.complete(initializedRenderer)));
  } else {
    completer.complete(null);
  }

  return completer.future;
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("TAG _firebaseMessagingBackgroundHandler: $message");
  await GetStorage.init();
  StorageUtils.setNewNotify(true);
}

void configOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    configRouter();
    super.initState();
  }

  void configRouter() {
    final router = FluroRouter();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: ConstantKey.appName,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: true,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: FontFamily.inter,
          textTheme:
              Theme.of(context).textTheme.apply(fontFamily: FontFamily.inter),
          backgroundColor: Colors.white,
          primaryColor: Colors.white,
          bottomAppBarColor: Colors.yellow,
          dividerColor: Colors.transparent,
          shadowColor: Colors.transparent,
          appBarTheme: const AppBarTheme(elevation: 0),
        ),
        onGenerateRoute: Application.router.generator);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
