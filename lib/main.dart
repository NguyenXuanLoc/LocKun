import 'dart:async';
import 'dart:io';

import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/gen/fonts.gen.dart';
import 'package:base_bloc/router/application.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/utils/device_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

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
  await EasyLocalization.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  configOrientation();
  await DeviceUtils.getDeviceId();
  await GetStorage.init();

  // Utils.remoteConfig();
/*  try {
    var notificationService = NotificationService();
    await notificationService.init();
    await notificationService.requestIOSPermissions();
  } catch (ex) {}*/
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
