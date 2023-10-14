import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  void loginAccount(
      TextEditingController email, TextEditingController password) {
    if (email.text.isEmpty && password.text.isEmpty) {
      Get.snackbar('Empty Feilds', 'Please Enter the Data');
    } else if (email.text.isEmpty) {
      Get.snackbar('Empty Feild', 'Email Feild is Empty');
    } else if (password.text.isEmpty) {
      Get.snackbar('Empty Feild', 'Password Feild is Empty');
    } else {
      final RegExp emailRegExp =
          RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
      if (emailRegExp.hasMatch(email.text) && password.text.length >= 6) {
        Apis.loginAccount(email.text, password.text).then((value) {
          Get.offAndToNamed(RoutesNames.bottomScreen);
        }).onError((error, stackTrace) {
          Get.snackbar('Error', error.toString());
        });
      } else {
        Get.snackbar(
            'Error', 'Please Enter the email and password in correct format');
      }
    }
  }

  void logOutAccount() {
    Apis.logOutAccount().then((value) {
      Get.offAllNamed(RoutesNames.loginScreen);
    }).onError((error, stackTrace) {
      Get.snackbar('Error', error.toString());
    });
  }
}
