import 'dart:async';

import 'package:autostore/res/routes/routes_names.dart';
import 'package:get/get.dart';

import '../../Services/firebasehelper.dart';

class SplashServices {
  void moveToIntro() {
    if (Apis.auth.currentUser != null) {
      Timer(const Duration(seconds: 4), () {
        Get.offAndToNamed(RoutesNames.bottomScreen);
      });
    } else {
      Timer(const Duration(seconds: 4), () {
        Get.offAndToNamed(RoutesNames.loginScreen);
      });
    }
  }
}
