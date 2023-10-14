import 'package:autostore/Services/firebasehelper.dart';
import 'package:autostore/res/routes/routes_names.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  void signUpAccount(TextEditingController email,
      TextEditingController password, TextEditingController username) {
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
        Apis.signUpAccount(email.text, password.text, username.text)
            .then((value) {
          Get.toNamed(RoutesNames.verifyScreen);
        }).onError((error, stackTrace) {
          Get.snackbar('Error', error.toString());
        });
      } else {
        Get.snackbar(
            'Error', 'Please Enter the email and password in correct format');
      }
    }
  }
}
