import 'package:autostore/Utility/app/AppUrl.dart';
import 'package:autostore/Utility/const/const.dart';
import 'package:autostore/data/Network/NetworkApiServices.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/firebasehelper.dart';

class NotificationViewModel extends GetxController {
  final NetworkApiServices _api = NetworkApiServices();

  // For Specified User
  void sendNotification(var title, var body, token) {
    if (token != null) {
      _api.getPostApiServies(AppUrl.baseUrl, {
        'to': token,
        'priority': 'high',
        'notification': {'title': title.toString(), 'body': body.toString()}
      });
    } else {
      debugPrint('User not found or FCM token not available');
    }
  }

  Future<void> sendNotificationToAll(
      TextEditingController title, TextEditingController body) async {
    if (title.text.toString().isEmpty && body.text.toString().isEmpty) {
      Get.snackbar('Empty Feilds', 'Please Enter the Data');
    } else if (title.text.toString().isEmpty) {
      Get.snackbar('Empty Feilds', 'Please Enter the Data');
    } else if (body.text.toString().isEmpty) {
      Get.snackbar('Empty Feilds', 'Please Enter the Data');
    } else {
      try {
        final usersCollection =
            await Apis.firestore.collection(userInfoCollection).get();

        for (final userDoc in usersCollection.docs) {
          final userData = userDoc.data();
          final fcmToken = userData['token'] as String;
          if (fcmToken.isNotEmpty) {
            await _api.getPostApiServies(AppUrl.baseUrl, {
              'to': fcmToken,
              'priority': 'high',
              'notification': {'title': title.text, 'body': body.text}
            });
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error sending notification to all users: $e');
        }
      }
    }
  }
}
