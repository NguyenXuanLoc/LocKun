import 'package:firebase_messaging/firebase_messaging.dart';

class NotifyEvent {
  final RemoteMessage message;

  NotifyEvent({required this.message});
}
