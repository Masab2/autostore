import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:autostore/Services/firebasehelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Notification Show in Application
  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitiziationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitilizationSettings = const DarwinInitializationSettings();
    var initilizationSettings = InitializationSettings(
        android: androidInitiziationSettings, iOS: iosInitilizationSettings);
    try {
      await _flutterLocalNotificationsPlugin.initialize(initilizationSettings,
          onDidReceiveNotificationResponse: (payload) {});
    } catch (e) {
      dev.log("Init Local Notification Errror${e.toString()}");
    }
  }

  // Notification From the Firebase
  void firebaseinit(BuildContext context) {
    try {
      FirebaseMessaging.onMessage.listen((message) {
        if (Platform.isAndroid) {
          initLocalNotification(context, message);
          showNotification(message);
        }
      });
    } catch (e) {
      dev.log('FirebaseInit Error ${e.toString()}');
    }
  }

  void showNotification(RemoteMessage message) async {
    try {
      AndroidNotificationChannel channel = AndroidNotificationChannel(
          Random.secure().nextInt(10000000).toString(),
          'High Importance Notification',
          importance: Importance.max);

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: 'Your Channel description',
              importance: Importance.high,
              priority: Priority.high,
              ticker: 'ticker');
      DarwinNotificationDetails darwinNotificationDetails =
          const DarwinNotificationDetails(
              presentAlert: true, presentBadge: true, presentSound: true);

      NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: darwinNotificationDetails);

      try {
        Future.delayed(
          Duration.zero,
          () {
            _flutterLocalNotificationsPlugin.show(
                0,
                message.notification!.title.toString(),
                message.notification!.body.toString(),
                notificationDetails);
          },
        );
      } catch (e) {
        dev.log('Show Notifcation Flutter Local Plugin Errpr ${e.toString()}');
      }
    } catch (e) {
      dev.log('Show Notifcation Error ${e.toString()}');
    }
  }

  // Request For the Permission
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      provisional: true,
      sound: true,
      carPlay: true,
      criticalAlert: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      ('Permission Granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      dev.log('Provisional Permission Granted');
    } else {
      dev.log('Permission denied');
    }
  }

  // Get device Token
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    dev.log(token.toString());
    Apis.updateUserData(token);
    return token!;
  }

  // For Refreshing the Token
  void isTokenRefresh() {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      dev.log('Token Refresh');
    });
  }
}
