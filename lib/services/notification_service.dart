import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomNotification {
  final int id;
  final String title;
  final String body;
  final RemoteMessage? remoteMessage;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    this.remoteMessage,
  });
}

class NotificationService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationDetails androidNotificationDetails;

  NotificationService() {
    initialSetup();
    setUpAndroid();
  }

  initialSetup() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    await flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(android: androidInitializationSettings));
  }

  setUpAndroid() {
    androidNotificationDetails = const AndroidNotificationDetails(
        'machine_notification', 'Notificações',
        channelDescription: 'machine_notification_channel',
        importance: Importance.max,
        priority: Priority.max,
        enableVibration: true,
        styleInformation: BigTextStyleInformation(''));
  }

  void showNotification(CustomNotification notification) {
    log(notification.body);
    flutterLocalNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidNotificationDetails,
      ),
    );
  }
}

class FirebaseService {
  final NotificationService notificationService;

  FirebaseService(this.notificationService);

  Future initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            badge: true, alert: true, sound: true);

    onMessage();
  }

  onMessage() {
    FirebaseMessaging.onMessage.listen((event) {
      RemoteNotification? remoteNotification = event.notification;
      AndroidNotification? androidNotification = event.notification?.android;

      if (remoteNotification != null && androidNotification != null) {
        notificationService.showNotification(CustomNotification(
            id: androidNotification.hashCode,
            title: remoteNotification.title!,
            body: remoteNotification.body!));
      }
    });
  }
}
