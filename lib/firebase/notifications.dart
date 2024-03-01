import 'package:firebase_messaging/firebase_messaging.dart';
import '../global/user.dart';

class Notifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> reqNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.getNotificationSettings();

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        sound: true,
        criticalAlert: false,
        provisional: false,
      );
    }
  }

  static Future<void> init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.getNotificationSettings();

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        sound: true,
        criticalAlert: false,
        provisional: false,
      );
    }

    final token = await _firebaseMessaging.getToken();
    print("The  FCM token is \"$token\"");
    setFcmToken(token);
  }
}
