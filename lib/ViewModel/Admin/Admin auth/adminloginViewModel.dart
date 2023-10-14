import 'package:autostore/res/routes/routes_names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/firebasehelper.dart';

class AdminLoginViewModel extends GetxController {
  bool _founduser = false;
  void adminLogin(
      TextEditingController email, TextEditingController password) async {
    if (email.text.isEmpty && password.text.isEmpty) {
      Get.snackbar('Empty Feilds', 'Please Enter the Data');
    } else if (email.text.isEmpty) {
      Get.snackbar('Empty Feild', 'Email Feild is Empty');
    } else if (password.text.isEmpty) {
      Get.snackbar('Empty Feild', 'Password Feild is Empty');
    } else {
      QuerySnapshot snapshot =
          await Apis.firestore.collection('AdminAccount').get();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data["email"] == email.text && data['password'] == password.text) {
          _founduser = true;
          break;
        }
      }
      if (_founduser == true) {
        Get.offAllNamed(RoutesNames.admindashboardScreen);
      } else {
        Get.snackbar('Invalid user', 'user not found');
      }
    }
  }

  void adminBossLogin(
      TextEditingController email, TextEditingController password) async {
    if (email.text.isEmpty && password.text.isEmpty) {
      Get.snackbar('Empty Feilds', 'Please Enter the Data');
    } else if (email.text.isEmpty) {
      Get.snackbar('Empty Feild', 'Email Feild is Empty');
    } else if (password.text.isEmpty) {
      Get.snackbar('Empty Feild', 'Password Feild is Empty');
    } else {
      try {
        final QuerySnapshot adminSnapshot = await Apis.firestore
            .collection('AdminAccount')
            .where('email', isEqualTo: email.text)
            .where('password', isEqualTo: password.text)
            .limit(1)
            .get();
        if (adminSnapshot.docs.isNotEmpty) {
          Get.offAllNamed(RoutesNames.removeadminScreen);
          Get.snackbar('Login Successfull', 'Congratulations');
          email.clear();
          password.clear();
        } else {
          Get.snackbar(
              'Invalid Credentials', 'Please check your email and password');
        }
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }
  }
}
