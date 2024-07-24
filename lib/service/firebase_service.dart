import 'package:firebase_core/firebase_core.dart';

import '../utils/app_utils.dart';
import '../utils/connection_utils.dart';
import 'notification_service.dart';

class FirebaseService {
  // Singleton pattern
  static final FirebaseService _FirebaseService = FirebaseService._internal();
  bool isConnect = false;

  factory FirebaseService() {
    return _FirebaseService;
  }

  FirebaseService._internal();

  Future<void> init() async {
    var isInternetConnection = await ConnectionUtils.isConnect();
    if (isInternetConnection && !isConnect) {
      await Firebase.initializeApp();
      isConnect = true;
    } else {
      isConnect = false;
    }
    if (isConnect) {
      try {
        var notificationService = NotificationService();
        await notificationService.init();
        await notificationService.requestIOSPermissions();
      } catch (ex) {}
    }
  }
}
