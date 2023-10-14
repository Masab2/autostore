import 'dart:io';

import 'package:autostore/Services/firebasehelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPartsViewModel extends GetxController {
  RxString imagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();
  var image;
  Future getImageFromgallery(ImageSource source) async {
    image = await _picker.pickImage(source: source, imageQuality: 80);
    if (image != null) {
      imagePath.value = image.path.toString();
    } else {
      Get.snackbar('Fail', 'No Image Selected');
    }
  }

  void addProduct(
      TextEditingController title,
      TextEditingController category,
      TextEditingController price,
      TextEditingController quan,
      TextEditingController detail) async {
    if (title.text.isEmpty &&
        category.text.isEmpty &&
        price.text.isEmpty &&
        quan.text.isEmpty &&
        detail.text.isEmpty) {
      Get.snackbar('Empty Feilds', 'Please Enter the Data');
    } else if (title.text.isEmpty) {
      Get.snackbar('Empty Feild', 'title Feild is Empty');
    } else if (category.text.isEmpty) {
      Get.snackbar('Empty Feild', 'category Feild is Empty');
    } else if (price.text.isEmpty) {
      Get.snackbar('Empty Feild', 'price Feild is Empty');
    } else if (quan.text.isEmpty) {
      Get.snackbar('Empty Feild', 'quantity Feild is Empty');
    } else if (detail.text.isEmpty) {
      Get.snackbar('Empty Feild', 'detail Feild is Empty');
    } else {
      Apis.addProducts(File(imagePath.value.toString()), title.text,
              category.text, price.text, quan.text, detail.text)
          .then((value) {
        Get.snackbar(
            title.text.toString(), 'Spare Part Published Successfully');
        title.clear();
        price.clear();
        quan.clear();
        detail.clear();
      }).onError((error, stackTrace) {
        Get.snackbar('Error', error.toString());
      });
    }
  }
}
